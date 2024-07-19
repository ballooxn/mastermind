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
    @board.push(@guess)
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
    correct = 0
    is_correct = false
    misplaced = 0
    @guess.each_with_index do |color, index|
      next unless @selected_code.include?(color)

      @selected_code.each_with_index do |_, i|
        next unless @guess[index] == @selected_code[i]

        correct += 1
        is_correct = true
        break
      end
      misplaced += 1 if is_correct == false
      is_correct = false
    end
  end
end
