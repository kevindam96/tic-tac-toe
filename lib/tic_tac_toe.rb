# frozen_string_literal: true

TIC_TAC_TOE_X = 'X'
TIC_TAC_TOE_O = 'O'

# Responsible for returning and changing the state of the game board
class BoardModel
  attr_reader :moves, :spaces

  def initialize
    @moves = {}
    @spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def make_move(space_number)
    symbol = next_symbol
    @moves[space_number] = symbol
    @spaces[space_number - 1] = symbol
  end

  def format_board
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

  private

  def next_symbol
    @moves.length.even? ? TIC_TAC_TOE_X : TIC_TAC_TOE_O
  end
end

# Responsible for displaying the game board to the user
class BoardView
  def initialize
    @board = "      |     |     \n"\
      "   1  |  2  |  3  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   4  |  5  |  6  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   7  |  8  |  9  \n"\
      '      |     |     '
  end

  def render(board_model)
    refresh_board(board_model)
    puts @board
  end

  def refresh_board(board_model)
    @board = board_model.format_board
  end

  def to_s
    @board
  end
end

# Responsible for control of the flow of the game,
# updating the model and calling the view when appropriate
class BoardController
  def initialize; end

  def new_game
    puts 'Tic-Tac-Toe! Please enter a number 1 - 9 to begin:'
  end
end
