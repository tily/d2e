require "d2e/version"

class D2E
  def initialize(options)
    @id = options[:id]
  end

  def diff(prev, curr)
    events = []

    prev_ids = prev.map {|item| item[@id] }
    curr_ids = curr.map {|item| item[@id] }

    deleted = prev_ids - curr_ids
    created = curr_ids - prev_ids
    updated = prev_ids & curr_ids

    created.each do |id|
      item = curr.find {|item| item[@id] == id }
      events << {'type' => 'create', 'item' => item}
    end

    deleted.each do |id|
      item = prev.find {|item| item[@id] == id }
      events << {'type' => 'delete', 'item' => item}
    end

    updated.each do |id|
      diff = {}
      prev_item = prev.find {|item| item[@id] == id }
      curr_item = curr.find {|item| item[@id] == id }
      keys = prev_item.keys | curr_item.keys
      keys.each do |key|
        prev_value = prev_item[key]
        curr_value = curr_item[key]
        if prev_value != curr_value
          diff[id] = [prev_value, curr_value]
        end
      end
      if !diff.empty?
        events << {'type' => 'update', 'id' => id, 'diff' => diff}
      end
    end

    events
  end
end

