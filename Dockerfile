FROM alpine:latest
RUN apk add git cmake build-base clang cairo-dev graphicsmagick-dev libpng-dev boost-dev openssl-dev jpeg-dev xz-dev tiff-dev

ENV CTEST_OUTPUT_ON_FAILURE "1"

RUN wget "https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibpng%2Ffiles%2Flatest%2Fdownload&ts=1581399792" -O libpng-1.6.37.tar.xz
RUN tar -xJf libpng-1.6.37.tar.xz
WORKDIR /libpng-1.6.37
RUN mkdir build
WORKDIR /libpng-1.6.37/build
RUN cmake ..
RUN make
RUN make install

WORKDIR /
RUN git clone --recurse-submodules https://github.com/cpp-io2d/P0267_RefImpl
WORKDIR /P0267_RefImpl
RUN mkdir build
WORKDIR /P0267_RefImpl/build
RUN cmake -DIO2D_DEFAULT=CAIRO_XLIB -DIO2D_WITHOUT_TESTS=1 -DIO2D_WITHOUT_SAMPLES=1 ..
RUN make
RUN make install

WORKDIR /
RUN git clone --recurse-submodules https://github.com/mcarlospc/CppND-Route-Planning-Project.git
WORKDIR /CppND-Route-Planning-Project
RUN mkdir build
WORKDIR /CppND-Route-Planning-Project/build
RUN cmake ..
RUN make

CMD ./OSM_A_star_search
