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
      task = Task.new
      task.name        = node['name']
      task.score       = node['score']
      task.created_at  = node['created_at']
      task.started_at  = node['started_at']
      task.finished_at = node['finished_at']
      task
    end
  end
end
