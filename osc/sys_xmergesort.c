#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/linkage.h>
#include "sys_xmergesort.h"
#include <linux/moduleloader.h>

//        printk("Xmergesort: \n");
asmlinkage extern long (*sysptr)(void* args);
long readsXMSLine(void);
long XMSisUniqueFile(struct file* filp1, struct file* filp2);
long XMSprechecks(struct file* filp_infile1,
                  struct file* filp_infile2,
                         u_int kflags);

long XMSopensFile(const char* name,
                  int flags,
                  int mode,
                  struct file** filp);

/* Code for sys_xmergesort system call
 * @ARGS
 *     void* args - pointer to struct sys_xmergesort_args
 *
 * @RETURN long
 *      0 - No error
 *     -1 - Error. Proper errno will be set. //<<<<<< This returns errors.
 *     Later errno is set
 */
asmlinkage long xmergesort(void* args)
{
    long ret = 0;
    int xms_written_lines = 0;
    struct filename *fn_inf1, *fn_inf2, *fn_outf;
    struct file *filp_infile1, *filp_infile2, *filp_outfile;
    const void __user * vp_uargs = args;
    const int* phy_xms_written_lines = &xms_written_lines;
    sys_xmergesort_args_t* phy_xmsargs = NULL;

    fn_inf1 = fn_inf2 = fn_outf = NULL;
    filp_infile1 = filp_infile2 = filp_outfile = NULL;
    printk("Xmergesort: Function entry\n");

    // Check if received params are null
    if (args == NULL) {
        printk("Xmergesort: No arguments received.\n");
        ret = -EPERM;
        goto cleanup;
    }

    // Copy argument object to kern space
    phy_xmsargs = (sys_xmergesort_args_t*)kmalloc(sizeof(sys_xmergesort_args_t),
                                                  GFP_KERNEL);
    if (phy_xmsargs == NULL) {
        printk("Xmergesort: Failed to allocate mem for args");
        ret = -ENOMEM;
        goto cleanup;
    }
    if (copy_from_user(phy_xmsargs, vp_uargs, sizeof(sys_xmergesort_args_t))) {
        // Failed to copy the args object to kernel space
        printk("Xmergesort: Failed to copy args object\n");
        ret = -EIO;
        goto freemem_exit;
    }

    // Validate input filename strings and construct struct filename
    // XXX Making a function will use a similar number of instructions
    // XXX So used duplicate code
    fn_inf1 = getname(phy_xmsargs->infile1);
    if (fn_inf1 == NULL) {
        // can't print bad filename
        printk("Xmergesort precheck: getname() failed for infile1\n");
        ret = -EIO;
        goto freemem_exit;
    }
    fn_inf2 = getname(phy_xmsargs->infile2);
    if (fn_inf2 == NULL) {
        // can't print bad filename
        printk("Xmergesort precheck: getname() failed for infile2\n");
        ret = -EIO;
        goto freemem_exit;
    }
    fn_outf = getname(phy_xmsargs->outfile);
    if (fn_outf == NULL) {
        // can't print bad filename
        printk("Xmergesort precheck: getname() failed for outfile\n");
        ret = -EIO;
        goto freemem_exit;
    }

    // Both input files should exist
    ret = XMSopensFile(fn_inf1->name, O_RDONLY, 0, &filp_infile1);
    if(ret) {
        goto freemem_exit; // No files opened yet
    }
    ret = XMSopensFile(fn_inf2->name, O_RDONLY, 0, &filp_infile2);
    if(ret) {
        goto closefiles_exit; // Prev file is open
    }

    // Run prechecks
    ret = XMSprechecks(filp_infile1,
                       filp_infile2,
                       phy_xmsargs->flags);
    if(ret) {
        printk("Xmergesort: Precheck failed with return code %ld \n", ret);
        goto closefiles_exit;
    }

    // Check if outfile is present already, then create outfile
    /*ret = XMSopensFile(fn_outf->name,
                       O_WRONLY|O_CREAT|O_EXCL,
                       S_IRWXU|S_IRGRP|S_IROTH,
                       &filp_outfile);
    if(ret || (filp_outfile == NULL)) { //<<<<< outfile mode
        printk("Xmergesort: Failed to create outfile\n");
        goto closefiles_exit;
    }*/

    // Make sure outfile is not the same as infiles
    ret = XMSisUniqueFile(filp_infile1, filp_outfile);
    if (ret) {
        printk("Xmergesort: Outfile can't be same as infile1\n");
        goto closefiles_exit;
    }
    ret = XMSisUniqueFile(filp_infile2, filp_outfile);
    if (ret) {
        printk("Xmergesort: Outfile can't be same as infile2\n");
        goto closefiles_exit;
    }

//==============================================================================
    // Merge sort loop
    ret = readsXMSLine();
    if(ret) {
        printk("Xmergesort: Merge failed with return code %ld \n", ret);
        goto closefiles_exit;
    }

    // Run Postchecks
    // If call failed.. remove partially written output file
    // else Rename the temp write file to output file
//==============================================================================

    // Return number of lines written to outfile to userspace
    if (phy_xmsargs->flags & _XMS_GET_SORTED_N) {
        short int ctu_ret = copy_to_user(phy_xmsargs->data,
                                         phy_xms_written_lines,
                                         sizeof(int));
        if (ctu_ret) {
             printk("Xmergesort: Failed to return number of lines written\n");
             ret = -EIO;
             goto closefiles_exit;
        }
    }

closefiles_exit:
    if (filp_infile1) {
        filp_close(filp_infile1, NULL);
    }
    if (filp_infile2) {
        filp_close(filp_infile2, NULL);
    }
    if (filp_outfile) {
        filp_close(filp_outfile, NULL);
    }
    //outfile temp <<<<<<

freemem_exit:
    kfree(phy_xmsargs);
    if (fn_inf1 != NULL) {
        putname(fn_inf1);
    }
    if (fn_inf2 != NULL) {
        putname(fn_inf2);
    }
    if (fn_outf != NULL) {
        putname(fn_outf);
    }
    //file reading buffers <<<<<<

cleanup:
    printk("Xmergesort: Function exit\n");
    return ret;
}

