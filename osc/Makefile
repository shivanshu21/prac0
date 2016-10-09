obj-m += sys_xmergesort.o

INC=/lib/modules/$(shell uname -r)/build/arch/x86/include

all: xhw1 xmergesort_user xmergesort

xhw1: xhw1.c
	gcc -Wall -Werror -I$(INC)/generated/uapi -I$(INC)/uapi xhw1.c -o xhw1

xmergesort_user: xmergesort.c
	gcc -Wall -Werror -I$(INC)/generated/uapi -I$(INC)/uapi xmergesort.c -o xmergesort_user

xmergesort:
	make -Wall -Werror -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -f xhw1
	rm -f xmergesort_user
