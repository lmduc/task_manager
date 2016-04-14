require 'time'

module TaskManager
  class Format
    attr_reader :task

    def initialize(task)
      @task = task
    end

    def output
      output = <<-OUTPUT
    #{task.id} - #{task.name}#{created_at}#{started_at}#{finished_at}
      OUTPUT
      output.colorize(:light_yellow)
    end

    def created_at
      if task.created_at && !task.created_at.empty?
        " - created at #{format_time(task.created_at)}"
      end
    end

    def started_at
      if task.started_at && !task.started_at.empty?
        " - started at #{format_time(task.started_at)}"
      end
    end

    def finished_at
      if task.finished_at && !task.finished_at.empty?
        " - finished at #{format_time(task.finished_at)}"
      end
    end

    def format_time(time)
      Time.parse(time).strftime('%d %^b %Y')
    end
  end
end
