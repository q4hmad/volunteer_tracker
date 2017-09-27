require ("rspec")
require ("pg")
require ("pry")
require ("task")
require("spec_helper")

# DB is a constant. A constant is a variable that's available everywhere in your program. They should be used very rarely, and generally only for application-wide configuration settings like the name of your database. By convention, Constants have all upper-case names.
DB = PG.connect({:dbname => "to_do_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  describe(".all") do
    it("is empty at first and then lists by order") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      task1 = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe(".all") do
    it("order by due date") do
      task1 = Task.new({:description => "learn SQL", :due_date => "2017-09-25", :list_id => 1})
      task1.save()
      task2 = Task.new({:description => "refactor code", :due_date => "2017-09-28", :list_id => 2})
      task2.save()
      expect(Task.all).to(eq([task1, task2]))
    end
  end
end
