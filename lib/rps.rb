require 'sinatra/base'
require_relative 'game'

class RPSchallenge < Sinatra::Base

  enable :sessions

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index
  end

  post '/game' do
    @name = params[:name]
    session[:name] = @name
    redirect '/' if @name == ""
    if $game
      session[:player] = 'player_2'
    else
      session[:player] = 'player_1'
    end
    p session[:player]
    $game = Game.new
    erb :new_game
  end

  post '/result' do
    @player_option = params[:moves]
    p session[:player]
    erb :result
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
