# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'

def game_loop(board)
  winner = board.winner
  unless winner.nil?
    announce_result(winner)
    return true
  end

  puts board.to_s
  prompt_next_move(board)

  false
end

def prompt_new_game
  loop do
    puts 'Would you like to play again? (Y/N)'
    ans = gets.chomp.upcase

    break if ans.eql?('Y') || ans.eql?('N')
  end

  ans.eql?('Y')
end

def prompt_next_move(board)
  if board.move_count.even?
    puts 'Player 1! Please select a space (1 - 9)'
  else
    puts 'Player 2! Please select a space (1 - 9)'
  end
  space_number = gets.chomp.to_i
  board.make_move(space_number)
end

def announce_result(result)
  if result.eql?(TicTacToe::X)
    puts 'Player One wins!'
  elsif result.eql?(TicTacToe::O)
    puts 'Player Two wins!'
  elsif result.eql?(TicTacToe::TIE)
    puts 'It\'s a tie!'
  end
end

puts 'Tic-Tac-Toe!'

game_over = false
board = Board.new
loop do
  game_over = game_loop(board)
  play_again = prompt_new_game if game_over
  break if game_over && !play_again

  game_over = false
  board = Board.new if play_again
end

puts 'Thanks for playing!'
