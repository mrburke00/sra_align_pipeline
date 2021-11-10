#!/bin/bash

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/002/315/GCA_000002315.5_GRCg6a/GCA_000002315.5_GRCg6a_genomic.fna.gz

gzip -d GCA_000002315.5_GRCg6a_genomic.fna.gz

bwa index -p GCA GCA_000002315.5_GRCg6a_genomic.fna
