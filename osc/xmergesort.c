#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <asm/unistd.h>
#include <sys/syscall.h>
#include "sys_xmergesort.h"

#ifndef __NR_xmergesort
#error xmergesort system call not defined
#endif

void usage_term(void);

int main(int argc, char* const argv[])
{
    int ret, gopt;
    u_int ret_data;
    sys_xmergesort_args_t xmsargs;

    ret_data = -1;
    xmsargs.flags = 0;
    xmsargs.data = &ret_data;
    ret = EXIT_SUCCESS;
    gopt = 0;

    while ((gopt = getopt(argc, argv, "uaitd")) != -1) {
        switch (gopt) {
            case 'u':
                // Do not output duplicate records in outfile
                xmsargs.flags = xmsargs.flags | _XMS_NO_DUP;
                break;
            case 'a':
                // Print all records including duplicates in outfile
                xmsargs.flags = xmsargs.flags | _XMS_ALL_DUPS;
                break;
            case 'i':
                // Case insensitive sort
                xmsargs.flags = xmsargs.flags | _XMS_IGNORE_CASE;
                break;
            case 't':
                // Error out if any input file is not sorted
                xmsargs.flags = xmsargs.flags | _XMS_SORTED_FILE;
                break;
            case 'd':
                // Print number of lines written to outfile
                xmsargs.flags = xmsargs.flags | _XMS_GET_SORTED_N;
                break;
            case '?':
                usage_term();
                break;
            default:
                break;
        }
    }

    // Three files must to execute. TODO Extend this to 10 files
    if ((argc - optind) != _XMS_NUM_FILES) {
        int mfil = _XMS_NUM_FILES;
        printf ("Require %d file names!\n", mfil);
        usage_term();
    }
    xmsargs.outfile = argv[optind + 0];
    xmsargs.infile1 = argv[optind + 1];
    xmsargs.infile2 = argv[optind + 2];

    sys_xmergesort_args_t* p_xmsargs = &xmsargs;
    ret = syscall(__NR_xmergesort, p_xmsargs);
    if (ret == 0) {
        if (xmsargs.flags & _XMS_GET_SORTED_N) {
            // In case of -d, print xmsargs.data. Trust the syscall that
            // xmsargs.data won't be NULL as it hasn't returned an error
            printf ("%d lines written to outfile\n", *(xmsargs.data));
        }
    } else {
        // <<<<<< Take care of each errno with a message meaningful to user
        perror("sys_xmergesort failed. Reason");
    }

    return (ret);
}

void usage_term(void)
{
    printf ("Usage: ./xmergesort [-uaitd] ");
    printf ("<outfile.txt> <file1.txt> <file2.txt>\n");
    exit (EXIT_FAILURE);
}
