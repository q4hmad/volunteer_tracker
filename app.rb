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

get("/projects/:id/edit") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/projects/:id") do
  title = params.fetch("title")
  @projects = Project.find(params.fetch("id").to_i())
  @projects.update({:title => title})
  erb(:project)
end

delete("/projects/:id") do
  @projects = Project.find(params.fetch("id").to_i())
  @projects.delete()
  @projects = Project.all()
  erb(:index)
end

post('/projects/:id/volunteers') do
  name = params.fetch("name")
  project_id =  Project.find(params.fetch("id").to_i())
  @projects = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id=> project_id})
  @volunteer.save()
  erb(:project_edit)
end
