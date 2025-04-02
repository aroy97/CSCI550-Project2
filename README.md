# Environment Setup

To setup Environment, run:
```
wget https://github.com/duckdb/duckdb/archive/refs/tags/v1.2.1.tar.gz
docker build -t cuckoo_duckdb_env:latest .
docker run --name cuckoo_duckdb --privileged -it --shm-size=4g --cap-add=SYS_PTRACE --cap-add=CAP_SYS_ADMIN cuckoo_duckdb_env:latest
```

## Environment notes
- DuckDB Version: 1.2.1
- Docker Image Distro: Ubuntu:22.04
- C++ Version: 20
