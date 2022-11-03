FROM cheesesan/base:latest

RUN sudo apt-get install -y python3-pip libgl1-mesa-dev
RUN pip3 install -U pip
RUN pip3 install jupyterlab kaggle pandas numpy scikit-learn opencv-python matplotlib imblearn xgboost lightgbm catboost seaborn itermplot statsmodels
