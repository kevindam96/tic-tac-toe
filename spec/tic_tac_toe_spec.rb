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
end

describe Game do
  describe '#new_round' do
    game = Game.new
    it 'announces the game displays a new game board' do
      expect { game.new_round }.to output(
        "Tic-Tac-Toe!\n"\
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   7  |  8  |  9  \n"\
        "      |     |     \n"\
      ).to_stdout
    end
  end

  describe '#next_move' do
    game = Game.new
    let(:input1) { StringIO.new('7') }
    let(:input2) { StringIO.new('5') }
    let(:input3) { StringIO.new('3') }
    let(:input4) { StringIO.new('3') }
    let(:input5) { StringIO.new('0') }

    it 'gets the first move, the second move, the third move, '\
      'and handles the already selected fourth move and invalid fifth move' do
      $stdin = input1
      expect { game.next_move }.to output(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout

      $stdin = input2
      expect { game.next_move }.to output(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TicTacToe::O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout

      $stdin = input3
      expect { game.next_move }.to output(
        "      |     |     \n"\
        "   1  |  2  |  #{TicTacToe::X}  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TicTacToe::O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TicTacToe::X}  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout

      $stdin = input4
      expect { game.next_move }.to output(
        "Space has already been selected. Please select one of: [1, 2, 4, 6, 8, 9]\n"
      ).to_stdout

      $stdin = input5
      expect { game.next_move }.to output(
        "Invalid space. Please select one of: [1, 2, 4, 6, 8, 9]\n"
      ).to_stdout

      $stdin = STDIN
    end
  end

  describe '#winner' do
    game = Game.new
    game.new_round
    it 'returns nil when there is no winner or tie yet' do
      game.winner
    end
  end
end
# rubocop: enable Metrics/BlockLength
