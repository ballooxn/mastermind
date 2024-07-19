require_relative "display"
require_relative "computer"

class Game
  def initialize
    @board = []
    @selected_code = Computer.choose_starting_code
  end

  def start_game
    puts @selected_code
  end
end
