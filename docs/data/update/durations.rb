#!/usr/bin/env ruby
#
# ruby durations.rb input-durations.txt > output.tsv
#

require 'date'
require 'version_sorter'

haplotype, prefecture, *head = ARGF.gets.chomp.split("\t")
head_rev = head.reverse

hash = {}

ARGF.each_line do |line|
  haplotype, prefecture, *ary = line.chomp.split("\t")
  haplotype.gsub!('.x.', '.9999999.')         # for version sort
  haplotype.sub!(/^([A-z])/) { "9999#{$1}" }  # for version sort
  if i = ary.index {|x| x.to_i > 0}
    j = ary.reverse.index {|x| x.to_i > 0}
    first = Date.parse(head[i])
    last  = Date.parse(head_rev[j])
    total = ary.map{|x| x.to_i}.sum
    hash[haplotype] ||= {}
    hash[haplotype][prefecture] = [ first, last, (last - first).to_i + 1, total ] 
  end
end

puts %w( haplotype first last duration total prefecture ).join("\t")
VersionSorter.sort(hash.keys).each do |haplotype|
  hash[haplotype].sort_by {|prefecture, data| data.first}.each do |prefecture, data|
    first, last, duration, total = *data
    restore = haplotype.gsub('.9999999.', '.x.').sub(/^9999/, '')
    puts [ restore, first, last, duration, total, prefecture ].join("\t")
  end
end

