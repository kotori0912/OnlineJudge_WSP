require 'sinatra'
require 'sinatra/reloader'

require_relative 'lib/excontainer'

get '/' do
  slim :index
end

get '/exec' do
  r = ExContainer.new(Time.now.to_f, 'c')
  r.exec.to_s
end

post '/api/run' do
  lang = params[:language]
  source = params[:source_code]
  input = params[:input]
  time = Time.now.to_f
  pfname = "#{time}.#{lang.downcase}"
  ifname = "#{time}.in"

  File.open("tmp/#{pfname}", 'w') do |f|
    source.split('\n').each do |l|
      f.puts(l)
    end
  end

  File.open("tmp/#{ifname}", 'w') do |f|
    input.split('\n').each do |l|
      f.puts(l)
    end
  end

  c = ExContainer.new(time, lang)

  r = c.exec()

  return_params = {stdout: r[0].join(''), stderr: r[1].join(''), exit_code: r[2]}
  content_type :json
  return_params.to_json
end
