module TaskManager
  class NewTaskFile < TaskFile
    def pick(id)
      node = root_node.css('task').find { |t| t['id'].to_i == id }
      task = Task.new(node['name'], node['score'])
      handle_xml { node.remove }
      task
    end

    protected

    def root_node
      @root_node ||= begin
        xml.css(NEW_NODE).first || begin
          node = xml.create_element(NEW_NODE)
          super.add_child(node)
          node
        end
      end
    end
  end
end
