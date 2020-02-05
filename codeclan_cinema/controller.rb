require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("./models/film")
also_reload("./models/*")

get "/films" do
  @result = Film.all()
  erb(:index)
end

get "/Terminator" do
  "Terminator"
  "Price: 9.95"
end

get "/Rambo" do
  "Rambo"
  "Price: 4.95"
end

get "/Commando" do
  "Commando"
  "Price: 7.95"
end
