#!/usr/bin/env ruby

header = ARGF.gets

puts %w(Mutation Position Lineage Count).join("\t")

ARGF.each do |line|
  mutation, position, lineage_counts = line.strip.split("\t")
  lineages = lineage_counts.split('|')
  lineages.each do |lineage_count|
    lineage, count = lineage_count.delete_suffix(')').split('(')
    puts [ mutation, position, lineage, count ].join("\t")
  end
end

