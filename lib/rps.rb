require 'sinatra/base'

class RPSchallenge < Sinatra::Base
  
  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
    erb :index
  end

  post '/game' do
  	@name = params[:name]
  	redirect '/' if @name == ""  
    erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end