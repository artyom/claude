# Containerized Claude Code Package

The Dockerfile in this repository builds a container image that can be used to run Claude Code isolated from the main system, and backed by AWS Bedrock.

Primarily intended to be run on macOS via [Apple's container tool](https://github.com/apple/container).

## Usage

Example call:

```
container run --rm -it \
	-e AWS_BEARER_TOKEN_BEDROCK=$(bedrock-api-key) \
	-v ${PWD}:/home/ubuntu/code \
	ghcr.io/artyom/cccp:latest
```

Note that:

- it depends on <https://github.com/artyom/bedrock-api-key> to generate a short-term Amazon Bedrock API key;
- it assumes you're mounting **the current directory** inside the VM where Claude Code is running, **Claude Code will have write access to files in that directory and may modify them.**

When the VM starts, navigate to the `code` subdirectory where your original directory is mounted and launch Claude Code:

```
$ cd code
$ claude
```

For more details see:

- [Running Claude Code on Amazon Bedrock](https://docs.claude.com/en/docs/claude-code/amazon-bedrock)
- [Generating Amazon Bedrock API keys](https://docs.aws.amazon.com/bedrock/latest/userguide/api-keys-generate.html)
