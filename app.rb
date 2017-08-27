require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/excontainer'

get '/' do
  slim :index
end

get '/exec' do
  r = ExCountainer.new(Time.now.to_f, 'c')
  r.exec.to_s
end

post '/api/run' do
  lang = params[:language]
  sorce = params[:sorce_code]
  input = params[:input]
  time = Time.now.to_f
  pfname = "#{time}.#{lang.downcase}"
  ifname = "#{time}.in"

  File.open("tmp/#{pfname}", "w") do |fl|
    prog.split('\n').each do |i|
      f.puts(l)
    end
  end

  c = ExContainer.new(time, lang)

  r = c.exec()

  return_prm = {stdout: r[0].join(''), stderr: r[1].join(''), exit_code: r[2]}
  content_type :json
  retuen_prm.to_json
end
