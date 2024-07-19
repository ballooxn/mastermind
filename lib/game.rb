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
    @selected_code = Computer.choose_starting_code(@@color_choices)
    @guess = []
    @feedback_array = []
  end

  def start_game
    puts @selected_code
    Display.intro(@@color_choices)
    breaker_game_loop
  end

  def breaker_game_loop
    winner = "Creator"
    game_over = false
    until game_over
      Display.choose_your_guess
      choose_guess
      @board.push(@guess)
      feedback = make_feedback
      Display.display_feedback(feedback[0], feedback[1])
      Display.display_all_guesses(@board, @feedback_array)

      if feedback[0] == 4 # correct guesses
        winner = "Breaker"
        break
      end
      break if @board.length > 3
    end
    end_game(winner)
  end

  def choose_guess
    choosing_guess = true
    while choosing_guess
      @guess = gets.chomp.downcase.split # this is an array
      unless @guess.length == 4
        puts "Error! Put in four selectable colors seperated by spaces"
        next
      end

      count = 0
      @guess.each do |i|
        count += 1 if @@color_choices.include?(i)
      end
      break if count == 4

      puts "Error! Put in four colors from this list: #{@@color_choices}"
    end
  end

  def end_game(winner)
    Display.end_game_display(winner)
    play_again = gets.chomp.downcase
    Game.new.start_game if play_again == "y"
  end

  def make_feedback
    correct = 0
    misplaced = 0
    @guess.each_with_index do |color, index|
      next unless @selected_code.include?(color)

      if @guess[index] == @selected_code[index]
        correct += 1
        next
      end
      misplaced += 1
    end
    arr = [correct, misplaced]
    @feedback_array.push(arr) # This array is used for the display_board method in Display
    arr
  end
end
