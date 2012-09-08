# Fynd

I felt GNU find was too slow, so I made it slower.

## Is it any good?

[No.](http://news.ycombinator.com/item?id=3067434)

## Installation

    gem install fynd

## Usage

```ruby
require 'fynd'
include Fynd

# `find /var/log -iname '*system*' -type f`

find("/var/log").iname("system").type(:file).files

=> ["/var/log/system.log", "/var/log/system.log.0.bz2", "/var/log/system.log.1.bz2", "/var/log/system.log.2.bz2", "/var/log/system.log.3.bz2", "/var/log/system.log.4.bz2", "/var/log/system.log.5.bz2", "/var/log/system.log.6.bz2", "/var/log/system.log.7.bz2"]
```

You can keep pass the files to a block [if you're a bad enough dude](http://i.imgur.com/x37pI.jpg).

```
require 'fynd'
include Fynd

# `find /var/log -iname '*system` -type f -print

find("/var/log").iname("system").type(:file).files do |file|
  puts file
end

# Prints out:
#   /var/log/system.log
#   /var/log/system.log.0.bz2
#   /var/log/system.log.1.bz2
#   /var/log/system.log.2.bz2
#   /var/log/system.log.3.bz2
#   /var/log/system.log.4.bz2
#   /var/log/system.log.5.bz2
#   /var/log/system.log.6.bz2
#   /var/log/system.log.7.bz2
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
