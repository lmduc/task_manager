module TaskManager
  class NewTaskFile < TaskFile
    def pick(id)
      node = find_node(id)
      task = Task.new_from_node(node)
      yield(task) if block_given?
      handle_xml { node.remove }
      task
    end

    def delete(id)
      node = find_node(id)
      task = Task.new_from_node(node)
      handle_xml { node.remove }
      task
    end

    protected

    def find_node(id)
      node = root_node.css('task').find { |t| t['id'].to_i == id.to_i }
      raise 'ID not exists'.colorize(:light_red) unless node
      node
    end

    def root_node
      @root_node ||= begin
        xml.css(NEW_NODE).first || begin
          node = xml.create_element(NEW_NODE)
          super.add_child(node)
          node
        end
      end
    end

    def create_node(task)
      node = super
      node['created_at'] = time_now
      node
    end
  end
end
