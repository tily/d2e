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

prev = [
  {'groupName' => 'web', 'groupDescription' => 'Web Instances', 'ipPermissions' => nil},
  {'groupName' => 'apl', 'groupDescription' => 'Apl Instances', 'ipPermissions' => nil},
  {'groupName' => 'db', 'groupDescription' => 'DB Instances', 'ipPermissions' => nil},
]
curr = [
  {'groupName' => 'web', 'groupDescription' => 'Web Instances', 'ipPermissions' => {'item' => ['some ingresses']}},
  {'groupName' => 'apl', 'groupDescription' => 'Apl Instances', 'ipPermissions' => {'item' => ['other ingresses']}},
  {'groupName' => 'db', 'groupDescription' => 'Description changed', 'ipPermissions' => {'item' => ['blah blah']}},
]

d2e = D2E.new(id: 'groupName', ignore: 'ipPermissions')
events = d2e.d2e(prev, curr)
puts JSON.pretty_generate(events)
