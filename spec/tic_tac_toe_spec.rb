# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'

# rubocop: disable Metrics/BlockLength
describe Board do
  describe '#to_s' do
    it 'returns the tic-tac-toe board string representation' do
      board = Board.new
      expect(board.to_s).to eql(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   7  |  8  |  9  \n"\
        '      |     |     '
      )
    end
  end

  describe '#make_move' do
    it 'updates the tic-tac-toe board when the player makes the first move, filling in space 7' do
      board = Board.new
      board.make_move(7)
      expect(board.to_s).to eql(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        '      |     |     '
      )
    end

    it 'updates the tic-tac-toe board when the second player makes their move, filling in space 5' do
      board = Board.new
      board.make_move(7)
      board.make_move(5)
      expect(board.to_s).to eql(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TicTacToe::O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        '      |     |     '
      )
    end

    it 'does nothing if any player chooses an invalid space' do
      board = Board.new
      board.make_move(7)
      board.make_move(5)
      board.make_move(0)
      expect(board.to_s).to eql(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TicTacToe::O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        '      |     |     '
      )
    end
  end

  describe '#winner' do
    it 'returns nil when there is no winner or tie yet' do
      board = Board.new
      expect(board.winner).to eql(nil)
    end

    it 'returns X when Player 1 wins diagonally 1-5-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 2, 5, 3, 9])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins diagonally 1-5-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [2, 1, 3, 5, 4, 9])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins diagonally 3-5-7' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [3, 4, 5, 6, 7])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins diagonally 3-5-7' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [2, 3, 6, 5, 4, 7])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins horizontally 1-2-3' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 4, 2, 5, 3])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins horizontally 1-2-3' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [4, 1, 5, 2, 7, 3])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins horizontally 4-5-6' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [4, 1, 5, 2, 6])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins horizontally 4-5-6' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 4, 2, 5, 7, 6])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins horizontally 7-8-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [7, 4, 8, 5, 9])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins horizontally 7-8-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [4, 7, 6, 8, 2, 9])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins vertically 1-4-7' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 2, 4, 3, 7])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins vertically 1-4-7' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [2, 1, 3, 4, 8, 7])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins vertically 2-5-8' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [2, 1, 5, 3, 8])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins vertically 2-5-8' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 2, 3, 5, 4, 8])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns X when Player 1 wins vertically 3-6-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [3, 1, 6, 2, 9])
      expect(board.winner).to eql(TicTacToe::X)
    end

    it 'returns O when Player 2 wins vertically 3-6-9' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [1, 3, 2, 6, 4, 9])
      expect(board.winner).to eql(TicTacToe::O)
    end

    it 'returns Tie when neither player wins and there are no vacant spaces' do
      board = Board.new
      TicTacToeSpecHelper.make_moves(board, [5, 1, 3, 7, 4, 6, 8, 2, 9])
      expect(board.winner).to eql(TicTacToe::TIE)
    end
  end
end
# rubocop: enable Metrics/BlockLength

# Helper functions for use in testing and specification
module TicTacToeSpecHelper
  def self.make_moves(board, space_numbers)
    space_numbers.each { |space_number| board.make_move space_number }
  end
end
