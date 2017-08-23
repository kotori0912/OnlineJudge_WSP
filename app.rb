require 'sinatra'
require 'sinatra/reloader'

get '/' do
  slim :index
end

get '/exec' do
  r = ExecCountainer.new(Time.now.to_f, 'c')
  r.exec.to_s
end