/*
 * Reads one line from the given file pointer and returns
 * the number of chars read
 */
long readsXMSLine(void/*file seek, file inode or fd, char* buf*/)
{
    return 0;
}

/* Runs checks that must be satisfied before mergesorting the files
 * @ARGS
 *     struct file* filp_infile1
 *     struct file* filp_infile2
 *            u_int kflags
 *
 * @RETURN long
 *     0         No error
 *     -EISDIR   One of the files is a dir
 *     -EACCES   One of the files does not grant read perm to fsuid
 *     -EPERM    Bad combination of flags passed. Or file is pipe or socket.
 *               Or both input files point to same inode.
 *
 */
long XMSprechecks(struct file* filp_infile1,
                  struct file* filp_infile2,
                  u_int        kflags)
{
    long ret = 0;
    // Are both passed files the same inode?
    ret = XMSisUniqueFile(filp_infile1, filp_infile2);
    if (ret) {
        printk("Xmergesort prechecks: both input files cannot be the same");
        return ret;
    }

    // Is this a regular file or a dir or pipe or socket?
    if (!S_ISREG(filp_infile1->f_inode->i_mode)) {
        printk("Xmergesort prechecks: infile1 is not a regular file\n");
        // filp_open takes care of links
        if (!S_ISDIR(filp_infile1->f_inode->i_mode))
            return -EISDIR;
        else
            return -EPERM;
    }
    if (!S_ISREG(filp_infile2->f_inode->i_mode)) {
        printk("Xmergesort prechecks: infile2 is not a regular file\n");
        // filp_open takes care of links
        if (!S_ISDIR(filp_infile1->f_inode->i_mode))
            return -EISDIR;
        else
            return -EPERM;
    }

    // Both files should give us read perm
    ret = (long)generic_permission(filp_infile1->f_inode, MAY_READ);
    if (ret) {
        printk("Xmergesort prechecks: infile1 doesn't allow read\n");
        return ret;
    }
    ret = (long)generic_permission(filp_infile2->f_inode, MAY_READ);
    if (ret) {
        printk("Xmergesort prechecks: infile2 doesn't allow read\n");
        return ret;
    }

    // Bad flags?
    if ((kflags & _XMS_NO_DUP) &&
        (kflags & _XMS_ALL_DUPS)) {
        printk("Xmergesort prechecks: Bad duplicate write flags\n");
        ret = -EPERM;
        return ret;
    }

    return ret;
}

/*
 * Opens a file and populates struct file*
 * @ARGS
 *     const char* name
 *     int flags
 *     int mode
 *     struct file* filp
 *
 * @RETURN
 *     0 No error
 *     PTR_ERR
 */
long XMSopensFile(const char* name,
                  int flags,
                  int mode,
                  struct file** filp)
{
    *filp = filp_open(name, flags, mode);
    if ((!filp) || IS_ERR(filp)) {
        printk("Error opening file %s. Error: %d\n",
                name,
                (int)PTR_ERR(filp));
        return PTR_ERR(filp);
    }
    return 0;
}

/*
 * Checks if two files point to the same inode in the same file system
 * @ARGS
 *     struct file* filp1
 *     struct file* filp2
 *
 * @RETURN long
 *     0        No error
 *     -EPERM   Files are same
 */
long XMSisUniqueFile(struct file* filp1, struct file* filp2)
{
    long ret = 0;
    if (filp1->f_inode->i_ino == filp2->f_inode->i_ino) {
        short int i, flag = 0;
        for (i = 0; i < 16; i++) {
            if (filp1->f_inode->i_sb->s_uuid[i] !=
                filp2->f_inode->i_sb->s_uuid[i]) {
                flag = 1;
            }
        }
        if (!flag) {
            // Inode numbers are same and this is the same FS
            ret = -EPERM;
        }
    }
    return ret;
}














/*
 * Loads the module xmergesort to kernel
 */
static int __init init_sys_xmergesort(void)
{
    printk("Installed new sys_xmergesort module\n");
    if (sysptr == NULL) {
        sysptr = xmergesort;
    }
    return 0;
}

/*
 * Unloads the module xmergesort from kernel
 */
static void  __exit exit_sys_xmergesort(void)
{
    if (sysptr != NULL) {
        sysptr = NULL;
    }
    printk("Removed sys_xmergesort module\n");
}

module_init(init_sys_xmergesort);
module_exit(exit_sys_xmergesort);
MODULE_LICENSE("GPL");
