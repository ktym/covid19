#!/usr/bin/env ruby
#
# cat 2W-durations-list-orig.tsv 2W-durations-list-add.tsv | ./sort.rb > 2W-durations-list.tsv
#

require 'version_sorter'

head = ARGF.gets
puts head

hash = {}

ARGF.each_line do |line|
  haplotype, first, last, duration, total, prefecture = line.chomp.split("\t")
  haplotype.gsub!('.x.', '.9999999.')         # for version sort
  haplotype.sub!(/^([A-z])/) { "9999#{$1}" }  # for version sort
  hash[haplotype] ||= {}
  hash[haplotype][prefecture] = [ first, last, duration, total ]
end

VersionSorter.sort(hash.keys).each do |haplotype|
  hash[haplotype].sort_by {|prefecture, data| data.first}.each do |prefecture, data|
    first, last, duration, total = *data
    restore = haplotype.gsub('.9999999.', '.x.').sub(/^9999/, '')
    puts [ restore, first, last, duration, total, prefecture ].join("\t")
  end
end
