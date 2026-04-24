#GAI Declaration: I 201930340 declare that I used Gemini-flash-3 for  command-line optimization and troubleshooting the errors . 

 

# installing ubuntu in university pc based on the workshop tutorial 

wsl.exe --install Ubuntu 

 

# installing conda 

#make a new dir 

mkdir -p ~/miniconda3  

  

#use wget to download file 

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh 

  

#run the downloaded file - this will install the contents 

bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 

  

#delete the file 

rm -rf ~/miniconda3/miniconda.sh 

 

 

#Initialise your shell:  

~/miniconda3/bin/conda init bash 

~/miniconda3/bin/conda init zsh 

 

#Source your ~/.bashrc file by typing: 

source ~/.bashrc 

 

 

#Create a Conda environment: 

# I added the python version because the python version in university pc was not updated and for the later steps I got an error on almost each step! 

conda create -n genomics_env python=3.10 -y 
 

#Activate the environment: 

conda activate genomics_env 

 

#Add necessary channels: 

conda config --env --add channels bioconda 
conda config --env --add channels conda-forge 
 

 

#install packages in the environment: 

 

conda install -c bioconda fastqc 
 

 

 conda install -c bioconda flye 
 

 

 conda install -c bioconda quast 

 

 

 

 

# FLYE 

# The --pacbio-hifi flag is used because the GN3 dataset consists of highly accurate PacBio reads. 

flye --pacbio-hifi GN3_hifix30.fastq --out-dir GN3_flye_output --threads 4 

 

#SPAdes 

# The --pacbio flag tells SPAdes to expect PacBio reads. 

spades.py --isolate -s GN3_hifix30.fastq -o GN3_spades_output -t 4 

 

#QUAST 

quast.py GN3_flye_output/assembly.fasta GN3_spades_output/contigs.fasta --threads 4 -o QUAST_GN3_Comparison 

 

 

 

#Installing and preparing Bakta env 

conda deactivate 

conda create -n bakta python=3.10 -y  

conda activate bakta 

conda install -c conda-forge -c bioconda bakta –y 

 

#Prokka 

conda create -n prokka 
 

conda activate prokka  
 

conda install -c bioconda prokka 

 

#Artemis 

conda create -n artemis 
 

conda activate artemis  
 

conda install -c bioconda -c conda-forge artemis 

 

 

# downloading db for bakta 

conda activate bakta 

 

#I downloaded the database separately because I want to run bakta on two different outputs (Flye and SPAdes) 

 

bakta_db download --output ~/tmp_data/ --type light 

 

#run bakta on Flye output 

bakta --db ~/tmp_data/db-light /home/hlnrezae/GN3_flye_output/assembly.fasta --output bakta_GN3_flye 

 

#run bakta on SPAdes output 

bakta --db ~/tmp_data/db-light /home/hlnrezae/GN3_spades_output/contigs.fasta --output bakta_GN3_spades 

 

 

conda deactivate 

 
conda activate prokka 

conda install -c conda-forge -c bioconda prokka –y 

 

# run prokka on Flye output 

prokka --outdir prokka_GN3_flye --prefix GN3_flye /home/hlnrezae/GN3_flye_output/assembly.fasta 
 

# run prokka on SPAdes output 

 

prokka --outdir prokka_GN3_spades --prefix GN3_spades /home/hlnrezae/GN3_spades_output/contigs.fasta 

 

conda deactivate 

 

 

#for making the tsv file for annotation summary to calculate the  Functional Annotation Fraction we need to know the number of Hypothetical proteins in prokka tsv file I told linux to count them  

 

grep -c "hypothetical protein" prokka_GN3_flye/*.tsv 

 

grep -c "hypothetical protein" prokka_GN3_spades/*.tsv 