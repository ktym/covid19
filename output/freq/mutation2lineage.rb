#!/usr/bin/env ruby

header = ARGF.gets

class Lineage
  attr_accessor :lineage, :count, :mutation, :position
  def initialize(lineage, count, mutation, position)
    @lineage = lineage
    @count = count
    @mutation = mutation
    @position = position
  end
end

class Lineages
  def initialize
    @hash = {}
  end
  def add(entry)
    @hash[entry.lineage] ||= []
    @hash[entry.lineage] << entry
  end
  def summary
    @hash.sort.map do |lineage, entries|
      [ lineage, entries.map { |entry| entry.mutation }.join(" ") ].join("\t")
    end
  end
end

entries = Lineages.new

ARGF.each do |line|
  mutation, position, lineage_counts = line.strip.split("\t")
  lineages = lineage_counts.split('|')
  lineages.each do |lineage_count|
    lineage, count = lineage_count.delete_suffix(')').split('(')
    entry = Lineage.new(lineage, count.to_i, mutation, position)
    entries.add(entry)
  end
end

puts entries.summary
