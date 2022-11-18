#!/usr/bin/env ruby

over = ARGV.shift.to_i

puts ARGF.gets

ARGF.each do |line|
  ary = line.split("\t")
  if ary[4].to_i > over
    puts line
  end
end
