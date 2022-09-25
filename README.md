Failed attempt to cross-compile for raspi (32bit) with dynamic-loading of system-installed GLFW,
without actually having it installed on your source system (which can be mac, for example).

```
zig build -Dtarget=arm-linux-musleabi
scp ./zig-out/bin/hello-glfw ...
```
