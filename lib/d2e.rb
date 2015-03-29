require "d2e/version"

class D2E
  def initialize(options)
    @id = [options[:id]].flatten
  end

  def d2e(prev, curr)
    events = []

    deleted = difference(prev, curr)
    created = difference(curr, prev)
    remained = intersection(prev, curr)

    created.each do |item|
      events << {'type' => 'create', 'item' => item}
    end

    deleted.each do |item|
      events << {'type' => 'delete', 'item' => item}
    end

    remained.each do |prev_item, curr_item|
      diff = {}
      keys = prev_item.keys | curr_item.keys
      keys.each do |key|
        prev_value = prev_item[key]
        curr_value = curr_item[key]
        if prev_value != curr_value
          diff[key] = [prev_value, curr_value]
        end
      end
      if !diff.empty?
        id = Hash[@id.map {|id| [id, prev_item[id]] }]
        events << {'type' => 'update', 'id' => id, 'diff' => diff}
      end
    end

    events
  end

  def difference(list_a, list_b)
    list = []
    list_a.each do |item_a|
      if !list_b.find {|item_b| @id.all? {|id| item_a[id] == item_b[id] } }
        list << item_a
      end
    end
    list
  end

  def intersection(list_a, list_b)
    list = []
    list_a.each do |item_a|
      if item_b = list_b.find {|item_b| @id.all? {|id| item_a[id] == item_b[id] } }
        list << [item_a, item_b]
      end
    end
    list
  end
end

