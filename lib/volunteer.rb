class Volunteer
  attr_reader(:id)
  attr_accessor(:name, :project_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:project_id)
  end

  def name
    @name
  end

  def project_id
    @project_id
  end

  def ==(another_volunteer)
      self.name().==(another_volunteer.name())
  end

  def self.all()
    all_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
      all_volunteers.each() do |volunteer|
        name = volunteer.fetch("name")
        project_id = volunteer.fetch("project_id")
        id = volunteer.fetch("id").to_i
        volunteers.push(Volunteer.new({:name => name, :project_id=> project_id, :id=> id}))
      end
    volunteers
  end
  def save
      saved_volunteer = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
      @id = saved_volunteer.first().fetch("id").to_i
    end

    def self.find(id)
      found_volunteers = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
      name = found_volunteers.first().fetch("name")
      project_id = found_volunteers.first().fetch("project_id")
      Volunteer.new({:name => name, :project_id => project_id, :id => id})
    end

end
