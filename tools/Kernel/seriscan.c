#include <stdint.h>

void seriscan(char *s, uint32_t length){
    uint32_t * stdin_area = (uint32_t *)0xff4;
    while(length--){
        while (*stdin_area >> 31 == 0);
        *s = *stdin_area & 0xff;
        s++;
    }
}

int main(){
    char *s = (char *)0x400;
    seriscan(s, 1);
    return (int)*s;
}