# frozen_string_literal: true

# Responsible for returning and changing the state of the game board
class Board
  def initialize
    @moves = {}
    @spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def make_move(space_number)
    if TicTacToe.invalid_space?(space_number)
      puts "Invalid space. Please select one of: #{available_spaces}"
    elsif !available_spaces.include?(space_number)
      puts "Space has already been selected. Please select one of: #{available_spaces}"
    else
      update_board_after_move(space_number)
      puts to_s
    end
  end

  def to_s
    "      |     |     \n"\
      "   #{@spaces[0]}  |  #{@spaces[1]}  |  #{@spaces[2]}  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   #{@spaces[3]}  |  #{@spaces[4]}  |  #{@spaces[5]}  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   #{@spaces[6]}  |  #{@spaces[7]}  |  #{@spaces[8]}  \n"\
      '      |     |     '
  end

  def move_count
    @moves.length
  end

  private

  def next_symbol
    @moves.length.even? ? TicTacToe::X : TicTacToe::O
  end

  def update_board_after_move(space_number)
    symbol = next_symbol
    @moves[space_number] = symbol
    @spaces[space_number - 1] = symbol
  end

  def available_spaces
    @spaces.reject { |space| TicTacToe.symbol?(space) }
  end
end

# Responsible for control of the flow of the game,
# updating the model and calling the view when appropriate
class Game
  def initialize
    @board = Board.new
  end

  def new_round
    puts 'Tic-Tac-Toe!'
    puts @board
  end

  def next_move
    space_number = if @board.move_count.even?
                     gets 'Player 1! Please select a space (1 - 9): '
                   else
                     gets 'Player 2! Please select a space (1 - 9): '
                   end
    @board.make_move(space_number.chomp.to_i)
  end
end

# Constants and helper functions
module TicTacToe
  X = 'X'
  O = 'O'

  def self.invalid_space?(space_number)
    !(space_number.positive? && space_number < 10)
  end

  def self.symbol?(symbol)
    (symbol.eql?(X) || symbol.eql?(O))
  end
end
