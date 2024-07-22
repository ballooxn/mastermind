module Display
  def self.intro(colors)
    puts "Welcome to Mastermind!"
    puts "In this game, you must guess the correct code that is chosen by the computer."
    puts "To make a guess, simply type in four colors seperated by spaces."
    puts "Example: Red Blue Green Orange"
    puts "These are the colors you can pick:"
    colors.each do |color|
      print "#{color}, "
    end
    puts ""
  end

  def self.choose_your_guess
    puts "\nMake your guess!"
  end

  def self.display_all_guesses(board, feedback_array)
    puts ""
    board.each_with_index do |v, i|
      print "|"
      v.each_with_index do |value, index|
        print index == 3 ? value.to_s : "#{value}, "
      end
      print "| #{feedback_array[i][0]} correct, #{feedback_array[i][1]} misplaced\n"
    end
  end

  def self.display_feedback(correct, misplaced)
    puts "#{correct} correct, #{misplaced} misplaced."
  end

  def self.end_game_display(winner)
    puts "#{winner} is the winner!"
    puts "\nWould you like to play again? y/n"
  end

  def self.computer_choosing_guess
    puts "The computer is choosing it's guess..."
  end
end
