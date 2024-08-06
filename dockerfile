FROM ubuntu:latest

# Add deadsnakes PPA for newer Python versions
# RUN apt-get update && apt-get install -y software-properties-common && \
#     add-apt-repository ppa:deadsnakes/ppa

# Update package lists and install Python 3.10 and dependencies
RUN apt-get update && apt-get install -y \
  python3.10 \
#   python3.10-venv \
#   python3.10-dev \
  git \
  libyaml-dev \
  && apt-get clean

RUN set -xe && apt-get -yqq update && apt-get -yqq install python3-pip && pip3 install --upgrade pip

# Create symlink for python3.10 to be used as python3
# RUN ln -s /usr/bin/python3.10 /usr/bin/python3

# Verify Python and pip installation
RUN python3 --version && pip3 --version

# Upgrade pip to the latest version
# RUN pip3 install --upgrade pip

# Install PyYAML with verbose output
RUN pip3 install --no-cache-dir -v pyyaml

# Verify PyYAML installation
RUN python3 -c "import yaml; print(yaml.__version__)"

# Copy feed.py to the container
COPY feed.py /usr/bin/feed.py

# Copy entrypoint.sh to the container
COPY entrypoint.sh /entrypoint.sh

# Ensure entrypoint.sh has execution permissions
RUN chmod +x /entrypoint.sh

# Define the entry point
ENTRYPOINT ["/entrypoint.sh"]