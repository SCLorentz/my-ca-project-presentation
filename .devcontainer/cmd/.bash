alias run="cargo run"
alias ll='ls -la'

# Mudar a cor do prompt (para Bash, usando cores ANSI)
PS1='\[\e[38;5;41m\]\w\[\e[0m\]\\$ '

if [ "$(uname -m)" == "aarch64" ]; then
    PATH=/usr/local/bin/upx-4.2.4-arm64_linux:$PATH
elif [ "$(uname -m)" == "x86_64" ]; then
    PATH=/usr/local/bin/upx-4.2.4-amd64_linux/upx:$PATH
else
    echo "Arquitetura não identificada."
fi

function _run()
{
    if [ "$(uname -m)" == "aarch64" ]; then
        RUSTFLAGS="-C link-arg=-nostartfiles" cargo build --target aarch64-unknown-linux-gnu  
        upx target/aarch64-unknown-linux-gnu/debug/almost_metal -qqq --best
        target/aarch64-unknown-linux-gnu/debug/almost_metal
    elif [ "$(uname -m)" == "x86_64" ]; then
        RUSTFLAGS="-C link-arg=-nostartfiles" cargo build --target x86_64-unknown-linux-gnu
        upx target/aarch64-unknown-linux-gnu/debug/almost_metal -qqq --best
        target/x86_64-unknown-linux-gnu/debug/almost_metal
    else
        echo "Arquitetura não identificada."
    fi
}

# RUSTFLAGS="-C link-arg=-nostartfiles" cargo build --target aarch64-apple-darwin