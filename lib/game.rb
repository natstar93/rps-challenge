class Game
  attr_reader :possible_choices

  def initialize
    @possible_choices = ['Rock', 'Paper', 'Scissors'] # consider injecting in the elements of the game, rather than having them hardcoded
  end
  
  def play
    %w(Rock Paper Scissors).sample
  end

  def winner player, computer, name
    [player, computer].each do |choice|
      fail 'Bad choice' unless possible_choices.include? choice
    end

    case player
    when 'Scissors'
      computer == 'Rock' ? 'Computer wins' : (name + ' wins!')
    when 'Rock'
      @output = (computer == 'Paper' ? 'Computer wins' : (name + ' wins!')) # you needn't use this instance variable.
    else
      @output = (computer == 'Scissors' ? 'Computer wins' : (name + ' wins!'))
    end
  end
end
