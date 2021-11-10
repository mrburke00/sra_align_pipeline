# sra_align_pipeline
In Progress

Need to create `bwa_errors`, `log_align`, and `log_build_reference` directories for the batch runs

`align.sh`

  - Input is S3 bucket containing folders named by accession number with the fastq files in each folder. 
  - Ouput are sorted BAM files and their indexes
  - Have to change the reference file name, cpu count, and SRA bucket name
  - Have to change SRA numbers and how you will be downloading the files
  
`align.sbatch`
  - run this with sbatch align.sbatch to run align.sh on fiji
 
`build_reference.sh`
  - Takes in url for reference genome and outputs a indexed reference genome for the alignment of the fastqs
  - Need to change the URL and output name
  
`build_reference.sbatch`
  - run this with sbatch build_reference.sbatch to run build_reference.sh on fiji 
  
 
