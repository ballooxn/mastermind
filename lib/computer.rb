module Computer
  def self.choose_starting_code(color_choices)
    selected_code = []
    4.times do
      selected_code.push(color_choices.sample)
    end
    selected_code
  end
end
