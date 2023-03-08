#!/usr/bin/env ruby
#
# ruby mutations.rb input-mutations.txt [ref-mutations.txt] > output.json
#

require 'json'

if ARGV.size > 1
  ref_mutations_file = ARGV.pop
  REF_MUTATIONS = File.read(ref_mutations_file).strip.split("|")
else
  REF_MUTATIONS = false
end

mutations, haplotype, *head = ARGF.gets.chomp.split("\t")
head_rev = head.reverse

hash = {}

ARGF.each_line do |line|
  mutations, haplotype, *ary = line.chomp.split("\t")
  ary = []
  mutations.split('|').each do |mutation|
    if mutation[/\A([A-Zd]+)(\d+)([A-Z-]+)\Z/]
      data = { :pos => $~[2], :ref => $~[1], :alt => $~[3], :str => mutation }
      ary << data
    end
  end
  hash[haplotype] = ary
end

hash["Reference"] = []
if REF_MUTATIONS
  REF_MUTATIONS.each do |mutation|
    if mutation[/\A([A-Zd]+)(\d+)([A-Z-]+)\Z/]
      data = { :pos => $~[2], :ref => $~[1], :alt => $~[3], :str => mutation }
      hash["Reference"] << data
    end
  end
end

puts hash.to_json

