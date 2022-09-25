Minimal example how to cross-compile for 32bit raspi & use system-installed GLFW,
without actually having it installed on your source system (which can be mac, for example).

You need to use GNU libc as a target and this custom patch to zig.
https://github.com/ziglang/zig/issues/3287#issuecomment-1038914646

Expects GLFW 3.3 (`sudo apt install libglfw3`) and latest raspi OS (September 2022)

```
zig build -Dtarget=arm-linux-gnueabihf
scp ./zig-out/bin/hello-glfw ...
```
