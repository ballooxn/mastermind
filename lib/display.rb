class Display
  def intro
    puts "Welcome to Mastermind!"
  end

  def display_all_guesses(board)
    board.length.times do |i|
      puts board[i]
    end
  end

  def display_feedback(correct, misplaced)
    puts "#{correct} correct, #{misplaced} misplaced."
  end
end
