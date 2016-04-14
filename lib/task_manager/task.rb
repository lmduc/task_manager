module TaskManager
  class Task
    attr_accessor :name, :score

    def initialize(name, score)
      @name  = name
      @score = score
    end
  end
end
