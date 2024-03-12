#!/bin/bash

GROUP="2"

# Remove standard directories placed as a default by Colab
mkdir -p input_files
mkdir -p pipeline_output
# bash -c "$(wget -q https://github.com/RIVM-bioinformatics/HERA-workshop-StMaarten/tarball/main -O - | tar -xz -C ./ --strip-components=1)"

# get sample fastq file from ENA
unzip samples_${GROUP}.zip -d input_files > /dev/null 2>&1 && rm samples_${GROUP}.zip
tar xzf data_${GROUP}.tar.gz && rm data_${GROUP}.tar.gz

rm -rf pipeline_output_wrong/.snakemake
rm -rf pipeline_output_correct/.snakemake

rm -rf pipeline_output_wrong/results pipeline_output_wrong/Runinfomation.pdf pipeline_output_wrong/data/Virus~sars-cov-2/RefID~MN908947.3/alignment pipeline_output_wrong/data/Virus~sars-cov-2/RefID~MN908947.3/consensus pipeline_output_wrong/*.log
rm -rf pipeline_output_correct/results pipeline_output_correct/Runinfomation.pdf pipeline_output_correct/*.log

rm -rf samples_${GROUP}.zip data_${GROUP}.tar.gz

## install miniconda and get some basic tools
wget -q "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -f
rm Miniforge3-$(uname)-$(uname -m).sh

# setup the necessary channels
# mamba config --add channels bioconda

echo "Mamba is installed as well as some fundamentals"
echo "Installing and preparing source material, this may take a while..."

# make a dedicated environment for every course section
mamba create -n pipeline_env viroconstrictor igv -c bioconda -y > /dev/null 2>&1

# pip install igv-jupyter --quiet > /dev/null 2>&1

cat <<EOF >> ~/.ViroConstrictor_defaultprofile.ini
[COMPUTING]
compmode = local

[GENERAL]
auto_update = no
ask_for_update = no
EOF


echo -e "\e[1m\e[32mDone with installing everything, you can now continue with the rest of the course.\e[39m"