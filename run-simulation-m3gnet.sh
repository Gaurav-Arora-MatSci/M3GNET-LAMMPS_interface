#!/bin/bash/

#loading the env and module
#m3gnet-lammps

total_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)

for((i=1;i<=$total_dir;i++))
do
        cd $i-*
        sub_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
        for((j=1;j<=$sub_dir;j++))
        do
                cd $j-*
                lmp-m3gnet -in lammps-m3gnet-fully-relax
                cd ..
        done
        cd ..
done
