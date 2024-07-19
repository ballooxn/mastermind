class Computer
  @color_choices = %w[Red Blue Yellow Green Pink Purple Orange]
  def self.choose_starting_code
    selected_code = []
    4.times do
      selected_code.push(@color_choices.sample)
    end
    selected_code
  end
end
