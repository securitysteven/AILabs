# Check if the script is being sourced
if test (status current-command) = (status filename)
    echo "You must run this script using: source Setup_Lab24.fish"
    exit 1
end

set LAB lab24
set LDIR ./024_AdversarialAI

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

# Create directory if not exists
mkdir -p $LDIR
cd $LDIR

# Initialize poetry and add required dependencies
poetry init --name $LAB --python ">=3.12,<3.14" --no-interaction
poetry add python-dotenv textwrap3 pyrit notebook

# Create a template .env file if it doesn't exist
if not test -f .env
    echo "Creating a template .env file..."
    touch .env
    echo "Don't forget to enter your OPENAI_KEY in the .env file!"
    echo "OPENAI_KEY=your_openai_api_key_here" >> .env
    echo ".env file created. Please edit it to include your actual OpenAI credentials."
else
    echo ".env file already exists."
end

# Final messages
echo "########################################################"
echo " $LAB Setup is complete."
echo " Start jupyter-notebook to proceed"
echo "########################################################"
