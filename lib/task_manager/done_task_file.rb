module TaskManager
  class DoneTaskFile < TaskFile
    protected

    def root_node
      @root_node ||= begin
        xml.css(DONE_NODE).first || begin
          node = xml.create_element(DONE_NODE)
          super.add_child(node)
          node
        end
      end
    end
  end
end
