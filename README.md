Failed attempt to cross-compile for raspi (32bit) with dynamic-loading of system-installed GLFW,
without actually having it installed on your source system (which can be mac, for example).

It looks like it works on mac but it doesn't when compiled for raspi (at least not with musl and gnu does not compile at all - missing arm-features.h).

```
zig build -Dtarget=arm-linux-musleabi
scp ./zig-out/bin/hello-glfw ...
```
