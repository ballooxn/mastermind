module Computer
  COLOR_CHOICES = %w[red orange yellow green blue pink purple].freeze

  def self.choose_code
    code = []
    4.times do |_|
      rand_color = Computer::COLOR_CHOICES[rand(0..6)]
      code.push(rand_color)
    end
    code
  end

  def self.choose_guess
    guess = []
    4.times do |_|
      rand_color = Computer::COLOR_CHOICES[rand(0..6)]
      guess.push(rand_color)
    end
    guess
  end
end
