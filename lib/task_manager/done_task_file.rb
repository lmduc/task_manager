module TaskManager
  class DoneTaskFile < TaskFile
    DEFAULT_NO_RESULTS = 15

    def all
      super.reverse!.first(DEFAULT_NO_RESULTS)
    end

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

    def create_node(task)
      node = super
      node['finished_at'] = time_now
      node
    end
  end
end
