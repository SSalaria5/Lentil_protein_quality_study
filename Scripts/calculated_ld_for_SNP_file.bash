#!/usr/bin/env bash

# Directions for creating .ped and .map plink files.
# sed 's/LCU.2RBY.CHR//g' ./Lentil2.chrms.imputed.143SamplesMAFMxMis.recode.vcf > Lentil.renamed.vcf
# /home/njohns9/vcftools --vcf Lentil.renamed.vcf --plink --out Lens.plink

# if 10 SNPs, second number should be 10 that is 1..10
for i in {1..17}
do
    SNP_NAME=$(head -n ${i} snpM1.txt | tail -n 1)
    /project/dthavar/dilthavar/software/Plink/plink --noweb --allow-extra-chr --file /project/dthavar/dilthavar/Lentil/plink \
        --r2 --ld-snp ${SNP_NAME} --ld-window-kb 1000 --ld-window 99999 --ld-window-r2 0 \
        --out ${SNP_NAME}.plink.ld
    echo ${SNP_NAME}
done

