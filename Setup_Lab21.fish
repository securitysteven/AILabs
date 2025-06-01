# Check if the script is being sourced
if test (status current-command) = (status filename)
    echo "You must run this script using: source Setup_Lab16.fish"
    exit 1
end

set LAB lab21
set LDIR ./021_NeuralNetworks

# Deactivate any existing conda env
conda deactivate

# Check if env exists and remove it
if conda env list | grep -q $LAB
    echo "Removing existing $LAB conda env"
    conda env remove -q --yes -n $LAB
end

# Create and activate env
conda create --yes -n $LAB python=3.12
conda activate $LAB

# Install poetry
pip install --upgrade poetry

# Go to directory and install dependencies
cd $LDIR
poetry install --no-root

# Final messages
echo "########################################################"
echo " $LAB Setup is complete."
echo " Start jupyter-notebook to proceed"
echo "########################################################"
