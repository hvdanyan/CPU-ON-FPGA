#include <stdint.h>

void seriprint(char *s)
{
    uint32_t * stdin_area = (uint32_t *)0xff8;
	while (*s != '\0'){
        *stdin_area = *s + 0x80000000;
        while (*stdin_area >> 31 == 1);
        s++;
    }
}

int main(){
    char s[20] = "Hello World\0";
    seriprint(s);
    return 0;
}