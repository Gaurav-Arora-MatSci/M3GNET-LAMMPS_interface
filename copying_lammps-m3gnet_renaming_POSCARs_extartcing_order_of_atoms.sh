#!/bin/bash/

#Copying m3gnet lammps script to all dir and sub-dir
find . -type d -exec cp lammps-m3gnet-fully-relax {} \; #remember to place the file in directory of running this script


#Counting the total directories
total_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)

for((i=1;i<=total_dir;i++))
do
        cd $i-* #Going to main dir
        sub_dir=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
        for((j=1;j<=$sub_dir;j++))
        do
                cd $j-* #going to each sub-dir
                #Checking if POSCAR exists
                if [ -f "POSCAR" ]; then
                        str_name="$PWD"
                        echo "$str_name, POSCAR exist"
                else
                        mv POSCAR_* POSCAR
                        grep -B2 'Cartesian\|Direct\|direct\|cartesian' POSCAR | head -n 1 >> order_of_atoms.txt
                        order_of_atoms=$(cat order_of_atoms.txt | tr -d '\r')
                        sed -i.bak "/^pair_coeff/c\pair_coeff         * * MP-2021.2.8-EFS ${order_of_atoms}" lammps-m3gnet*
                        yes y | atomsk POSCAR in.lmp #Moving POSCAR to lammps format
                fi
                cd ..
        done
        cd ..
done
