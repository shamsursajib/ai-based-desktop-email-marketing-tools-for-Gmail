"""
PROMIXCO Email Marketing Tools
Entry point — works both as script and compiled EXE
"""
import sys
import os

# Set working directory to EXE/script location so data saves correctly
if getattr(sys, 'frozen', False):
    app_dir = os.path.dirname(sys.executable)
else:
    app_dir = os.path.dirname(os.path.abspath(__file__))

os.chdir(app_dir)
os.makedirs(os.path.join(app_dir, "data"), exist_ok=True)
sys.path.insert(0, app_dir)

from app.app import ProMixcoApp

if __name__ == "__main__":
    app = ProMixcoApp()
    app.run()
