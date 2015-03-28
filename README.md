# D2E

Utility for converting diff to events.

## Usage

```
require 'd2e'
require 'json'

prev = [
  {'id' => 1, 'name' => 'John',   'description' => 'Guitar'},
  {'id' => 2, 'name' => 'Paul',   'description' => 'Bass'},
  {'id' => 3, 'name' => 'George', 'description' => 'Guitar'},
  {'id' => 4, 'name' => 'Ringo',  'description' => 'Drums'},
]
curr = [
  {'id' => 2, 'name' => 'Paul',   'description' => 'Bass/BeatMaking'},
  {'id' => 4, 'name' => 'Ringo',  'description' => 'Drums'},
  {'id' => 5, 'name' => 'Nas',    'description' => 'Rap'},
  {'id' => 6, 'name' => 'Biggie', 'description' => 'Rap'},
]

d2e = D2E.new(key: 'id')
events = d2e.diff(prev, curr)
puts JSON.pretty_generate(events)
```

output:

```
[
  {
    "type": "create",
    "item": {
      "id": 5,
      "name": "Nas",
      "description": "Rap"
    }
  },
  {
    "type": "create",
    "item": {
      "id": 6,
      "name": "Biggie",
      "description": "Rap"
    }
  },
  {
    "type": "delete",
    "item": {
      "id": 1,
      "name": "John",
      "description": "Guitar"
    }
  },
  {
    "type": "delete",
    "item": {
      "id": 3,
      "name": "George",
      "description": "Guitar"
    }
  },
  {
    "type": "update",
    "id": 2,
    "diff": {
      "description": [
        "Bass",
        "Bass/BeatMaking"
      ]
    }
  }
]
```

## Installation

Add this line to your application's Gemfile:

    gem 'd2e'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install d2e

## Contributing

1. Fork it ( https://github.com/[my-github-username]/d2e/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
