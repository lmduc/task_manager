require 'time'

module TaskManager
  class Task
    attr_accessor :name,
                  :score,
                  :id,
                  :created_at,
                  :started_at,
                  :finished_at

    def initialize(name = nil, score = nil)
      @name  = name
      @score = score
    end

    def self.new_from_node(node)
      task             = Task.new
      task.id          = node['id']
      task.name        = node['name']
      task.score       = node['score']
      task.created_at  = parse_time(node['created_at'])
      task.started_at  = parse_time(node['started_at'])
      task.finished_at = parse_time(node['finished_at'])
      task
    end

    private

    def self.parse_time(string)
      if string && !string.empty?
        Time.parse(string)
      else
        nil
      end
    end
  end
end
