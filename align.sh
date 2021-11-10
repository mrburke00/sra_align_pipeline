#!/bin/bash

#sra_examples=("SRR11777081" "SRR11780525" "SRR11780526")
#sra_label_1=("mRhiFer_Phase_S3HiC_R1" "L23623_Track-54387_R1" "L23624_Track-54388_R1")
#sra_label_2=("mRhiFer_Phase_S3HiC_R2" "L23623_Track-54387_R2" "L23624_Track-54388_R2")

#sra_examples=("SRR11780527" "SRR4040040")
#sra_label_1=("L23625_Track-54389_R1" "1169_LIB11141_LDI9113_CGATGT_L002_R1_clean")
#sra_label_2=("L23625_Track-54389_R2" "1169_LIB11141_LDI9113_CGATGT_L002_R2_clean")

#sra_examples=("SRR4041813_2")
#sra_label_1=("943_LIB7850_LDI6492_GTGAAA_L002_R1_clean")
#sra_label_2=("943_LIB7850_LDI6492_GTGAAA_L002_R2_clean")

for i in "${!sra_examples[@]}"; do    	
	
	#aws s3 sync s3://layerlabsra/"${sra_examples[i]}"/ .
	#gzip -d *fastq.gz
	#mv *"${sra_label_1[i]}".fastq "${sra_examples[i]}"_1.fastq
	#mv *"${sra_label_2[i]}".fastq "${sra_examples[i]}"_2.fastq        
        
	mv "${sra_examples[i]}"_1.fastq data/fastqs/
	mv "${sra_examples[i]}"_2.fastq	data/fastqs/

	## fastq -> bam ##
	bwa mem -M -t 12 -R "@RG\tID:1\tSM:""${sra_examples[i]}" \
	GCF \
	data/fastqs/"${sra_examples[i]}"_1.fastq data/fastqs/"${sra_examples[i]}"_2.fastq  \
	2> bwa_errors/bwa_"${sra_examples[i]}".err \
	> "${sra_examples[i]}".bam
	
	mv "${sra_examples[i]}".bam data/bams/	

	## sort bwa ##
	samtools sort data/bams/"${sra_examples[i]}".bam -o "${sra_examples[i]}".sorted.bam -@12
	
	mv "${sra_examples[i]}".sorted.bam data/bams/
	
	## index bam ##
	samtools index data/bams/"${sra_examples[i]}".sorted.bam -@12

	mv "${sra_examples[i]}".sorted.bam.bai data/bams/

	## upload to S3 ##
	#aws s3 cp "${sra_examples[i]}".sorted.bam s3://layerlabcu/sra/chicken/
	#aws s3 cp "${sra_examples[i]}".sorted.bam.bai s3://layerlabcu/sra/chicken/

	#sudo rm -r SRR*

done

