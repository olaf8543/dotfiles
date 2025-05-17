
Permissions of a file can be seen by going to a directory with any files and running
`ls -l`. This will show 3 letters at the beginning of the file name: r, w, and x.

r - User can read this file
w - User can write in this file
x - User can execute this file

```
-rw-r--r-- 12 linuxize users 12.0K Apr  8 20:51 filename.txt
|[-][-][-]-   [------] [---]
| |  |  | |      |       |
| |  |  | |      |       +-----------> 7. Group
| |  |  | |      +-------------------> 6. Owner
| |  |  | +--------------------------> 5. Alternate Access Method
| |  |  +----------------------------> 4. Others Permissions
| |  +-------------------------------> 3. Group Permissions
| +----------------------------------> 2. Owner Permissions
+------------------------------------> 1. File Type
```

The user can edit these permissions with the `chmod` [command](Commands.md) 