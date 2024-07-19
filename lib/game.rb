require_relative "display"
require_relative "computer"

class Game
  include Computer
  include Display

  @@color_choices = %w[red blue yellow green pink purple orange]
  def initialize
    @board = []
    @selected_code = Computer.choose_starting_code(@@color_choices)
    @guess = []
  end

  def start_game
    puts @selected_code
    Display.intro(@@color_choices)
    Display.choose_your_guess
    choose_guess
    p @guess
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

  def make_feedback
    @guess
  end

  def add_guess_to_board
    array = @guess.split(" ")
    @board.push
  end
end
