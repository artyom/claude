FROM public.ecr.aws/lts/ubuntu:24.04_stable
ARG DEBIAN_FRONTEND=noninteractive
RUN <<EOF
	set -eux
	apt-get update -q
	apt-get install -y -q --no-install-recommends \
		ca-certificates \
		curl \
		git \
		less \
		sudo
	sed -i 's|http://|https://|g' /etc/apt/sources.list.d/ubuntu.sources
	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/010_ubuntu-nopasswd
EOF
USER 1000:1000
ADD --checksum=sha256:54715810c1e802c8aca39cc867ae9b2ec764574e20f2a653c97ec61bebc07d68 --chmod=0755 --chown=1000:1000 https://claude.ai/install.sh /tmp/claude-install.sh
RUN /tmp/claude-install.sh
ENV PATH=${PATH}:/home/ubuntu/.local/bin \
	LC_ALL=C.utf8 \
	CLAUDE_CODE_USE_BEDROCK=1 \
	CLAUDE_CODE_MAX_OUTPUT_TOKENS=4096 \
	MAX_THINKING_TOKENS=1024 \
	AWS_REGION=us-east-1 \
	ANTHROPIC_MODEL=global.anthropic.claude-sonnet-4-5-20250929-v1:0 \
	ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION=us-west-2
WORKDIR /home/ubuntu
