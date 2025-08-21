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

  it 'scores all open frames except the last' do
    frames = [[3,4]] * 9 + [[10,10,10]]
    game = Main.new(frames)
    expect(game.score).to eq(93)
  end

  it 'throw an error when the frame is empty' do
    frames = []
    error = nil
    begin
      game = Main.new(frames)
      game.score
    rescue => e
      error = e
    end
    expect(error).to be_a(ArgumentError)
    expect(error.message).to eq("Collection can't be empty!")
  end

  it 'throw an error when the frame contains less than 10 data' do
    frames = [[5,3], [10,10,10]]
    error = nil
    begin
      game = Main.new(frames)
      game.score
    rescue => e
      error = e
    end
    expect(error).to be_a(ArgumentError)
    expect(error.message).to eq("Collection should has 10 data either single or set of number!")
  end

  it 'throw an error when the frame has at least one non-integer' do
    frames = [[5,3], [10], [4,'a'], [3,false], [10], [10], [5,5], [0,10], [10], [10,10,10]]
    error = nil
    begin
      game = Main.new(frames)
      game.score
    rescue => e
      error = e
    end
    expect(error).to be_a(ArgumentError)
    expect(error.message).to eq("Collection contains non-integer elements!")
  end

  it 'throw an error when the frame either consist of more than two pairs 1-9 or not three pairs in the last' do
    frames = [[5,3], [10], [4,6], [3,2,5], [10], [10], [5,5], [0,10], [10], [10,10,10]]
    error = nil
    begin
      game = Main.new(frames)
      game.score
    rescue => e
      error = e
    end
    expect(error).to be_a(ArgumentError)
    expect(error.message).to eq("Collection should contains one or two pairs and three pairs in the last!")
  end
end