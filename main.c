#include "aes.h"
#include "popcnt.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>

#define AES_BLOCK_SIZE_BYTES 16

void printAESBlock(char* description, unsigned char* data) {
    printf("%s", description);
    for (int i = 0; i < AES_BLOCK_SIZE_BYTES; ++i) {
        printf("%02x", data[i]);
    }
    printf("\n");
}

int main(void) {
    for(unsigned long i = 0; i < 20; ++i) {
        printf("popcnt(%lu) = %lu", i, population_count_u64(i));
    }

    unsigned char* key = malloc(AES_BLOCK_SIZE_BYTES);
    assert(key);
    syscall(SYS_getrandom, key, AES_BLOCK_SIZE_BYTES, 0);

    unsigned char* data = malloc(AES_BLOCK_SIZE_BYTES);
    assert(data);
    syscall(SYS_getrandom, data, AES_BLOCK_SIZE_BYTES, 0);

    printAESBlock("Key:                    ", key);
    printAESBlock("Data before encryption: ", data);

    aes_128_encrypt(data, key);
    printAESBlock("Data after encryption:  ", data);

    aes_128_decrypt(data, key);
    printAESBlock("Data after decryption:  ", data);

    free(key);
    free(data);

    return 0;
}
