class Main
  def initialize(frames)
    @rolls = frames.flatten
  end

  def score
    total = 0
    index = 0

    10.times do
      if strike?(index)
        total += 10 + next_two_rolls(index)
        index += 1
      elsif spare?(index)
        total += 10 + next_roll(index + 2)
        index += 2
      else
        total += frame_score(index)
        index += 2
      end
    end

    total
  end

  private

    def strike?(i)
      roll(i) == 10
    end

    def spare?(i)
      roll(i) + roll(i + 1) == 10
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