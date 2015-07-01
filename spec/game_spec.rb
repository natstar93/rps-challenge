require 'game'

describe Game do
  
  it 'returns Rock, Paper or Scissors' do
    expect(['Rock', 'Scissors', 'Paper']).to include(subject.play)
  end

  context 'when player chooses paper and computer chooses rock' do
    
    it 'reports that player is the winner' do
      expect(subject.winner 'Paper', 'Rock', 'Bob').to eq('Bob wins!') # still passes when i make a type :-S
    end

  end

end
