require 'time'

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
      if task.created_at && !task.created_at.empty?
        "created #{format_time(task.created_at)}"
      end
    end

    def started_at
      if task.started_at && !task.started_at.empty?
        " | started #{format_time(task.started_at)}"
      end
    end

    def finished_at
      if task.finished_at && !task.finished_at.empty?
        " | finished #{format_time(task.finished_at)}"
      end
    end

    def format_time(time)
      Time.parse(time).strftime('%d %^b %Y')
    end
  end
end
