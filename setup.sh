#!/usr/bin/env bash

set -euo pipefail

LSB_CODENAME=$(lsb_release -cs)

curl -f -L --retry 5 https://apt.llvm.org/llvm-snapshot.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/llvm-snapshot.gpg --yes

{
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-20 main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-19 main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-18 main"
} | sudo tee /etc/apt/sources.list.d/llvm-toolchain.list

if [[ $LSB_CODENAME == "jammy" ]]; then
{
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-17 main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-16 main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-15 main"
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] https://apt.llvm.org/$LSB_CODENAME llvm-toolchain-$LSB_CODENAME-14 main"
} | sudo tee -a /etc/apt/sources.list.d/llvm-toolchain.list
fi

exec sudo apt update
