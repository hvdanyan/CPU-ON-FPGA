#include <stdint.h>

void seriprint(char *s)
{
    uint32_t * stdout_area = (uint32_t *)0xff8;
	while (*s != '\0'){
        while (*stdout_area >> 31 == 1);
        *stdout_area = *s + 0x80000000;
        s++;
    }
}

int main(){
    char s[20] = "Hello World\0";
    seriprint(s);
    return 0;
}