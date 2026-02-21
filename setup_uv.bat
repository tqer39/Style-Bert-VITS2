@echo off
REM Style-Bert-VITS2 UV Setup Script for Windows

echo Creating virtual environment...
python -m venv venv

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing uv...
pip install uv

echo Installing PyTorch with CUDA 11.8...
uv pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118

echo Installing Style-Bert-VITS2 with server and torch extras...
uv pip install -e ".[server,torch]"

echo Installing remaining dependencies from requirements.txt...
uv pip install -r requirements.txt

echo Downloading BERT models and default TTS models...
python initialize.py

echo.
echo Setup complete!
echo To activate the environment, run: venv\Scripts\activate.bat
pause
