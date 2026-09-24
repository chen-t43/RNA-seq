#!/bin/bash
#SBATCH --cpus-per-task=30
#SBATCH --mem=40G
spack load fastp
input_folder="./"
output_folder="cleaned_fastq"
mkdir -p $output_folder
for R1 in ${input_folder}/*_1.fq.gz
do
    base_name=$(basename "$R1" _1.fq.gz)
    R2="${input_folder}/${base_name}_2.fq.gz"
    out_R1="${output_folder}/${base_name}_clean_R1.fastq.gz"
    out_R2="${output_folder}/${base_name}_clean_R2.fastq.gz"
    html_report="${output_folder}/${base_name}.html"
    json_report="${output_folder}/${base_name}.json"
    echo "Processing ${base_name}..."
    fastp \
        -i $R1 \
        -I $R2 \
        -o $out_R1 \
        -O $out_R2 \
        -h $html_report \
        -j $json_report \
        -w 30
    echo "Finished ${base_name}"
done
