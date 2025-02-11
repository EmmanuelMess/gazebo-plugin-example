# Example gazebo plugin

#### Compile
```
docker build . -t odometer:harmonic

python3 -m venv venv
source venv/bin/activate
python3 -m pip install -r requirements.txt
rocker --volume $PWD/odometer:/root/odometer:rw \
       --x11 odometer:harmonic 

cmake -G Ninja -S . -B ./build
cmake --build ./build --config Release
cmake --install ./build --config Release --prefix $HOME/.gz/sim/plugins
```

#### Run
```
source venv/bin/activate

rocker --volume $PWD/odometer:/root/odometer:rw --x11 odometer:harmonic 

gz sim -r odometer.sdf
```
