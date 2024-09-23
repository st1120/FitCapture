wget -c https://repo.continuum.io/archive/Anaconda3-5.3.0-Linux-x86_64.sh
chmod +x Anaconda3-5.3.0-Linux-x86_64.sh
bash ./Anaconda3-5.3.0-Linux-x86_64.sh -b -f -p /usr/local
import sys
sys.path.append('/usr/local/lib/python3.7/site-packages')

pip install --upgrade pip
pip install --upgrade setuptools wheel
pip install tensorflow==1.13.1
git clone https://github.com/polmorenoc/opendr
cd opendr/opendr
python setup.py install
cd ../..
pip install opencv-python
pip install numpy==1.16.1
pip install --upgrade scikit-image
pip install protobuf==3.20.*
pip install pyopengl==3.1.0

wget https://people.eecs.berkeley.edu/~kanazawa/cachedir/hmr/models.tar.gz && tar -xf models.tar.gz