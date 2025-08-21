require './constant/main_constant'

class Main
  include MainConstant

  def initialize(frames)
    @frames = frames
    @rolls = @frames.flatten
    @max_attempts = CONFIG[:max_attempts]
  end

  def score
    validate()
    
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
      raise ArgumentError, "Collection can't be empty!" unless @frames.size > 0
      raise ArgumentError, "Collection should has 10 data either single or set of number!" unless @frames.size == @max_attempts 
      raise ArgumentError, "Collection contains non-integer elements!" unless @rolls.all? { |n| n.is_a?(Integer) }
    end

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