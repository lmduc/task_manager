module TaskManager
  class CurrentTaskFile < TaskFile
    def add(task)
      raise "You haven't finished the current task".colorize(:light_red) if current_node
      super
    end

    def current
      raise "You don't have any current task".colorize(:light_red) unless current_node
      Task.new_from_node(current_node)
    end

    def pick
      task = current
      handle_xml { current_node.remove }
      task
    end

    protected

    def current_node
      root_node.css(ELEMENT).first
    end

    def root_node
      @root_node ||= begin
        xml.css(CURRENT_NODE).first || begin
          node = xml.create_element(CURRENT_NODE)
          super.add_child(node)
          node
        end
      end
    end

    def create_node(task)
      node = super
      node['started_at'] = time_now
      node
    end
  end
end
