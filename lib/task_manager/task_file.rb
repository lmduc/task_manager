require 'nokogiri'

require 'task_manager/new_task_file'
require 'task_manager/current_task_file'
require 'task_manager/done_task_file'

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

    protected

    def create_node(task)
      node = xml.create_element(ELEMENT)
      node['id']    = new_id
      node['name']  = task.name
      node['score'] = task.score
      node
    end

    def new_id
      highest_id + 1
    end

    def highest_id
      root_node.css('id').map(&:to_i).max || 0
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
  end
end
