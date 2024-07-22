module Computer
  def self.choose_starting_code(color_choices)
    selected_code = []
    4.times do
      selected_code.push(color_choices.sample)
    end
    selected_code
  end

  def self.choose_guess(board, color_choices, correct_array)
    guess = []
    if board.empty?
      # first guess of the game, no feedback to go over.
      4.times do
        guess.push(color_choices.sample)
      end
    else
      4.times do |index|
        if board[-1][index] == correct_array[index]
          guess[index] = correct_array[index]
        else
          guess.push(color_choices.sample)
        end
      end
    end
    guess
  end
end
