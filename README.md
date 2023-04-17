# Zig CC for V

> A cross-compiler for V

## For Linux

0. Install V and Zig

1. Install this application
    ```bash
    v install malisipi.vzcc
    ```
    or
    ```bash
    git clone https://github.com/malisipi/vzcc
    mkdir ~/.vmodules/malisipi/
    mv vzcc ~/.vmodules/malisipi/vzcc
    ```

2. Compile this application
    ```bash
    v ~/.vmodules/malisipi/vzcc
    ```

3. Allow to run & Symlink zig_cc file
    ```bash
    sudo chmod +x ~/.vmodules/malisipi/vzcc/src/zig_cc
    sudo ln -sr ~/.vmodules/malisipi/vzcc/src/zig_cc /bin/zig_cc
    ```

4. Symlink this application (Optional)
    ```bash
    sudo ln -sr ~/.vmodules/malisipi/vzcc/vzcc /bin/vzcc
    ```

5. You're ready to go

## How To Use?

```basg
vzcc [input_file] [output_file]
===>      a.v        a.out
vzcc [input_file] [target_os] [output_file]
===>      a.v       windows      a.exe
vzcc [input_file] [target_arch] [target_os] [output_file]
===>      a.v        x86_64       windows      a.exe
vzcc [input_file] [target_arch] [target_os] [output_file] [target_flags]
===>      a.v        x86_64       windows      a.exe          -gnu

[target_arch]: If undefined, your os arch will be used as target
[target_os]: If undefined, your os will be used as target
[target_flags]: "" is default
```