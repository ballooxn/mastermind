module Player
  def self.choose_guess
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
end
