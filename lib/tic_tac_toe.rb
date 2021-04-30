# frozen_string_literal: true

# Helper functions and constants
module TicTacToe
  X = :X
  O = :O
  TIE = :Tie

  def self.invalid_space?(space_number)
    !(space_number.positive? && space_number < 10)
  end

  def self.symbol?(symbol)
    (symbol.eql?(X) || symbol.eql?(O))
  end

  def self.game_loop(board)
    winner = board.winner
    unless winner.nil?
      announce_result(winner)
      return true
    end

    puts board.to_s
    prompt_next_move(board)

    false
  end

  def self.prompt_new_game
    ans = ''
    loop do
      puts 'Would you like to play again? (Y/N)'
      ans = gets.chomp.upcase

      break if ans.eql?('Y') || ans.eql?('N')
    end

    ans.eql?('Y')
  end

  def self.prompt_next_move(board)
    if board.move_count.even?
      puts 'Player 1! Please select a space (1 - 9)'
    else
      puts 'Player 2! Please select a space (1 - 9)'
    end
    space_number = gets.chomp.to_i
    board.make_move(space_number)
  end

  def self.announce_result(result)
    if result.eql?(TicTacToe::X)
      puts 'Player One wins!'
    elsif result.eql?(TicTacToe::O)
      puts 'Player Two wins!'
    elsif result.eql?(TicTacToe::TIE)
      puts 'It\'s a tie!'
    end
  end
end
