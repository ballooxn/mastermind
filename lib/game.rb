require_relative "display"
require_relative "computer"
require_relative "player"

class Game
  include Computer
  include Display
  include Player

  @@color_choices = %w[red blue yellow green pink purple orange]
  def initialize
    @board = []
    @selected_code = []
    @guess = []
    @feedback_array = []
    @computer_breaking = false
    @winner = "Creator"
    @correct_array = []
  end

  def start_game
    Display.intro(@@color_choices)
    puts "\nWould you like to play as the Breaker or the Creator? b/c"
    answer = gets.chomp.downcase
    if answer == "b"
      breaker_game_loop
    elsif answer == "c"
      creator_game_loop
    else
      puts "ERROR!"
    end
  end

  def creator_game_loop
    puts "Create a code of 4 colors seperated by spaces."
    create_code
    game_over = false
    @computer_breaking = true

    until game_over
      Display.computer_choosing_guess
      sleep(1)
      feedback = []
      @guess = Computer.choose_guess(@board, @@color_choices, @correct_array)
      @board.push(@guess)
      feedback = make_feedback
      puts "Computer chose... #{@guess}"
      Display.display_feedback(feedback[0], feedback[1])
      sleep(2)
      Display.display_all_guesses(@board, @feedback_array)

      if feedback[0] == 4 # correct guesses
        @winner = "Breaker"
        break
      end
      break if @board.length >= 12
    end
    end_game
  end

  def create_code
    while true
      @selected_code = gets.chomp.downcase.split(" ")
      unless @selected_code.length == 4
        puts "Error! Put in four selectable colors seperated by spaces"
        next
      end

      break if valid?(@selected_code)

      puts "Error! Put in four selectable colors seperated by spaces"
    end
  end

  def breaker_game_loop
    @selected_code = Computer.choose_starting_code(@@color_choices)
    puts @selected_code

    game_over = false
    until game_over
      Display.choose_your_guess
      choose_guess
      @board.push(@guess)
      feedback = make_feedback
      Display.display_feedback(feedback[0], feedback[1])
      Display.display_all_guesses(@board, @feedback_array)

      if feedback[0] == 4 # correct guesses
        @winner = "Breaker"
        break
      end
      break if @board.length >= 12
    end
    end_game
  end

  # Checks if the code is valid, returns true if it is.
  def valid?(array)
    count = 0
    array.each do |i|
      count += 1 if @@color_choices.include?(i)
    end
    return true if count == 4

    false
  end

  def choose_guess
    choosing_guess = true
    while choosing_guess
      @guess = gets.chomp.downcase.split # this is an array
      unless @guess.length == 4
        puts "Error! Put in four selectable colors seperated by spaces"
        next
      end

      break if is_valid?(@guess)

      puts "Error! Put in four colors from this list: #{@@color_choices}"
    end
  end

  def end_game
    Display.end_game_display(@winner)
    play_again = gets.chomp.downcase
    Game.new.start_game if play_again == "y"
  end

  def make_feedback
    correct = 0
    misplaced = 0
    @guess.each_with_index do |color, index|
      next unless @selected_code.include?(color)

      if @guess[index] == @selected_code[index]
        @correct_array[index] = color if @computer_breaking
        correct += 1
        next
      end
      @correct_array[index] = "_" if @computer_breaking
      misplaced += 1
    end
    arr = [correct, misplaced]
    @feedback_array.push(arr) # This array is used for the display_board method in Display

    arr
  end
end
