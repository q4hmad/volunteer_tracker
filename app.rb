require ("sinatra")
require ("pry")
require ("sinatra/reloader")
also_reload(".lib/**/*.rb")
require ("./lib/volunteer")
require("./lib/project")
require ("pg")
require('pry')

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  @projects = Project.all()
  erb(:index)
end

post("/") do
  @title = params["title"]
  @project = Project.new({:title => @title, :id => nil})
  @project.save
  @projects = Project.all()
   erb(:index)
end

get("/projects/:id") do
  @projects = Project.find(params[:id].to_i())
  erb(:project)



end
