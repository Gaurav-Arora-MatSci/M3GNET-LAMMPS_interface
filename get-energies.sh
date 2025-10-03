#!/bin/bash/

touch energies.txt
#Counting the total directories
total_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)

for((i=1;i<=$total_dir;i++))
do
        cd $i-*
        sub_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
        for((j=1;j<=$sub_dir;j++))
        do
                cd $j-*
                energy=$(grep -A1 'Energy initial, next-to-last, final =' log.lammps | tail -n1 | awk '{print $3}')
                str_name=$(basename "$PWD")
                total_atoms=$(grep 'Loop time' log.lammps | awk '{print $12}')
                echo -e "$str_name\t$energy\t$total_atoms" >> ../../energies.txt
                cd ..
        done
        cd ..
done
