#!/bin/bash
#SBATCH--cpus-per-task=16 --mem=40G
/tchen43/software/subread/bin/featureCounts  -T 16 -t exon -g gene_id -a genomic.gtf -o counts.txt -p *bam
