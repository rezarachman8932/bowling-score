require_relative '../main'
require "byebug"

# frozen_string_literal: true

RSpec.describe Main do
   it 'scores a game with strikes, spares, and open frames' do
    frames = [[5,3], [10], [4,6], [3,2], [10], [10], [5,5], [0,10], [10], [10,10,10]]
    game = Main.new(frames)
    expect(game.score).to eq(181)
  end

  it 'scores a perfect game (12 strikes)' do
    frames = [[10]] * 9 + [[10, 10, 10]]
    game = Main.new(frames)
    expect(game.score).to eq(300)
  end

  it 'scores all spares with 5s and final bonus 5' do
    frames = [[5,5]] * 9 + [[5,5,5]]
    game = Main.new(frames)
    expect(game.score).to eq(150)
  end

  it 'scores all open frames' do
    frames = [[3,4]] * 10
    game = Main.new(frames)
    expect(game.score).to eq(70)
  end

  it 'handles edge case: empty game' do
    frames = []
    game = Main.new(frames)
    expect(game.score).to eq(0)
  end
end
