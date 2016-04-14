require 'nokogiri'

module TaskManager
  class TaskFile
    FILE_NAME    = '.task'.freeze
    ELEMENT      = 'task'.freeze
    ROOT         = 'root'.freeze
    NEW_NODE     = 'new_tasks'.freeze
    CURRENT_NODE = 'current_tasks'.freeze
    DONE_NODE    = 'done_tasks'.freeze

    def add(task)
      handle_xml do
        node = create_node(task)
        root_node.add_child(node)
      end
    end

    def all
      root_node.css(ELEMENT).map do |node|
        Task.new_from_node(node)
      end
    end

    protected

    def create_node(task)
      node = xml.create_element(ELEMENT)
      node['id']    = new_id
      node['name']  = task.name
      node['score'] = task.score
      node['created_at'] = task.created_at
      node['started_at'] = task.started_at
      node['finished_at'] = task.finished_at
      node
    end

    def new_id
      highest_id + 1
    end

    def highest_id
      root_node.css(ELEMENT).map { |node| node['id'] }.map(&:to_i).max || 0
    end

    def xml
      @xml ||= begin
        create_file(FILE_NAME) unless File.exists?(FILE_NAME)
        File.open(FILE_NAME, 'r') { |f| Nokogiri::XML(f) }
      end
    end

    def root_node
      @root_node ||= begin
        xml.css(ROOT).first || begin
          node = xml.create_element(ROOT)
          xml.add_child(node)
          node
        end
      end
    end

    def create_file(file_name)
      `touch #{file_name}`
    end

    def handle_xml
      yield if block_given?
      save_xml
    end

    def save_xml
      File.open(FILE_NAME, 'w') { |f| f.write(xml.to_s) }
    end

    def time_now
      Time.now
    end
  end
end
