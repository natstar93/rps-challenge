require 'spec_helper'

feature 'Starting a new game' do

  before do # use before block to DRY out tests
    visit '/'
  end

  scenario 'asks user for their name' do
    expect(page).to have_content('What is your name?')
  end

  scenario 'allows user to enter their name' do
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    expect(page).to have_content('Bob is playing')
  end

  scenario 'does not allow name field to be submitted if blank' do
    visit '/'
    click_button("Let's play!")
    expect(page).to have_content ('What is your name?')
  end
end

feature 'Playing a game' do

  scenario 'allows user to pick an option' do
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    expect(page).to have_selector ('select') # probably don't need a test for this as you're implicitly testing it further down
  end

  scenario 'displays the chosen option' do
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    select 'Rock', from: 'moves'
    click_button('Submit')
    expect(page).to have_content('You chose Rock')
  end
  
  scenario 'displays a computer generated option' do
    allow_any_instance_of(Game).to receive(:play) { 'Scissors' }
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    select 'Rock', from: 'moves'
    click_button('Submit')
    expect(page).to have_content('The computer chose Scissors')
  end

  scenario 'displays a message when game is drawn' do
    allow_any_instance_of(Game).to receive(:play) { 'Rock' }
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    select 'Rock', from: 'moves'
    click_button('Submit')
    expect(page).to have_content('Draw!')
  end

  scenario 'displays a message when player wins' do
    allow_any_instance_of(Game).to receive(:play) { 'Scissors' }
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    select 'Rock', from: 'moves'
    click_button('Submit')
    expect(page).to have_content('Bob wins!')
  end
  
  scenario 'displays a message when computer wins' do
    allow_any_instance_of(Game).to receive(:play) { 'Paper' }
    visit '/'
    fill_in('name', with: 'Bob')
    click_button("Let's play!")
    select 'Rock', from: 'moves'
    click_button('Submit')
    expect(page).to have_content('Computer wins')
  end
end
