# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Installation
```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
uv pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118
uv pip install -r requirements.txt
python initialize.py  # Download BERT models and default TTS models
```

### Code Quality
```bash
hatch run style:check   # Check formatting (black + isort)
hatch run style:fmt     # Auto-format code
```

### Testing
```bash
hatch run test:test           # PyTorch CPU tests
hatch run test:test-cuda      # PyTorch GPU tests
hatch run test-onnx:test      # ONNX CPU tests
hatch run test-onnx:test-cuda # ONNX GPU tests
```

### Running Servers
```bash
python app.py              # Gradio WebUI (all tabs)
python server_fastapi.py   # FastAPI inference server (docs at /docs)
python server_editor.py    # Editor API server
```

### Training Pipeline
```bash
python slice.py --model_name <name>        # Slice audio files
python transcribe.py --model_name <name>   # Whisper transcription
python preprocess_all.py -m <name>         # Preprocess data + generate config
python train_ms.py                         # Train standard model
python train_ms_jp_extra.py                # Train JP-Extra model
```

## Architecture

### Core Library (`style_bert_vits2/`)
- `tts_model.py` - Main `TTSModel` and `TTSModelHolder` classes for inference
- `models/` - Neural network architectures (`models.py`, `models_jp_extra.py`, `infer.py`, `infer_onnx.py`)
- `nlp/` - Text processing with language-specific handlers (`bert_models.py`, `japanese/`)
- `constants.py` - Version, default paths, inference parameters

### WebUI (`gradio_tabs/`)
Gradio interface tabs: inference, dataset creation, training, style vectors, merge, ONNX conversion

### Entry Points
| Script | Purpose |
|--------|---------|
| `app.py` | Gradio WebUI |
| `server_fastapi.py` | REST API server |
| `train_ms.py` / `train_ms_jp_extra.py` | Training |
| `preprocess_all.py` | Data preprocessing |

### Model Assets Structure
```
model_assets/<model_name>/
├── config.json
├── *.safetensors (or *.onnx)
└── style_vectors.npy
```

## Language Support
- JP (Japanese) - Default, uses deberta-v2-large-japanese-char-wwm
- EN (English) - uses deberta-v3-large
- ZH (Chinese) - uses chinese-roberta-wwm-ext-large

JP-Extra models only support Japanese.

## Inference Modes
- PyTorch: `.safetensors` files, requires `torch` optional dependency
- ONNX: `.onnx` files, works with onnxruntime only
