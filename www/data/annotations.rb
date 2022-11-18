#!/usr/bin/env ruby

require 'json'
require 'bio'

class SARSCoV2
  ORF = {
    "Genome" => '1..29903',
    "nsp1" => '266..805',
    "nsp2" => '806..2719',
    "nsp3" => '2720..8554',
    "nsp4" => '8555..10054',
    "nsp5" => '10055..10972',
    "nsp6" => '10973..11842',
    "nsp7" => '11843..12091',
    "nsp8" => '12092..12685',
    "nsp9" => '12686..13024',
    "nsp10" => '13025..13441',
    "nsp11" => '13442..13480',
    "nsp12" => 'join(13442..13468,13468..16236)',
    "nsp13" => '16237..18039',
    "nsp14" => '18040..19620',
    "nsp15" => '19621..20658',
    "nsp16" => '20659..21552',
    "S" => '21563..25384',
    "ORF2b" => '21744..21860',
    "ORF3a" => '25393..26220',
    "ORF3c" => '25457..25579',
    "ORF3d" => '25524..25694',
    "ORF3d2" => '25596..25694',
    "ORF3b" => '25814..25879',
    "E" => '26245..26472',
    "M" => '26523..27191',
    "ORF6" => '27202..27387',
    "ORF7a" => '27394..27759',
    "ORF7b" => '27756..27887',
    "ORF8" => '27894..28259',
    "N" => '28274..29533',
    "ORF9b" => '28284..28574',
    "ORF9c" => '28734..28952',
    "ORF10" => '29558..29674',
  }

  attr_reader :genes
  def initialize
    @genes = []
    ORF.each do |name, locations|
      @genes << Gene.new(name, locations)
    end
  end

  class Gene
    attr_reader :name, :locations, :span
    def initialize(name, location)
      @name = name
      @locations = Bio::Locations.new(location)
      @span = @locations.span
    end

    def aa2na(aa_pos)
      @locations.absolute(aa_pos, :aa)
    end
  end
end

sarscov2 = SARSCoV2.new
hash = {}
ary = []
sarscov2.genes.each do |gene|
  lower, upper = *gene.span
  case gene.name
  when "Genome"
    hash["Genome"] ||= [ {:region => gene.name, :lower => lower, :upper => upper} ]
  else
    ary << {:region => gene.name, :lower => lower, :upper => upper}
  end
end
hash["Genes"] = ary
puts hash.to_json
