# frozen_string_literal: true

require '../lib/tic_tac_toe'

TIC_TAC_TOE_X = 'X'
TIC_TAC_TOE_O = 'O'

# rubocop: disable Metrics/BlockLength
describe BoardModel do
  describe '#make_move' do
    board_model = BoardModel.new
    board_view = BoardView.new
    board_controller = BoardController.new
    it 'sets space number 7 to "x" if the first player chooses space number 7' do
      board_model.make_move(7)
      expect(board_model.moves).to eql({ 7 => TIC_TAC_TOE_X })
      expect(board_model.spaces).to eql([1, 2, 3, 4, 5, 6, TIC_TAC_TOE_X, 8, 9])
    end

    it 'sets space number 5 to "o" if the second player chooses space number 5' do
      board_model.make_move(5)
      expect(board_model.moves).to eql({ 7 => TIC_TAC_TOE_X, 5 => TIC_TAC_TOE_O })
      expect(board_model.spaces).to eql([1, 2, 3, 4, TIC_TAC_TOE_O, 6, TIC_TAC_TOE_X, 8, 9])
    end
  end

  describe '#format_board' do
    board_model = BoardModel.new
    board_view = BoardView.new
    board_controller = BoardController.new
    it 'updates the board as moves are made' do
      board_model.make_move(7)
      board_view.refresh_board(board_model)
      expect(board_view.to_s).to eql("      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TIC_TAC_TOE_X}  |  8  |  9  \n"\
        '      |     |     ')
      board_model.make_move(5)
      board_view.refresh_board(board_model)
      expect(board_view.to_s).to eql("      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TIC_TAC_TOE_O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TIC_TAC_TOE_X}  |  8  |  9  \n"\
        '      |     |     ')
    end
  end
end
# rubocop: enable Metrics/BlockLength

# rubocop: disable Metrics/BlockLength
describe BoardView do
  describe '#render' do
    board_model = BoardModel.new
    board_view = BoardView.new
    board_controller = BoardController.new
    it 'renders the tic-tac-toe board on the console' do
      expect { board_view.render(board_model) }.to output(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   7  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout
    end

    it 'renders the tic-tac-toe board when the player makes the first move, filling in space 7' do
      board_model.make_move(7)
      board_view.refresh_board(board_model)
      expect { board_view.render(board_model) }.to output(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  5  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TIC_TAC_TOE_X}  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout
    end

    it 'renders the tic-tac-toe board when the second player makes the second move, filling in space 5' do
      board_model.make_move(5)
      board_view.refresh_board(board_model)
      expect { board_view.render(board_model) }.to output(
        "      |     |     \n"\
        "   1  |  2  |  3  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   4  |  #{TIC_TAC_TOE_O}  |  6  \n"\
        " _____|_____|_____\n"\
        "      |     |     \n"\
        "   #{TIC_TAC_TOE_X}  |  8  |  9  \n"\
        "      |     |     \n"
      ).to_stdout
    end
  end
end
# rubocop: enable Metrics/BlockLength
