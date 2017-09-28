class Volunteer
  attr_reader(:name, :project_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
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

  def self.all
    []
  end

  def self.all
    all_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    all_volunteers.each() do |volunteer|
    name = volunteer.fetch("name")
      volunteers.push(Volunteer.new({:name => name}))
  end
  volunteers
  end

  def save
    DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}');")
  end
end
