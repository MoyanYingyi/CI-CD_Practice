# Stage 1: Build the C++ application

#select a base image with the necessary build tools
FROM ubuntu:24.04 AS builder
#executes commands while building the image
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake && \
    rm -rf /var/lib/apt/lists/*
#set the working directory inside the container
WORKDIR /app
#copy project files into the image.
COPY CMakeLists.txt .
COPY src/ src/
COPY include/ include/
COPY tests/ tests/
#build the application using cmake
RUN cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build

    
# Stage 2: Run the application
FROM ubuntu:24.04
#sets the working directory for the application
WORKDIR /app
#copy the built application from the builder stage to the final image
COPY --from=builder /app/build/app /app/app
#run tha app as a non-root user for securiry reasons
USER 65534:65534
#set the default command to run the application when the container starts
CMD ["./app"]