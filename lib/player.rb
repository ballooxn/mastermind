require_relative "display"

module Player
  include Display

  def self.choose_code
    Display.choose_code
    gets.chomp.downcase
  end

  def self.choose_guess
    Display.choose_guess
    gets.chomp.downcase
  end
end
