module TaskManager
  class Format
    attr_reader :task

    def initialize(task)
      @task = task
    end

    def print_output
      $stdout.puts("    #{task.id}. #{task.name}".colorize(:light_yellow))
      $stdout.puts("       #{created_at}#{started_at}#{finished_at}".colorize(:light_blue))
    end

    def created_at
      "created #{format_time(task.created_at)}" if task.created_at
    end

    def started_at
      " | started #{format_time(task.started_at)}" if task.started_at
    end

    def finished_at
      " | finished #{format_time(task.finished_at)}" if task.finished_at
    end

    def format_time(time)
      time.strftime('%d %^b %Y')
    end
  end
end
