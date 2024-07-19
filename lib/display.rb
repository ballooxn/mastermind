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
  end

  def self.choose_your_guess
    puts "\nMake your guess!"
  end

  def self.display_all_guesses(board, feedback_array)
    board.each do |i|
      print "|"
      i.each_with_index do |j, index|
        print index == 3 ? j.to_s : "#{j}, "
      end
      print "| #{feedback_array[0]} correct, #{feedback_array[1]} misplaced\n"
    end
  end

  def self.display_feedback(correct, misplaced)
    puts "#{correct} correct, #{misplaced} misplaced."
  end

  def self.end_game_display(winner)
    puts "#{winner} is the winner!"
    puts "\nWould you like to play again? y/n"
  end
end
