# Bowling Score Generator

This project calculates the score of a bowling game from a series of frames using clean, tested Ruby code.

## Usage

```ruby
require_relative '../main'
require "byebug"

# Sample Case
game = Main.new([[5,3], [10], [4,6], [3,2], [10], [10], [5,5], [0,10], [10], [10,10,10]])
puts game.score  # => 181
```

## Running Test

```bash
bundle exec rspec
```

## Features

- Supports strikes, spares, and open frames.
- Correctly calculates bonus rolls in the 10th frame.
- Fully tested with RSpec.




