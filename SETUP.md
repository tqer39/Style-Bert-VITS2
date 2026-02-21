# Windows セットアップ手順

## 前提条件

- Python 3.9〜3.11（推奨: 3.11）
- CUDA 11.8 対応の NVIDIA GPU（GPU 推論/学習を行う場合）
- Git

## 自動セットアップ（推奨）

`setup_uv.bat` を実行すると、以下の手順がすべて自動で行われます。

```cmd
setup_uv.bat
```

このスクリプトは以下を実行します:
1. Python 仮想環境の作成（`venv`）
2. `uv` パッケージマネージャのインストール
3. PyTorch（CUDA 11.8）のインストール
4. Style-Bert-VITS2 と依存パッケージのインストール
5. BERT モデル・デフォルト TTS モデルのダウンロード（`initialize.py`）

## 手動セットアップ

### 1. 仮想環境の作成と有効化

```cmd
python -m venv venv
venv\Scripts\activate.bat
```

PowerShell の場合:
```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### 2. uv のインストール

```cmd
pip install uv
```

### 3. PyTorch のインストール

```cmd
uv pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118
```

### 4. パッケージのインストール

```cmd
uv pip install gputil
uv pip install -e ".[server,torch]"
uv pip install -r requirements.txt
```

### 5. モデルのダウンロード

```cmd
python initialize.py
```

## サーバーの起動

仮想環境を有効化してから起動してください。

```cmd
venv\Scripts\activate.bat
python server_fastapi.py
```

PowerShell の場合:
```powershell
.\venv\Scripts\Activate.ps1
python server_fastapi.py
```

| コマンド | 用途 |
|---------|------|
| `python server_fastapi.py` | FastAPI 推論サーバー（API ドキュメント: `/docs`） |
| `python app.py` | Gradio WebUI |
| `python server_editor.py` | エディタ API サーバー |

## トラブルシューティング

### `ModuleNotFoundError: No module named 'uvicorn'`

`server` extras がインストールされていません。仮想環境を有効化した上で:

```cmd
uv pip install -e ".[server]"
```

### `&&` が PowerShell で使えない

PowerShell ではコマンドを `;` で区切るか、1 行ずつ実行してください。

```powershell
# NG
source venv/Scripts/activate && python server_fastapi.py

# OK
.\venv\Scripts\Activate.ps1
python server_fastapi.py
```

### `uv venv` エラー（No virtual environment found）

仮想環境が有効化されていません。先に `venv\Scripts\activate.bat`（または `.\venv\Scripts\Activate.ps1`）を実行してください。
