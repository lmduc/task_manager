require 'task_manager/version'

require 'task_manager/task'

require 'task_manager/task_file'
require 'task_manager/new_task_file'
require 'task_manager/current_task_file'
require 'task_manager/done_task_file'

module TaskManager
  def self.add(name, score = 0)
    task = Task.new(name, score)
    NewTaskFile.new.add(task)
    print("Added new task: #{format(task)}")
  end

  def self.pick(id)
    task = NewTaskFile.new.pick(id)
    CurrentTaskFile.new.add(task)
    print("Picked task: #{format(task)}")
  end

  def self.current
    task = CurrentTaskFile.new.current
    print("Current task: #{format(task)}")
  end

  def self.finish
    task = CurrentTaskFile.new.pick
    DoneTaskFile.new.add(task)
    print("Finished task: #{format(task)}")
  end

  def self.stats
    print('Waiting tasks:')
    NewTaskFile.all.each do |task|
      print(format(task))
    end

    print('Current task:')
    CurrentTaskFile.all.each do |task|
      print(format(task))
    end

    print('Done tasks:')
    DoneTaskFile.all.each do |task|
      print(format(task))
    end
  end

  private

  def self.print(sentence)
    $stdout.puts sentence
  end

  def self.format(task)
    "#{task.name} - #{task.score}"
  end
end
