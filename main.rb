require './constant/main_constant'

class Main
  include MainConstant

  def initialize(frames)
    @frames = frames
    @rolls = @frames.flatten
    @max_attempts = CONFIG[:max_attempts]

    validate()
  end

  def score
    total = 0
    index = 0

    @max_attempts.times do
      if strike?(index)
        total += @max_attempts + next_two_rolls(index)
        index += 1
      elsif spare?(index)
        total += @max_attempts + next_roll(index + 2)
        index += 2
      else
        total += frame_score(index)
        index += 2
      end
    end

    total
  end

  private
    def validate
      raise ArgumentError, LABEL[:collection_cant_be_empty] unless frame_must_be_greater_than_zero
      raise ArgumentError, LABEL[:collection_must_be_ten] unless frame_must_be_ten_data 
      raise ArgumentError, LABEL[:collection_must_has_all_numbers] unless frame_must_has_all_numbers
      raise ArgumentError, LABEL[:collection_contains_more_than_two_pairs] unless frame_contains_more_than_two_pairs_except_last 
    end

    ######## Validation ########

    def frame_must_be_greater_than_zero 
      @frames.size > 0
    end

    def frame_must_be_ten_data
      @frames.size == @max_attempts
    end

    def frame_must_has_all_numbers
      @rolls.all? { |n| n.is_a?(Integer) } 
    end

    def frame_contains_more_than_two_pairs_except_last
      @frames[0...-1].all? { |frame| frame.is_a?(Array) && frame.length <= 2 } && 
      @frames.last.is_a?(Array) && 
      @frames.last.length == 3 
    end

    ######## Score Calculation ########

    def strike?(i)
      roll(i) == @max_attempts
    end

    def spare?(i)
      roll(i) + roll(i + 1) == @max_attempts
    end

    def next_two_rolls(i)
      roll(i + 1) + roll(i + 2)
    end

    def next_roll(i)
      roll(i)
    end

    def frame_score(i)
      roll(i) + roll(i + 1)
    end

    def roll(i)
      @rolls[i].to_i
    end
end