module TaskManager
  class CurrentTaskFile < TaskFile
    def current
      Task.new(current_node['name'], current_node['score'])
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
  end
end
