/* sys_xmergesort system call */

#ifndef _SYS_XMERGESORT_H
#define _SYS_XMERGESORT_H

// Flags for sys_xmergesort()
#define _XMS_NO_DUP        1 << 0
#define _XMS_ALL_DUPS      1 << 1
#define _XMS_IGNORE_CASE   1 << 2
#define _XMS_SORTED_FILE   1 << 4
#define _XMS_GET_SORTED_N  1 << 5

// Number of files required to call sys_xmergesort()
#define _XMS_NUM_FILES 3

/*     struct sys_xmergesort_args
 *     Contains arguments for sys_xmergesort system call
 *
 *     char* infile1 - First file to be merge sorted
 *     char* infile2 - Second file to be merge sorted
 *     char* outfile - Output file
 *     u_int flags   - 0x01 Output sorted records and show only
 *                          one copy of duplicates.
 *                     0x02 Output sorted records and show
 *                          all copies of duplicates.
 *                     0x04 Case insensitive sort. Case sensitive by default.
 *                     0x10 Return error if input records not sorted.
 *                          By default this drops unsorted records and
 *                          outputs only increasing order records.
 *                     0x20 Return the number of sorted records written
 *                          to outfile in u_int* data.
 *     u_int* data   - Number of files written to outfile. Depends on flags.
 */

struct sys_xmergesort_args {
    char*  infile1;
    char*  infile2;
    char*  outfile;
    u_int  flags;
    u_int* data;
};

typedef struct sys_xmergesort_args sys_xmergesort_args_t;

#endif
