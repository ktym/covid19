#!/usr/bin/env ruby
#
# ancestors.rb 2W-durations-50p-orig.tsv 2W-durations-all.tsv > 2W-durations-50p-add.tsv
#

seen = {}
need = {}

subset = File.open(ARGV.shift)
fullset = File.open(ARGV.shift)

subset.gets
subset.each do |line|
  haplotypes, *ary = line.split
  haplotypes.split('|').each do |haplotype|
    seen[haplotype] = true
  end
end

def ancestors(haplotype)
  list = []
  if haplotype[/\./]
    ary = haplotype.split('.')
    ary.pop
    while ary.length > 1
      list.push(ary.join('.'))
      ary.pop
    end
  end
  return list
end

seen.keys.each do |haplotype|
  list = ancestors(haplotype)
  list.each do |ancestor|
    unless seen[ancestor]
      need[ancestor] = true
    end
  end
end

fullset.gets
fullset.each do |line|
  haplotypes, *ary = line.split
  haplotypes.split('|').each do |haplotype|
    if need[haplotype]
      puts line
    end
  end
end


