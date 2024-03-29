FROM cheesesan/base:latest

RUN sudo apt-get install -y python3-pip libgl1-mesa-dev
RUN pip3 install -U pip
RUN pip3 install jupyterlab kaggle pandas numpy scikit-learn opencv-python matplotlib imblearn
RUN pip3 install torch torchvision torchtext torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
RUN pip3 install pytorch_tabular

