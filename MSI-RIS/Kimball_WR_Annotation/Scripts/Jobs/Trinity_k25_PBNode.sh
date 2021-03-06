#!/bin/bash

# Load modules
module load java/jdk1.8.0_171
module load bowtie2/2.3.4.1
module load samtools/1.9
module load R/3.5.0
module load ncbi_blast+/2.7.1
module load jellyfish/2.1.3
module load python3/3.6.3_anaconda5.0.1

# Add the salmon dir to the $PATH
export PATH=${PATH}:/home/jkimball/shared/Software/salmon-latest_linux_x86_64/bin

# Define paths
TRINITY="/home/jkimball/shared/Software/trinityrnaseq-v2.8.6_CentOS6/trinityrnaseq-v2.8.6/Trinity"
READS_DIR="/panfs/roc/scratch/konox006/JKimball/RNASeq/Trimmed_reads"
#OUTPUT_DIR="/panfs/roc/scratch/konox006/JKimball/RNASeq/trinity_k25_Transcriptome_Asm_PB"
OUTPUT_DIR="/home/jkimball/shared/WR_Annotation/Transcriptome_Asm_trinity"

mkdir -p "${OUTPUT_DIR}"
cd "${OUTPUT_DIR}"

# Set some more parameters for the assembly
MIN_CONTIG=250

# Run Trinity
${TRINITY} \
    --seqType fq \
    --max_memory 250G \
    --left "${READS_DIR}/WR_8Tissues.R1.trimmed.fastq" \
    --right "${READS_DIR}/WR_8Tissues.R2.trimmed.fastq" \
    --SS_lib_type RF \
    --CPU 40 \
    --KMER_SIZE 25\
    --normalize_max_read_cov 100 \
    --monitoring \
    --monitor_sec 30 \
    --min_contig_length ${MIN_CONTIG} \
    --output "${OUTPUT_DIR}"
