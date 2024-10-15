module Display
  COLOR_CHOICES = %w[Red Orange Yellow Green Blue Pink Purple].freeze

  def self.intro
    puts "Welcome to Mastermind!"
  end

  def self.choose_role
    puts "Enter in whether you wish to be the 'coder' or the 'breaker'! Or you can type 'exit' to exit the program."
  end

  def self.choose_guess
    puts "Type in your guess! Your guess must be four of the following colors seperated by spaces."
    p COLOR_CHOICES
  end

  def self.choose_code
    puts "Choose your code! Your code must be four of the following colors seperated by spaces."
    p COLOR_CHOICES
  end

  def self.display_board(board)
    puts ""
    board.each do |row|
      if row.is_a?(Array)
        p row
      else
        puts row
      end
    end
    puts ""
  end

  def self.breaker_win
    puts "\nCongrats! The Code Breaker has won the game by correctly guessing the code!"
  end

  def self.coder_win
    puts "\nCongrats! The Code Maker has won the game!"
  end

  def self.play_again?
    puts "Would you like to play again?"
  end
end
