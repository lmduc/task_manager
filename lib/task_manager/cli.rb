require 'thor'

module TaskManager
  class Cli < Thor
    include Thor::Actions

    desc 'add', 'Add a new task to the waiting queue'
    method_option :name, aliases: '-n', desc: 'Name of the task', type: :string, required: true
    method_option :score, aliases: '-s', desc: 'Score of the task', type: :integer
    def add
      TaskManager.add(options[:name], options[:score])
    end

    desc 'pick', 'Pick a task from the waiting queue'
    method_option :id, aliases: '-i', desc: 'ID of the task', type: :integer, required: true
    def pick
      TaskManager.pick(options[:id])
    end

    desc 'current', 'Current task'
    def current
      TaskManager.current
    end

    desc 'finish', 'Finish the current task'
    def finish
      TaskManager.finish
    end

    desc 'stats', 'Statistics of all queues'
    def stats
      TaskManager.stats
    end
  end
end
