# Kickstarts image build, tag, and push process.

if [ -z $1 ]; then
    echo "First argument missing: LTS number."
    exit 1
fi

SNAPSHOT=$1
IMAGE_NAME="kulkarnih/haskell-dev-image"

# Render docker file.
./render-dockerfile.sh "$SNAPSHOT"

# Build using the rendered file.
./build-tag-push-image.sh "$SNAPSHOT" "$IMAGE_NAME"
