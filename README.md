Update: it seems to barely work with gnu and this custom patch to zig.
https://github.com/ziglang/zig/issues/3287#issuecomment-1038914646
Many fns are currently commented out because I'm using fairly old raspi

An attempt to cross-compile for raspi (32bit) with dynamic-loading of system-installed GLFW,
without actually having it installed on your source system (which can be mac, for example).

```
zig build -Dtarget=arm-linux-gnueabihf
scp ./zig-out/bin/hello-glfw ...
```
