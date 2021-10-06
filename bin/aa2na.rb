#!/usr/bin/env ruby
#
# ruby aa2na.rb input/freq/Japan.vari_freq_prec.monthly.tsv
#

require 'bio'

ORF = {
  "nsp1" => Bio::Locations.new('266..805'),
  "nsp2" => Bio::Locations.new('806..2719'),
  "nsp3" => Bio::Locations.new('2720..8554'),
  "nsp4" => Bio::Locations.new('8555..10054'),
  "nsp5" => Bio::Locations.new('10055..10972'),
  "nsp6" => Bio::Locations.new('10973..11842'),
  "nsp7" => Bio::Locations.new('11843..12091'),
  "nsp8" => Bio::Locations.new('12092..12685'),
  "nsp9" => Bio::Locations.new('12686..13024'),
  "nsp10" => Bio::Locations.new('13025..13441'),
  "nsp11" => Bio::Locations.new('13442..13480'),
  "nsp12" => Bio::Locations.new('join(13442..13468,13468..16236)'),
  "nsp13" => Bio::Locations.new('16237..18039'),
  "nsp14" => Bio::Locations.new('18040..19620'),
  "nsp15" => Bio::Locations.new('19621..20658'),
  "nsp16" => Bio::Locations.new('20659..21552'),
  "S" => Bio::Locations.new('21563..25384'),
  "ORF2b" => Bio::Locations.new('21744..21860'),
  "ORF3a" => Bio::Locations.new('25393..26220'),
  "ORF3c" => Bio::Locations.new('25457..25579'),
  "ORF3d" => Bio::Locations.new('25524..25694'),
  "ORF3d2" => Bio::Locations.new('25596..25694'),
  "ORF3b" => Bio::Locations.new('25814..25879'),
  "E" => Bio::Locations.new('26245..26472'),
  "M" => Bio::Locations.new('26523..27191'),
  "ORF6" => Bio::Locations.new('27202..27387'),
  "ORF7a" => Bio::Locations.new('27394..27759'),
  "ORF7b" => Bio::Locations.new('27756..27887'),
  "ORF8" => Bio::Locations.new('27894..28259'),
  "N" => Bio::Locations.new('28274..29533'),
  "ORF9b" => Bio::Locations.new('28284..28574'),
  "ORF9c" => Bio::Locations.new('28734..28952'),
  "ORF10" => Bio::Locations.new('29558..29674'),
}

# p ORF.sort_by {|k, v| v.locations.range.begin }.map {|k, v| k }

# vars = []

ARGF.each do |line|
  loc, rest = line.split(/\s+/, 2)
  orf, var = loc.split('#')
  if var
    pos = var.scan(/\d+/).shift.to_i
    # vars << [orf, pos, ORF[orf].absolute(pos, :aa), var]
    puts [ loc, ORF[orf].absolute(pos, :aa), rest ].join("\t")
  else
    puts [ loc, 'position', rest ].join("\t")
  end
end

# vars.sort { |a,b| a[2] <=> b[2] }.each { |var| p var }


