class Project
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.name().==(another_project.name()).&(self.id().==(another_project.id()))
  end

  def self.find(id)
    found_list = nil
    Project.all().each() do |project|
      if project.id().==(id)
        found_project = project
      end
    end
    found_project
  end

    def volunteers
    list_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each() do |volunteer|
      description = volunteer.fetch("description")
      project_id = volunteer.fetch("project_id").to_i()
      list_volunteers.push(Volunteer.new({:description => description, :project_id => project_id}))
    end
    list_volunteers
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE list_id = #{self.id()};")
  end
end
