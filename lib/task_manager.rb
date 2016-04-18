require 'colorize'

require 'task_manager/version'

require 'task_manager/task'

require 'task_manager/task_file'
require 'task_manager/new_task_file'
require 'task_manager/current_task_file'
require 'task_manager/done_task_file'

require 'task_manager/format'

require 'task_manager/cli'

module TaskManager
  def self.add(name, score = 0)
    task = NewTaskFile.new.add(Task.new(name, score))
    print('Added new task:'.colorize(:light_cyan))
    print_task(task)
  end

  def self.pick(id)
    task = NewTaskFile.new.pick(id) do |task|
      CurrentTaskFile.new.add(task)
    end
    print('Picked task:'.colorize(:light_cyan))
    print_task(task)
  rescue Exception => e
    print e.message
  end

  def self.delete(id)
    task = NewTaskFile.new.delete(id)
    print('Deleted task:'.colorize(:light_cyan))
    print_task(task)
  rescue Exception => e
    print e.message
  end

  def self.current
    task = CurrentTaskFile.new.current
    print('Current task:'.colorize(:light_cyan))
    print_task(task)
  rescue Exception => e
    print e.message
  end

  def self.finish
    task = CurrentTaskFile.new.pick
    DoneTaskFile.new.add(task)
    print('Finished task:'.colorize(:light_green))
    print_task(task)
  end

  def self.stats
    print('Waiting tasks:'.colorize(:light_cyan))
    NewTaskFile.new.all.each do |task|
      print_task(task)
    end
    print('')

    print('Current task:'.colorize(:light_cyan))
    CurrentTaskFile.new.all.each do |task|
      print_task(task)
    end
    print('')

    print('Done tasks:'.colorize(:light_cyan))
    DoneTaskFile.new.all.each do |task|
      print_task(task)
    end
  end

  private

  def self.print(sentence)
    $stdout.puts sentence
  end

  def self.print_task(task)
    Format.new(task).print_output
  end
end
