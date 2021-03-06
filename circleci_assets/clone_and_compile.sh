set -e
git config --global url.ssh://git@github.com/.insteadOf https://github.com/
git clone https://github.com/armmbed/mbed-cloud-client-example-restricted 
cd mbed-cloud-client-example-restricted
mbed deploy --protocol ssh
mbed update R1.2.5-LA
echo "$CREDENTIAL_FILE" | base64 -d > mbed_cloud_dev_credentials.c
python pal-platform/pal-platform.py -v deploy --target=x86_x64_NativeLinux_mbedtls generate
cd __x86_x64_NativeLinux_mbedtls
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=./../pal-platform/Toolchain/GCC/GCC.cmake -DEXTARNAL_DEFINE_FILE=./../define.txt
make mbedCloudClientExample.elf
cd ../..
