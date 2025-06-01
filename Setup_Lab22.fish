#!/usr/bin/env fish

# Ensure the script is sourced
if test (status --is-interactive) = 0
    echo "You must run this script using: source Setup_Lab22.fish"
    return 1
end

set LAB lab22
set LDIR ./022_LargeLanguageModels

# Deactivate any current conda env
if functions -q conda
    conda deactivate 2>/dev/null
end

# Remove existing env if it exists
if conda env list | grep -q $LAB
    echo "Removing existing $LAB conda environment"
    conda env remove --name $LAB --yes
end

# Create new conda env for Apple Silicon
conda create --name $LAB python=3.12 --yes
conda activate $LAB

# Install PyTorch and core dependencies
pip install --pre torch torchvision torchaudio
pip install --no-cache-dir unsloth
pip install --no-cache-dir jupyter

# Move to lab directory
cd $LDIR

echo "########################################################"
echo " $LAB Setup is complete."
echo " Start jupyter-notebook to proceed"
echo "########################################################"
