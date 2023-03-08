#!/bin/zsh

ruby=ruby-3.2

for i in 2 3 4 5
do
    ## 50p
    $ruby ancestors.rb ${i}W-durations-50p-orig.tsv ../${i}W-durations-all.tsv > ${i}W-durations-50p-add.tsv
    cat ${i}W-durations-50p-orig.tsv ${i}W-durations-50p-add.tsv | $ruby sort.rb > ../${i}W-durations-50p.tsv
    ## selected
    #$ruby selected.rb ${i}W-selected.txt ../${i}W-durations-all.tsv > ${i}W-durations-selected-orig.tsv
    #$ruby ancestors.rb ${i}W-durations-selected-orig.tsv ../${i}W-durations-all.tsv > ${i}W-durations-selected-add.tsv
    #cat ${i}W-durations-selected-orig.tsv ${i}W-durations-selected-add.tsv | $ruby sort.rb > ../${i}W-durations-selected.tsv
    ## over2
    #$ruby over.rb 1 ../${i}W-durations-all.tsv > ../${i}W-durations-over2.tsv
done

