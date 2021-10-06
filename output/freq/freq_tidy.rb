#!/usr/bin/env ruby

header = ARGF.gets

headers = header.strip.split("\t")

puts [ "mutation", "position", "month", "frequency" ].join("\t")

ARGF.each do |line|
  row = line.chomp.split("\t")
  2.upto(headers.size - 1).each do |i|
    puts [ row[0], row[1], headers[i], row[i] ].join("\t")
  end
end
