# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/tic_tac_toe'

puts 'Tic-Tac-Toe!'

game_over = false
board = Board.new
loop do
  game_over = TicTacToe.game_loop(board)
  play_again = TicTacToe.prompt_new_game if game_over
  break if game_over && !play_again

  game_over = false
  board = Board.new if play_again
end

puts 'Thanks for playing!'
