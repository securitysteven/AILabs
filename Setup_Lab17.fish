#!/usr/bin/env fish

# Prevent running directly
if status is-interactive
    echo "You must run this script using 'source Setup_Lab17.fish'"
    return 1
end

set LAB "lab17"
set LDIR "./017_SupervisedLearning"

# Deactivate any active conda env
conda deactivate

# Remove old env if it exists
if conda env list | grep -q $LAB
    echo "Removing existing $LAB conda environment..."
    conda env remove -y -n $LAB
end

# Create and activate new env
conda create -y -n $LAB python=3.12
conda activate $LAB

# Install main packages via conda
conda install -y -c conda-forge \
    numpy pandas nltk seaborn plotly \
    scikit-learn matplotlib jupyter notebook

# Install Apple Silicon optimized TensorFlow + Metal
pip install --upgrade pip
pip install tensorflow-macos tensorflow-metal

# Install Poetry and dependencies
pip install --upgrade poetry
cd $LDIR
poetry install --no-root

# Setup complete
echo "########################################################"
echo " $LAB setup is complete."
echo " Start with: jupyter notebook"
echo "########################################################"
