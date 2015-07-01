require 'sinatra/base'
require_relative 'game'

class RPSchallenge < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do # possibly it would be more ReSTful to have this be '/game/new' 
    erb :index
  end

  post '/game' do
    @name = session[:name] = params[:name]
    redirect '/' if @name.empty?
    @outcome = play_rps_game
    erb :new_game
  end

  helpers do # use the 'helpers' block to define helper methods

    def play_rps_game
      game = Game.new
      @player_option = params[:moves]
      @computer_option = game.play
      if @player_option == @computer_option
        @outcome = 'Draw!'
      else
        @outcome = game.winner @player_option, @computer_option, @name
      end
      @outcome
    end

  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
