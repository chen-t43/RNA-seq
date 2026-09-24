#!/bin/bash
#SBATCH --cpus-per-task=60 --mem=80G
#SBATCH -o hisat2.run.log
spack load hisat2
spack load /izkv4dy
hisat2-build -p 10 GCF_023375685.1_Billie_1.0_genomic.fna  genome
HISAT2_INDEX="genome"
INPUT_DIR="."
OUTPUT_DIR="./hisat2_output"
mkdir -p $OUTPUT_DIR
for R1_FILE in ${INPUT_DIR}/*_clean_R1.fastq.gz
do
    SAMPLE_NAME=$(basename "$R1_FILE" _clean_R1.fastq.gz)
    R2_FILE="${INPUT_DIR}/${SAMPLE_NAME}_clean_R2.fastq.gz"
    echo "Mapping ${SAMPLE_NAME}..."
    hisat2 -p 60 \
        -x "$HISAT2_INDEX" \
        -1 "$R1_FILE" \
        -2 "$R2_FILE" \
        -S "$OUTPUT_DIR/${SAMPLE_NAME}.sam"
    samtools sort -@ 40 \
        -o "$OUTPUT_DIR/${SAMPLE_NAME}.bam" \
        "$OUTPUT_DIR/${SAMPLE_NAME}.sam"
    samtools index "$OUTPUT_DIR/${SAMPLE_NAME}.bam"
    rm "$OUTPUT_DIR/${SAMPLE_NAME}.sam"
    echo "Finished ${SAMPLE_NAME}"
done
