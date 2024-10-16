require_relative "display"
require_relative "computer"
require_relative "player"

class Game
  include Computer
  include Display
  include Player

  COLOR_CHOICES = %w[red orange yellow green blue pink purple].freeze
  MAX_NUMBER_OF_GUESSES = 12

  def initialize
    @computer_score = 0
    @human_score = 0

    @guesses = 0
    @role = nil
    @winner = nil

    @code = []
    @board = []
  end

  def start_game
    Display.intro
    choose_role
    return if @role == "exit"

    @code = choose_code until valid_guess_or_code?(@code)
    p @code
    game_loop
  end

  def choose_role
    until @role == "coder" || @role == "breaker" || @role == "exit"
      Display.choose_role
      @role = gets.chomp.downcase
    end
  end

  def choose_code
    if @role == "coder"
      Player.choose_code
    else
      Computer.choose_code end
  end

  def game_loop
    until @winner || @guesses >= MAX_NUMBER_OF_GUESSES

      guess = nil
      guess = obtain_guess until valid_guess_or_code?(guess)

      # Feedback = {correct: 0, misplaced: 0}
      feedback = evaluate_guess(guess)
      place_guess_on_board(guess, feedback)
      Display.display_board(@board)
      # end game if the guess was correct
      @winner = true if feedback[:correct] == 4

      @guesses += 1
    end
    end_game
  end

  def obtain_guess
    if @role == "breaker"
      Player.choose_guess
    else
      Computer.choose_guess end
  end

  def valid_guess_or_code?(guess)
    return false if guess.nil?
    return false unless guess.length == 4

    return false unless guess.all? { |v| COLOR_CHOICES.include?(v) }

    true
  end

  def evaluate_guess(guess)
    feedback = { correct: 0, misplaced: 0 }
    guess.each_with_index do |color, index|
      if @code[index] == color
        feedback[:correct] += 1
        next
      elsif @code.include?(color)
        feedback[:misplaced] += 1
        next
      end
    end

    feedback
  end

  def place_guess_on_board(guess, feedback)
    @board.push(guess)
    @board.push("Correct: #{feedback[:correct]}, Misplaced: #{feedback[:misplaced]}")
  end

  def end_game
    if @guesses >= MAX_NUMBER_OF_GUESSES && !@winner
      Display.coder_win
    else
      Display.breaker_win
    end

    Display.play_again?
    answer = gets.chomp.downcase
    return unless answer == "y" || answer == "yes" # rubocop:disable Style/MultipleComparison

    Game.new.start_game
  end
end
