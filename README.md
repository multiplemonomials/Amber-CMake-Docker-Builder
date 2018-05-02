### Amber Linux release builder

This setup uses the manylinux docker image to create release tars of Amber.

#### Instructions:
1. Get an Amber/AmberTools source tree from somewhere, put it in this directory, and change the path at the top of `build_amber.sh` to point to it.
1. Pull Hai's Amber build box: `docker pull ambermd/amber-build-box`
2. Create the CMake docker image: `docker build -t cmake-build-box .`
3. Run the build inside the container: `docker run -it cmake-build-box /bin/bash /amber-builds/build-amber.sh`
4. Wait an hour or two for it to finish building and testing.
5. Once the container finishes and exits, get its ID from `docker ps -a`
6. Copy the build artifacts out of the container: `docker cp <container id>:/artifacts .`
