require_relative "lib/display"
require_relative "lib/computer"
require_relative "lib/player"

class Game
  include Computer
  include Display
  include Player

  COLOR_CHOICES = %w[Red Orange Yellow Green Blue Pink Purple].freeze
  MAX_NUMBER_OF_GUESSES = 12

  def initialize
    @computer_score = 0
    @human_score = 0

    @guesses = 0
    @role = nil
    @winner = nil

    @board = []
  end

  def start_game
    Display.intro
    choose_role
    return if role == "exit"

    game_loop
  end

  def choose_role
    until role == "coder" || role == "breaker" || role == "exit"
      Display.choose_role
      @role = gets.chomp.downcase
    end
  end

  def game_loop
    until @winner || @guesses >= MAX_NUMBER_OF_GUESSES
      guess = nil

      guess = obtain_guess until valid_guess?(guess)

      place_guess_on_board(guess)
      # Feedback = {correct: 0, misplaced: 0, incorrect: 0}
      feedback = evaluate_guess(guess)
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
