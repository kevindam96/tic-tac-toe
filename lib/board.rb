# frozen_string_literal: true

# Responsible for returning and changing the state of the game board
class Board
  def initialize
    @moves = {}
    9.times do |num|
      space_number = num + 1
      @moves[space_number] = space_number
    end
  end

  def available_spaces
    [1, 2, 3, 4, 5, 6, 7, 8, 9].reject { |space| TicTacToe.symbol?(symbol_on_space(space)) }
  end

  def make_move(space_number)
    return if TicTacToe.invalid_space?(space_number) || !available_spaces.include?(space_number)

    update_board_after_move(space_number)
  end

  def winner
    check_diagonal_for_winner ||
      check_horizontal_for_winner ||
      check_vertical_for_winner ||
      check_for_tie
  end

  def to_s
    "      |     |     \n"\
      "   #{@moves[1]}  |  #{@moves[2]}  |  #{@moves[3]}  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   #{@moves[4]}  |  #{@moves[5]}  |  #{@moves[6]}  \n"\
      " _____|_____|_____\n"\
      "      |     |     \n"\
      "   #{@moves[7]}  |  #{@moves[8]}  |  #{@moves[9]}  \n"\
      '      |     |     '
  end

  def move_count
    @moves.values.reduce(0) do |count, space_val|
      TicTacToe.symbol?(space_val) ? count + 1 : count
    end
  end

  private

  def next_symbol
    move_count.even? ? TicTacToe::X : TicTacToe::O
  end

  def update_board_after_move(space_number)
    symbol = next_symbol
    @moves[space_number] = symbol
  end

  def check_horizontal_for_winner
    check_three_spaces([1, 2, 3]) ||
      check_three_spaces([4, 5, 6]) ||
      check_three_spaces([7, 8, 9])
  end

  def check_vertical_for_winner
    check_three_spaces([1, 4, 7]) ||
      check_three_spaces([2, 5, 8]) ||
      check_three_spaces([3, 6, 9])
  end

  def check_diagonal_for_winner
    check_three_spaces([1, 5, 9]) ||
      check_three_spaces([3, 5, 7])
  end

  def check_for_tie
    all_symbols = @moves.values.reduce do |acc, space|
      acc && TicTacToe.symbol?(space)
    end

    all_symbols ? TicTacToe::TIE : nil
  end

  def check_three_spaces(space_numbers)
    symbol_on_space_one = symbol_on_space(space_numbers[0])
    symbol_on_space_two = symbol_on_space(space_numbers[1])
    return nil unless symbol_on_space_one.eql?(symbol_on_space_two)
    return nil unless symbol_on_space_two.eql?(symbol_on_space(space_numbers[2]))

    symbol_on_space_one
  end

  def symbol_on_space(space_number)
    @moves[space_number]
  end
end
