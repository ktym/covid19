#!/usr/bin/env ruby
#
# selected.rb 2W-selected.txt 2W-durations-all.tsv > 2W-durations-selected-orig.tsv
#

subset = File.open(ARGV.shift)
fullset = File.open(ARGV.shift)

need = {}
subset.each do |line|
  haplotypes = line.strip
  haplotypes.split('|').each do |haplotype|
    need[haplotype] = true
  end
end

head = fullset.gets
puts head

fullset.each do |line|
  haplotypes, *ary = line.split
  haplotypes.split('|').each do |haplotype|
    if need[haplotype]
      puts line
    end
  end
end


