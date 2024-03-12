#!/bin/bash

# Remove standard directories placed as a default by Colab
rm -rf /content/sample_data
mkdir -p input_files
mkdir -p pipeline_output
mkdir -p output_data/alignments output_data/adapter_removal output_data/quality_control output_data/primer_removal
bash -c "$(wget -q https://github.com/RIVM-bioinformatics/HERA-workshop-StMaarten/tarball/main -O - | tar -xz -C ./ --strip-components=1)"

# get sample fastq file from ENA
wget -q https://surfdrive.surf.nl/files/index.php/s/KwTJFvZBklNhSzU/download -O input_files/samples.zip && unzip input_files/samples.zip -d input_files > /dev/null 2>&1 && rm input_files/samples.zip
wget -q https://surfdrive.surf.nl/files/index.php/s/Jcia7L8HWsKohBK/download -O data.tar.gz && tar xzf data.tar.gz && rm data.tar.gz

rm -rf pipeline_output/results pipeline_output/Runinfomation.pdf pipeline_output/data/Virus~sars-cov-2/RefID~MN908947.3/alignment pipeline_output/data/Virus~sars-cov-2/RefID~MN908947.3/consensus

## install miniconda and get some basic tools
wget -q "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b -f -p /usr/local > /dev/null 2>&1

# setup the necessary channels
# mamba config --add channels bioconda

echo "Conda is installed as well as some fundamentals"
echo "Installing and preparing source material, this may take a while..."

# make a dedicated environment for every course section
mamba create -n pipeline_env viroconstrictor -c bioconda -y > /dev/null 2>&1

pip install igv-jupyter --quiet > /dev/null 2>&1

cat <<EOF >> ~/.ViroConstrictor_defaultprofile.ini
[COMPUTING]
compmode = local

[GENERAL]
auto_update = no
ask_for_update = no
EOF


echo -e "\e[1m\e[32mDone with installing everything, you can now continue with the rest of the course.\e[39m"