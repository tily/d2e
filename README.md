# D2E

Utility for converting diff to events.

## Usage

### Basic

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

d2e = D2E.new(id: 'id')
events = d2e.d2e(prev, curr)
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

### Multiple Primary Keys

```
prev = [
  {'groupName' => 'web', 'ipProtocol' => 'TCP', 'inOut' => 'IN', 'fromPort' => 80, 'toPort' => 80, 'ipRange' => '0.0.0.0/0'},
  {'groupName' => 'web', 'ipProtocol' => 'TCP', 'inOut' => 'IN', 'fromPort' => 443, 'toPort' => 443, 'ipRange' => '0.0.0.0/0'},
  {'groupName' => 'mon', 'ipProtocol' => 'ICMP', 'inOut' => 'OUT', 'group' => 'web'},
]
curr = [
  {'groupName' => 'web', 'ipProtocol' => 'TCP', 'inOut' => 'IN', 'fromPort' => 443, 'toPort' => 443, 'ipRange' => '0.0.0.0/0'},
  {'groupName' => 'mon', 'ipProtocol' => 'ICMP', 'inOut' => 'OUT', 'group' => 'web', 'description' => 'for ping monitoring'},
  {'groupName' => 'app', 'ipProtocol' => 'TCP', 'inOut' => 'IN', 'fromPort' => 8080, 'toPort' => 8080, 'group' => 'web'},
]

d2e = D2E.new(id: ['groupName', 'ipProtocol', 'inOut', 'fromPort', 'toPort', 'ipRange', 'group'])
events = d2e.d2e(prev, curr)
puts JSON.pretty_generate(events)
```

output:

```
[
  {
    "type": "create",
    "item": {
      "groupName": "app",
      "ipProtocol": "TCP",
      "inOut": "IN",
      "fromPort": 8080,
      "toPort": 8080,
      "group": "web"
    }
  },
  {
    "type": "delete",
    "item": {
      "groupName": "web",
      "ipProtocol": "TCP",
      "inOut": "IN",
      "fromPort": 80,
      "toPort": 80,
      "ipRange": "0.0.0.0/0"
    }
  },
  {
    "type": "update",
    "id": {
      "groupName": "mon",
      "ipProtocol": "ICMP",
      "inOut": "OUT",
      "fromPort": null,
      "toPort": null,
      "ipRange": null,
      "group": "web"
    },
    "diff": {
      "description": [
        null,
        "for ping monitoring"
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
