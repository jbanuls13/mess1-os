#!/usr/bin/env bash

case $(uname -m) in
    "x86_64"|"aarch64")
        arch=$(uname -m)
    ;;
    "arm64")
        arch="aarch64"
    ;;
    *)
        echo "Unsupported cpu arch: $(uname -m)"
        exit 2
    ;;
esac

case $(uname -s) in
    "Linux")
        sys="unknown-linux-musl"
    ;;
    "Darwin")
        sys="apple-darwin"
    ;;
    *)
        echo "Unsupported system: $(uname -s)"
        exit 2
    ;;
esac

dir=~/.local/bin
mkdir -p "$dir"
echo "Installation directory: $dir"
if [[ -x "$dir/zellij" ]]
then
    rm "$dir/zellij"
#    "$dir/zellij" "$@"
#    exit
fi

url="https://github.com/zellij-org/zellij/releases/latest/download/zellij-$arch-$sys.tar.gz"
curl --location "$url" | tar -C "$dir" -xz
if [[ $? -ne 0 ]]
then
    echo
    echo "Extracting binary failed, cannot launch zellij :("
    echo "One probable cause is that a new release just happened and the binary is currently building."
    echo "Maybe try again later? :)"
    exit 1
fi
# "$dir/zellij" "$@"
exit

