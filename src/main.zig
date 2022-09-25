const std = @import("std");
const c = @import("glfw3.zig");

pub fn main() !void {
    // _ = try c.load("/opt/homebrew/opt/glfw/lib/libglfw.3.dylib");
    _ = try c.load("libglfw.so.3");

    _ = c.glfwInit();
    defer c.glfwTerminate();

    const w = c.glfwCreateWindow(800, 600, "Hello", null, null);
    defer c.glfwDestroyWindow(w);

    while (c.glfwWindowShouldClose(w) != c.GLFW_TRUE) {
        c.glfwWaitEvents();
    }
}
