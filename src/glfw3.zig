const std = @import("std");

pub fn load(path: []const u8) !std.DynLib {
    @setEvalBranchQuota(2000);

    var lib = std.DynLib.open(path) catch return error.GlfwNotFound;

    inline for (@typeInfo(@This()).Struct.decls) |d| {
        const T = @TypeOf(@field(@This(), d.name));

        if (comptime std.meta.trait.isPtrTo(.Fn)(T)) {
            @field(@This(), d.name) = lib.lookup(T, d.name ++ "") orelse {
                std.debug.print("SymbolNotFound: {s}\n", .{d.name});
                return error.SymbolNotFound;
            };
        }
    }

    return lib;
}

// copy-pasted from `zig translate-c glfw3.h` (3.3-stable)
// with `pub extern fn xxx()` changed to `pub var xxx: *fn()`

// /*************************************************************************
//  * GLFW 3.3 - www.glfw.org
//  * A library for OpenGL, window and input
//  *------------------------------------------------------------------------
//  * Copyright (c) 2002-2006 Marcus Geelnard
//  * Copyright (c) 2006-2019 Camilla Löwy <elmindreda@glfw.org>
//  *
//  * This software is provided 'as-is', without any express or implied
//  * warranty. In no event will the authors be held liable for any damages
//  * arising from the use of this software.
//  *
//  * Permission is granted to anyone to use this software for any purpose,
//  * including commercial applications, and to alter it and redistribute it
//  * freely, subject to the following restrictions:
//  *
//  * 1. The origin of this software must not be misrepresented; you must not
//  *    claim that you wrote the original software. If you use this software
//  *    in a product, an acknowledgment in the product documentation would
//  *    be appreciated but is not required.
//  *
//  * 2. Altered source versions must be plainly marked as such, and must not
//  *    be misrepresented as being the original software.
//  *
//  * 3. This notice may not be removed or altered from any source
//  *    distribution.
//  *
//  *************************************************************************/

pub const GLFWglproc = ?*const fn () callconv(.C) void;
pub const GLFWvkproc = ?*const fn () callconv(.C) void;
pub const struct_GLFWmonitor = opaque {};
pub const GLFWmonitor = struct_GLFWmonitor;
pub const struct_GLFWwindow = opaque {};
pub const GLFWwindow = struct_GLFWwindow;
pub const struct_GLFWcursor = opaque {};
pub const GLFWcursor = struct_GLFWcursor;
pub const GLFWerrorfun = ?*const fn (c_int, [*c]const u8) callconv(.C) void;
pub const GLFWwindowposfun = ?*const fn (?*GLFWwindow, c_int, c_int) callconv(.C) void;
pub const GLFWwindowsizefun = ?*const fn (?*GLFWwindow, c_int, c_int) callconv(.C) void;
pub const GLFWwindowclosefun = ?*const fn (?*GLFWwindow) callconv(.C) void;
pub const GLFWwindowrefreshfun = ?*const fn (?*GLFWwindow) callconv(.C) void;
pub const GLFWwindowfocusfun = ?*const fn (?*GLFWwindow, c_int) callconv(.C) void;
pub const GLFWwindowiconifyfun = ?*const fn (?*GLFWwindow, c_int) callconv(.C) void;
pub const GLFWwindowmaximizefun = ?*const fn (?*GLFWwindow, c_int) callconv(.C) void;
pub const GLFWframebuffersizefun = ?*const fn (?*GLFWwindow, c_int, c_int) callconv(.C) void;
pub const GLFWwindowcontentscalefun = ?*const fn (?*GLFWwindow, f32, f32) callconv(.C) void;
pub const GLFWmousebuttonfun = ?*const fn (?*GLFWwindow, c_int, c_int, c_int) callconv(.C) void;
pub const GLFWcursorposfun = ?*const fn (?*GLFWwindow, f64, f64) callconv(.C) void;
pub const GLFWcursorenterfun = ?*const fn (?*GLFWwindow, c_int) callconv(.C) void;
pub const GLFWscrollfun = ?*const fn (?*GLFWwindow, f64, f64) callconv(.C) void;
pub const GLFWkeyfun = ?*const fn (?*GLFWwindow, c_int, c_int, c_int, c_int) callconv(.C) void;
pub const GLFWcharfun = ?*const fn (?*GLFWwindow, c_uint) callconv(.C) void;
pub const GLFWcharmodsfun = ?*const fn (?*GLFWwindow, c_uint, c_int) callconv(.C) void;
pub const GLFWdropfun = ?*const fn (?*GLFWwindow, c_int, [*c][*c]const u8) callconv(.C) void;
pub const GLFWmonitorfun = ?*const fn (?*GLFWmonitor, c_int) callconv(.C) void;
pub const GLFWjoystickfun = ?*const fn (c_int, c_int) callconv(.C) void;
pub const struct_GLFWvidmode = extern struct {
    width: c_int,
    height: c_int,
    redBits: c_int,
    greenBits: c_int,
    blueBits: c_int,
    refreshRate: c_int,
};
pub const GLFWvidmode = struct_GLFWvidmode;
pub const struct_GLFWgammaramp = extern struct {
    red: [*c]c_ushort,
    green: [*c]c_ushort,
    blue: [*c]c_ushort,
    size: c_uint,
};
pub const GLFWgammaramp = struct_GLFWgammaramp;
pub const struct_GLFWimage = extern struct {
    width: c_int,
    height: c_int,
    pixels: [*c]u8,
};
pub const GLFWimage = struct_GLFWimage;
pub const struct_GLFWgamepadstate = extern struct {
    buttons: [15]u8,
    axes: [6]f32,
};
pub const GLFWgamepadstate = struct_GLFWgamepadstate;
pub var glfwInit: *fn () callconv(.C) c_int = undefined;
pub var glfwTerminate: *fn () callconv(.C) void = undefined;
pub var glfwInitHint: *fn (hint: c_int, value: c_int) callconv(.C) void = undefined;
pub var glfwGetVersion: *fn (major: [*c]c_int, minor: [*c]c_int, rev: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetVersionString: *fn () callconv(.C) [*c]const u8 = undefined;
pub var glfwGetError: *fn (description: [*c][*c]const u8) callconv(.C) c_int = undefined;
pub var glfwSetErrorCallback: *fn (callback: GLFWerrorfun) callconv(.C) GLFWerrorfun = undefined;
pub var glfwGetMonitors: *fn (count: [*c]c_int) callconv(.C) [*c]?*GLFWmonitor = undefined;
pub var glfwGetPrimaryMonitor: *fn () callconv(.C) ?*GLFWmonitor = undefined;
pub var glfwGetMonitorPos: *fn (monitor: ?*GLFWmonitor, xpos: [*c]c_int, ypos: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetMonitorWorkarea: *fn (monitor: ?*GLFWmonitor, xpos: [*c]c_int, ypos: [*c]c_int, width: [*c]c_int, height: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetMonitorPhysicalSize: *fn (monitor: ?*GLFWmonitor, widthMM: [*c]c_int, heightMM: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetMonitorContentScale: *fn (monitor: ?*GLFWmonitor, xscale: [*c]f32, yscale: [*c]f32) callconv(.C) void = undefined;
pub var glfwGetMonitorName: *fn (monitor: ?*GLFWmonitor) callconv(.C) [*c]const u8 = undefined;
pub var glfwSetMonitorUserPointer: *fn (monitor: ?*GLFWmonitor, pointer: ?*anyopaque) callconv(.C) void = undefined;
pub var glfwGetMonitorUserPointer: *fn (monitor: ?*GLFWmonitor) callconv(.C) ?*anyopaque = undefined;
pub var glfwSetMonitorCallback: *fn (callback: GLFWmonitorfun) callconv(.C) GLFWmonitorfun = undefined;
pub var glfwGetVideoModes: *fn (monitor: ?*GLFWmonitor, count: [*c]c_int) callconv(.C) [*c]const GLFWvidmode = undefined;
pub var glfwGetVideoMode: *fn (monitor: ?*GLFWmonitor) callconv(.C) [*c]const GLFWvidmode = undefined;
pub var glfwSetGamma: *fn (monitor: ?*GLFWmonitor, gamma: f32) callconv(.C) void = undefined;
pub var glfwGetGammaRamp: *fn (monitor: ?*GLFWmonitor) callconv(.C) [*c]const GLFWgammaramp = undefined;
pub var glfwSetGammaRamp: *fn (monitor: ?*GLFWmonitor, ramp: [*c]const GLFWgammaramp) callconv(.C) void = undefined;
pub var glfwDefaultWindowHints: *fn () callconv(.C) void = undefined;
pub var glfwWindowHint: *fn (hint: c_int, value: c_int) callconv(.C) void = undefined;
pub var glfwWindowHintString: *fn (hint: c_int, value: [*c]const u8) callconv(.C) void = undefined;
pub var glfwCreateWindow: *fn (width: c_int, height: c_int, title: [*c]const u8, monitor: ?*GLFWmonitor, share: ?*GLFWwindow) callconv(.C) ?*GLFWwindow = undefined;
pub var glfwDestroyWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwWindowShouldClose: *fn (window: ?*GLFWwindow) callconv(.C) c_int = undefined;
pub var glfwSetWindowShouldClose: *fn (window: ?*GLFWwindow, value: c_int) callconv(.C) void = undefined;
pub var glfwSetWindowTitle: *fn (window: ?*GLFWwindow, title: [*c]const u8) callconv(.C) void = undefined;
pub var glfwSetWindowIcon: *fn (window: ?*GLFWwindow, count: c_int, images: [*c]const GLFWimage) callconv(.C) void = undefined;
pub var glfwGetWindowPos: *fn (window: ?*GLFWwindow, xpos: [*c]c_int, ypos: [*c]c_int) callconv(.C) void = undefined;
pub var glfwSetWindowPos: *fn (window: ?*GLFWwindow, xpos: c_int, ypos: c_int) callconv(.C) void = undefined;
pub var glfwGetWindowSize: *fn (window: ?*GLFWwindow, width: [*c]c_int, height: [*c]c_int) callconv(.C) void = undefined;
pub var glfwSetWindowSizeLimits: *fn (window: ?*GLFWwindow, minwidth: c_int, minheight: c_int, maxwidth: c_int, maxheight: c_int) callconv(.C) void = undefined;
pub var glfwSetWindowAspectRatio: *fn (window: ?*GLFWwindow, numer: c_int, denom: c_int) callconv(.C) void = undefined;
pub var glfwSetWindowSize: *fn (window: ?*GLFWwindow, width: c_int, height: c_int) callconv(.C) void = undefined;
pub var glfwGetFramebufferSize: *fn (window: ?*GLFWwindow, width: [*c]c_int, height: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetWindowFrameSize: *fn (window: ?*GLFWwindow, left: [*c]c_int, top: [*c]c_int, right: [*c]c_int, bottom: [*c]c_int) callconv(.C) void = undefined;
pub var glfwGetWindowContentScale: *fn (window: ?*GLFWwindow, xscale: [*c]f32, yscale: [*c]f32) callconv(.C) void = undefined;
pub var glfwGetWindowOpacity: *fn (window: ?*GLFWwindow) callconv(.C) f32 = undefined;
pub var glfwSetWindowOpacity: *fn (window: ?*GLFWwindow, opacity: f32) callconv(.C) void = undefined;
pub var glfwIconifyWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwRestoreWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwMaximizeWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwShowWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwHideWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwFocusWindow: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwRequestWindowAttention: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwGetWindowMonitor: *fn (window: ?*GLFWwindow) callconv(.C) ?*GLFWmonitor = undefined;
pub var glfwSetWindowMonitor: *fn (window: ?*GLFWwindow, monitor: ?*GLFWmonitor, xpos: c_int, ypos: c_int, width: c_int, height: c_int, refreshRate: c_int) callconv(.C) void = undefined;
pub var glfwGetWindowAttrib: *fn (window: ?*GLFWwindow, attrib: c_int) callconv(.C) c_int = undefined;
pub var glfwSetWindowAttrib: *fn (window: ?*GLFWwindow, attrib: c_int, value: c_int) callconv(.C) void = undefined;
pub var glfwSetWindowUserPointer: *fn (window: ?*GLFWwindow, pointer: ?*anyopaque) callconv(.C) void = undefined;
pub var glfwGetWindowUserPointer: *fn (window: ?*GLFWwindow) callconv(.C) ?*anyopaque = undefined;
pub var glfwSetWindowPosCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowposfun) callconv(.C) GLFWwindowposfun = undefined;
pub var glfwSetWindowSizeCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowsizefun) callconv(.C) GLFWwindowsizefun = undefined;
pub var glfwSetWindowCloseCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowclosefun) callconv(.C) GLFWwindowclosefun = undefined;
pub var glfwSetWindowRefreshCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowrefreshfun) callconv(.C) GLFWwindowrefreshfun = undefined;
pub var glfwSetWindowFocusCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowfocusfun) callconv(.C) GLFWwindowfocusfun = undefined;
pub var glfwSetWindowIconifyCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowiconifyfun) callconv(.C) GLFWwindowiconifyfun = undefined;
pub var glfwSetWindowMaximizeCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowmaximizefun) callconv(.C) GLFWwindowmaximizefun = undefined;
pub var glfwSetFramebufferSizeCallback: *fn (window: ?*GLFWwindow, callback: GLFWframebuffersizefun) callconv(.C) GLFWframebuffersizefun = undefined;
pub var glfwSetWindowContentScaleCallback: *fn (window: ?*GLFWwindow, callback: GLFWwindowcontentscalefun) callconv(.C) GLFWwindowcontentscalefun = undefined;
pub var glfwPollEvents: *fn () callconv(.C) void = undefined;
pub var glfwWaitEvents: *fn () callconv(.C) void = undefined;
pub var glfwWaitEventsTimeout: *fn (timeout: f64) callconv(.C) void = undefined;
pub var glfwPostEmptyEvent: *fn () callconv(.C) void = undefined;
pub var glfwGetInputMode: *fn (window: ?*GLFWwindow, mode: c_int) callconv(.C) c_int = undefined;
pub var glfwSetInputMode: *fn (window: ?*GLFWwindow, mode: c_int, value: c_int) callconv(.C) void = undefined;
pub var glfwRawMouseMotionSupported: *fn () callconv(.C) c_int = undefined;
pub var glfwGetKeyName: *fn (key: c_int, scancode: c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetKeyScancode: *fn (key: c_int) callconv(.C) c_int = undefined;
pub var glfwGetKey: *fn (window: ?*GLFWwindow, key: c_int) callconv(.C) c_int = undefined;
pub var glfwGetMouseButton: *fn (window: ?*GLFWwindow, button: c_int) callconv(.C) c_int = undefined;
pub var glfwGetCursorPos: *fn (window: ?*GLFWwindow, xpos: [*c]f64, ypos: [*c]f64) callconv(.C) void = undefined;
pub var glfwSetCursorPos: *fn (window: ?*GLFWwindow, xpos: f64, ypos: f64) callconv(.C) void = undefined;
pub var glfwCreateCursor: *fn (image: [*c]const GLFWimage, xhot: c_int, yhot: c_int) callconv(.C) ?*GLFWcursor = undefined;
pub var glfwCreateStandardCursor: *fn (shape: c_int) callconv(.C) ?*GLFWcursor = undefined;
pub var glfwDestroyCursor: *fn (cursor: ?*GLFWcursor) callconv(.C) void = undefined;
pub var glfwSetCursor: *fn (window: ?*GLFWwindow, cursor: ?*GLFWcursor) callconv(.C) void = undefined;
pub var glfwSetKeyCallback: *fn (window: ?*GLFWwindow, callback: GLFWkeyfun) callconv(.C) GLFWkeyfun = undefined;
pub var glfwSetCharCallback: *fn (window: ?*GLFWwindow, callback: GLFWcharfun) callconv(.C) GLFWcharfun = undefined;
pub var glfwSetCharModsCallback: *fn (window: ?*GLFWwindow, callback: GLFWcharmodsfun) callconv(.C) GLFWcharmodsfun = undefined;
pub var glfwSetMouseButtonCallback: *fn (window: ?*GLFWwindow, callback: GLFWmousebuttonfun) callconv(.C) GLFWmousebuttonfun = undefined;
pub var glfwSetCursorPosCallback: *fn (window: ?*GLFWwindow, callback: GLFWcursorposfun) callconv(.C) GLFWcursorposfun = undefined;
pub var glfwSetCursorEnterCallback: *fn (window: ?*GLFWwindow, callback: GLFWcursorenterfun) callconv(.C) GLFWcursorenterfun = undefined;
pub var glfwSetScrollCallback: *fn (window: ?*GLFWwindow, callback: GLFWscrollfun) callconv(.C) GLFWscrollfun = undefined;
pub var glfwSetDropCallback: *fn (window: ?*GLFWwindow, callback: GLFWdropfun) callconv(.C) GLFWdropfun = undefined;
pub var glfwJoystickPresent: *fn (jid: c_int) callconv(.C) c_int = undefined;
pub var glfwGetJoystickAxes: *fn (jid: c_int, count: [*c]c_int) callconv(.C) [*c]const f32 = undefined;
pub var glfwGetJoystickButtons: *fn (jid: c_int, count: [*c]c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetJoystickHats: *fn (jid: c_int, count: [*c]c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetJoystickName: *fn (jid: c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetJoystickGUID: *fn (jid: c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwSetJoystickUserPointer: *fn (jid: c_int, pointer: ?*anyopaque) callconv(.C) void = undefined;
pub var glfwGetJoystickUserPointer: *fn (jid: c_int) callconv(.C) ?*anyopaque = undefined;
pub var glfwJoystickIsGamepad: *fn (jid: c_int) callconv(.C) c_int = undefined;
pub var glfwSetJoystickCallback: *fn (callback: GLFWjoystickfun) callconv(.C) GLFWjoystickfun = undefined;
pub var glfwUpdateGamepadMappings: *fn (string: [*c]const u8) callconv(.C) c_int = undefined;
pub var glfwGetGamepadName: *fn (jid: c_int) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetGamepadState: *fn (jid: c_int, state: [*c]GLFWgamepadstate) callconv(.C) c_int = undefined;
pub var glfwSetClipboardString: *fn (window: ?*GLFWwindow, string: [*c]const u8) callconv(.C) void = undefined;
pub var glfwGetClipboardString: *fn (window: ?*GLFWwindow) callconv(.C) [*c]const u8 = undefined;
pub var glfwGetTime: *fn () callconv(.C) f64 = undefined;
pub var glfwSetTime: *fn (time: f64) callconv(.C) void = undefined;
pub var glfwGetTimerValue: *fn () callconv(.C) u64 = undefined;
pub var glfwGetTimerFrequency: *fn () callconv(.C) u64 = undefined;
pub var glfwMakeContextCurrent: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwGetCurrentContext: *fn () callconv(.C) ?*GLFWwindow = undefined;
pub var glfwSwapBuffers: *fn (window: ?*GLFWwindow) callconv(.C) void = undefined;
pub var glfwSwapInterval: *fn (interval: c_int) callconv(.C) void = undefined;
pub var glfwExtensionSupported: *fn (extension: [*c]const u8) callconv(.C) c_int = undefined;
pub var glfwGetProcAddress: *fn (procname: [*c]const u8) callconv(.C) GLFWglproc = undefined;
pub var glfwVulkanSupported: *fn () callconv(.C) c_int = undefined;
pub var glfwGetRequiredInstanceExtensions: *fn (count: [*c]u32) callconv(.C) [*c][*c]const u8 = undefined;
pub const _DEBUG = @as(c_int, 1);
pub const GLFW_INCLUDE_NONE = @as(c_int, 1);
pub const _glfw3_h_ = "";
pub const __STDDEF_H = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const _STDINT_H_ = "";
pub const __WORDSIZE = @as(c_int, 64);
pub const APIENTRY = "";
pub const GLFW_APIENTRY_DEFINED = "";
pub const GLFWAPI = "";
pub const GLFW_VERSION_MAJOR = @as(c_int, 3);
pub const GLFW_VERSION_MINOR = @as(c_int, 3);
pub const GLFW_VERSION_REVISION = @as(c_int, 9);
pub const GLFW_TRUE = @as(c_int, 1);
pub const GLFW_FALSE = @as(c_int, 0);
pub const GLFW_RELEASE = @as(c_int, 0);
pub const GLFW_PRESS = @as(c_int, 1);
pub const GLFW_REPEAT = @as(c_int, 2);
pub const GLFW_HAT_CENTERED = @as(c_int, 0);
pub const GLFW_HAT_UP = @as(c_int, 1);
pub const GLFW_HAT_RIGHT = @as(c_int, 2);
pub const GLFW_HAT_DOWN = @as(c_int, 4);
pub const GLFW_HAT_LEFT = @as(c_int, 8);
pub const GLFW_HAT_RIGHT_UP = GLFW_HAT_RIGHT | GLFW_HAT_UP;
pub const GLFW_HAT_RIGHT_DOWN = GLFW_HAT_RIGHT | GLFW_HAT_DOWN;
pub const GLFW_HAT_LEFT_UP = GLFW_HAT_LEFT | GLFW_HAT_UP;
pub const GLFW_HAT_LEFT_DOWN = GLFW_HAT_LEFT | GLFW_HAT_DOWN;
pub const GLFW_KEY_UNKNOWN = -@as(c_int, 1);
pub const GLFW_KEY_SPACE = @as(c_int, 32);
pub const GLFW_KEY_APOSTROPHE = @as(c_int, 39);
pub const GLFW_KEY_COMMA = @as(c_int, 44);
pub const GLFW_KEY_MINUS = @as(c_int, 45);
pub const GLFW_KEY_PERIOD = @as(c_int, 46);
pub const GLFW_KEY_SLASH = @as(c_int, 47);
pub const GLFW_KEY_0 = @as(c_int, 48);
pub const GLFW_KEY_1 = @as(c_int, 49);
pub const GLFW_KEY_2 = @as(c_int, 50);
pub const GLFW_KEY_3 = @as(c_int, 51);
pub const GLFW_KEY_4 = @as(c_int, 52);
pub const GLFW_KEY_5 = @as(c_int, 53);
pub const GLFW_KEY_6 = @as(c_int, 54);
pub const GLFW_KEY_7 = @as(c_int, 55);
pub const GLFW_KEY_8 = @as(c_int, 56);
pub const GLFW_KEY_9 = @as(c_int, 57);
pub const GLFW_KEY_SEMICOLON = @as(c_int, 59);
pub const GLFW_KEY_EQUAL = @as(c_int, 61);
pub const GLFW_KEY_A = @as(c_int, 65);
pub const GLFW_KEY_B = @as(c_int, 66);
pub const GLFW_KEY_C = @as(c_int, 67);
pub const GLFW_KEY_D = @as(c_int, 68);
pub const GLFW_KEY_E = @as(c_int, 69);
pub const GLFW_KEY_F = @as(c_int, 70);
pub const GLFW_KEY_G = @as(c_int, 71);
pub const GLFW_KEY_H = @as(c_int, 72);
pub const GLFW_KEY_I = @as(c_int, 73);
pub const GLFW_KEY_J = @as(c_int, 74);
pub const GLFW_KEY_K = @as(c_int, 75);
pub const GLFW_KEY_L = @as(c_int, 76);
pub const GLFW_KEY_M = @as(c_int, 77);
pub const GLFW_KEY_N = @as(c_int, 78);
pub const GLFW_KEY_O = @as(c_int, 79);
pub const GLFW_KEY_P = @as(c_int, 80);
pub const GLFW_KEY_Q = @as(c_int, 81);
pub const GLFW_KEY_R = @as(c_int, 82);
pub const GLFW_KEY_S = @as(c_int, 83);
pub const GLFW_KEY_T = @as(c_int, 84);
pub const GLFW_KEY_U = @as(c_int, 85);
pub const GLFW_KEY_V = @as(c_int, 86);
pub const GLFW_KEY_W = @as(c_int, 87);
pub const GLFW_KEY_X = @as(c_int, 88);
pub const GLFW_KEY_Y = @as(c_int, 89);
pub const GLFW_KEY_Z = @as(c_int, 90);
pub const GLFW_KEY_LEFT_BRACKET = @as(c_int, 91);
pub const GLFW_KEY_BACKSLASH = @as(c_int, 92);
pub const GLFW_KEY_RIGHT_BRACKET = @as(c_int, 93);
pub const GLFW_KEY_GRAVE_ACCENT = @as(c_int, 96);
pub const GLFW_KEY_WORLD_1 = @as(c_int, 161);
pub const GLFW_KEY_WORLD_2 = @as(c_int, 162);
pub const GLFW_KEY_ESCAPE = @as(c_int, 256);
pub const GLFW_KEY_ENTER = @as(c_int, 257);
pub const GLFW_KEY_TAB = @as(c_int, 258);
pub const GLFW_KEY_BACKSPACE = @as(c_int, 259);
pub const GLFW_KEY_INSERT = @as(c_int, 260);
pub const GLFW_KEY_DELETE = @as(c_int, 261);
pub const GLFW_KEY_RIGHT = @as(c_int, 262);
pub const GLFW_KEY_LEFT = @as(c_int, 263);
pub const GLFW_KEY_DOWN = @as(c_int, 264);
pub const GLFW_KEY_UP = @as(c_int, 265);
pub const GLFW_KEY_PAGE_UP = @as(c_int, 266);
pub const GLFW_KEY_PAGE_DOWN = @as(c_int, 267);
pub const GLFW_KEY_HOME = @as(c_int, 268);
pub const GLFW_KEY_END = @as(c_int, 269);
pub const GLFW_KEY_CAPS_LOCK = @as(c_int, 280);
pub const GLFW_KEY_SCROLL_LOCK = @as(c_int, 281);
pub const GLFW_KEY_NUM_LOCK = @as(c_int, 282);
pub const GLFW_KEY_PRINT_SCREEN = @as(c_int, 283);
pub const GLFW_KEY_PAUSE = @as(c_int, 284);
pub const GLFW_KEY_F1 = @as(c_int, 290);
pub const GLFW_KEY_F2 = @as(c_int, 291);
pub const GLFW_KEY_F3 = @as(c_int, 292);
pub const GLFW_KEY_F4 = @as(c_int, 293);
pub const GLFW_KEY_F5 = @as(c_int, 294);
pub const GLFW_KEY_F6 = @as(c_int, 295);
pub const GLFW_KEY_F7 = @as(c_int, 296);
pub const GLFW_KEY_F8 = @as(c_int, 297);
pub const GLFW_KEY_F9 = @as(c_int, 298);
pub const GLFW_KEY_F10 = @as(c_int, 299);
pub const GLFW_KEY_F11 = @as(c_int, 300);
pub const GLFW_KEY_F12 = @as(c_int, 301);
pub const GLFW_KEY_F13 = @as(c_int, 302);
pub const GLFW_KEY_F14 = @as(c_int, 303);
pub const GLFW_KEY_F15 = @as(c_int, 304);
pub const GLFW_KEY_F16 = @as(c_int, 305);
pub const GLFW_KEY_F17 = @as(c_int, 306);
pub const GLFW_KEY_F18 = @as(c_int, 307);
pub const GLFW_KEY_F19 = @as(c_int, 308);
pub const GLFW_KEY_F20 = @as(c_int, 309);
pub const GLFW_KEY_F21 = @as(c_int, 310);
pub const GLFW_KEY_F22 = @as(c_int, 311);
pub const GLFW_KEY_F23 = @as(c_int, 312);
pub const GLFW_KEY_F24 = @as(c_int, 313);
pub const GLFW_KEY_F25 = @as(c_int, 314);
pub const GLFW_KEY_KP_0 = @as(c_int, 320);
pub const GLFW_KEY_KP_1 = @as(c_int, 321);
pub const GLFW_KEY_KP_2 = @as(c_int, 322);
pub const GLFW_KEY_KP_3 = @as(c_int, 323);
pub const GLFW_KEY_KP_4 = @as(c_int, 324);
pub const GLFW_KEY_KP_5 = @as(c_int, 325);
pub const GLFW_KEY_KP_6 = @as(c_int, 326);
pub const GLFW_KEY_KP_7 = @as(c_int, 327);
pub const GLFW_KEY_KP_8 = @as(c_int, 328);
pub const GLFW_KEY_KP_9 = @as(c_int, 329);
pub const GLFW_KEY_KP_DECIMAL = @as(c_int, 330);
pub const GLFW_KEY_KP_DIVIDE = @as(c_int, 331);
pub const GLFW_KEY_KP_MULTIPLY = @as(c_int, 332);
pub const GLFW_KEY_KP_SUBTRACT = @as(c_int, 333);
pub const GLFW_KEY_KP_ADD = @as(c_int, 334);
pub const GLFW_KEY_KP_ENTER = @as(c_int, 335);
pub const GLFW_KEY_KP_EQUAL = @as(c_int, 336);
pub const GLFW_KEY_LEFT_SHIFT = @as(c_int, 340);
pub const GLFW_KEY_LEFT_CONTROL = @as(c_int, 341);
pub const GLFW_KEY_LEFT_ALT = @as(c_int, 342);
pub const GLFW_KEY_LEFT_SUPER = @as(c_int, 343);
pub const GLFW_KEY_RIGHT_SHIFT = @as(c_int, 344);
pub const GLFW_KEY_RIGHT_CONTROL = @as(c_int, 345);
pub const GLFW_KEY_RIGHT_ALT = @as(c_int, 346);
pub const GLFW_KEY_RIGHT_SUPER = @as(c_int, 347);
pub const GLFW_KEY_MENU = @as(c_int, 348);
pub const GLFW_KEY_LAST = GLFW_KEY_MENU;
pub const GLFW_MOD_SHIFT = @as(c_int, 0x0001);
pub const GLFW_MOD_CONTROL = @as(c_int, 0x0002);
pub const GLFW_MOD_ALT = @as(c_int, 0x0004);
pub const GLFW_MOD_SUPER = @as(c_int, 0x0008);
pub const GLFW_MOD_CAPS_LOCK = @as(c_int, 0x0010);
pub const GLFW_MOD_NUM_LOCK = @as(c_int, 0x0020);
pub const GLFW_MOUSE_BUTTON_1 = @as(c_int, 0);
pub const GLFW_MOUSE_BUTTON_2 = @as(c_int, 1);
pub const GLFW_MOUSE_BUTTON_3 = @as(c_int, 2);
pub const GLFW_MOUSE_BUTTON_4 = @as(c_int, 3);
pub const GLFW_MOUSE_BUTTON_5 = @as(c_int, 4);
pub const GLFW_MOUSE_BUTTON_6 = @as(c_int, 5);
pub const GLFW_MOUSE_BUTTON_7 = @as(c_int, 6);
pub const GLFW_MOUSE_BUTTON_8 = @as(c_int, 7);
pub const GLFW_MOUSE_BUTTON_LAST = GLFW_MOUSE_BUTTON_8;
pub const GLFW_MOUSE_BUTTON_LEFT = GLFW_MOUSE_BUTTON_1;
pub const GLFW_MOUSE_BUTTON_RIGHT = GLFW_MOUSE_BUTTON_2;
pub const GLFW_MOUSE_BUTTON_MIDDLE = GLFW_MOUSE_BUTTON_3;
pub const GLFW_JOYSTICK_1 = @as(c_int, 0);
pub const GLFW_JOYSTICK_2 = @as(c_int, 1);
pub const GLFW_JOYSTICK_3 = @as(c_int, 2);
pub const GLFW_JOYSTICK_4 = @as(c_int, 3);
pub const GLFW_JOYSTICK_5 = @as(c_int, 4);
pub const GLFW_JOYSTICK_6 = @as(c_int, 5);
pub const GLFW_JOYSTICK_7 = @as(c_int, 6);
pub const GLFW_JOYSTICK_8 = @as(c_int, 7);
pub const GLFW_JOYSTICK_9 = @as(c_int, 8);
pub const GLFW_JOYSTICK_10 = @as(c_int, 9);
pub const GLFW_JOYSTICK_11 = @as(c_int, 10);
pub const GLFW_JOYSTICK_12 = @as(c_int, 11);
pub const GLFW_JOYSTICK_13 = @as(c_int, 12);
pub const GLFW_JOYSTICK_14 = @as(c_int, 13);
pub const GLFW_JOYSTICK_15 = @as(c_int, 14);
pub const GLFW_JOYSTICK_16 = @as(c_int, 15);
pub const GLFW_JOYSTICK_LAST = GLFW_JOYSTICK_16;
pub const GLFW_GAMEPAD_BUTTON_A = @as(c_int, 0);
pub const GLFW_GAMEPAD_BUTTON_B = @as(c_int, 1);
pub const GLFW_GAMEPAD_BUTTON_X = @as(c_int, 2);
pub const GLFW_GAMEPAD_BUTTON_Y = @as(c_int, 3);
pub const GLFW_GAMEPAD_BUTTON_LEFT_BUMPER = @as(c_int, 4);
pub const GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER = @as(c_int, 5);
pub const GLFW_GAMEPAD_BUTTON_BACK = @as(c_int, 6);
pub const GLFW_GAMEPAD_BUTTON_START = @as(c_int, 7);
pub const GLFW_GAMEPAD_BUTTON_GUIDE = @as(c_int, 8);
pub const GLFW_GAMEPAD_BUTTON_LEFT_THUMB = @as(c_int, 9);
pub const GLFW_GAMEPAD_BUTTON_RIGHT_THUMB = @as(c_int, 10);
pub const GLFW_GAMEPAD_BUTTON_DPAD_UP = @as(c_int, 11);
pub const GLFW_GAMEPAD_BUTTON_DPAD_RIGHT = @as(c_int, 12);
pub const GLFW_GAMEPAD_BUTTON_DPAD_DOWN = @as(c_int, 13);
pub const GLFW_GAMEPAD_BUTTON_DPAD_LEFT = @as(c_int, 14);
pub const GLFW_GAMEPAD_BUTTON_LAST = GLFW_GAMEPAD_BUTTON_DPAD_LEFT;
pub const GLFW_GAMEPAD_BUTTON_CROSS = GLFW_GAMEPAD_BUTTON_A;
pub const GLFW_GAMEPAD_BUTTON_CIRCLE = GLFW_GAMEPAD_BUTTON_B;
pub const GLFW_GAMEPAD_BUTTON_SQUARE = GLFW_GAMEPAD_BUTTON_X;
pub const GLFW_GAMEPAD_BUTTON_TRIANGLE = GLFW_GAMEPAD_BUTTON_Y;
pub const GLFW_GAMEPAD_AXIS_LEFT_X = @as(c_int, 0);
pub const GLFW_GAMEPAD_AXIS_LEFT_Y = @as(c_int, 1);
pub const GLFW_GAMEPAD_AXIS_RIGHT_X = @as(c_int, 2);
pub const GLFW_GAMEPAD_AXIS_RIGHT_Y = @as(c_int, 3);
pub const GLFW_GAMEPAD_AXIS_LEFT_TRIGGER = @as(c_int, 4);
pub const GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER = @as(c_int, 5);
pub const GLFW_GAMEPAD_AXIS_LAST = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER;
pub const GLFW_NO_ERROR = @as(c_int, 0);
pub const GLFW_NOT_INITIALIZED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010001, .hexadecimal);
pub const GLFW_NO_CURRENT_CONTEXT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010002, .hexadecimal);
pub const GLFW_INVALID_ENUM = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010003, .hexadecimal);
pub const GLFW_INVALID_VALUE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010004, .hexadecimal);
pub const GLFW_OUT_OF_MEMORY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010005, .hexadecimal);
pub const GLFW_API_UNAVAILABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010006, .hexadecimal);
pub const GLFW_VERSION_UNAVAILABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010007, .hexadecimal);
pub const GLFW_PLATFORM_ERROR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010008, .hexadecimal);
pub const GLFW_FORMAT_UNAVAILABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010009, .hexadecimal);
pub const GLFW_NO_WINDOW_CONTEXT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0001000A, .hexadecimal);
pub const GLFW_FOCUSED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020001, .hexadecimal);
pub const GLFW_ICONIFIED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020002, .hexadecimal);
pub const GLFW_RESIZABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020003, .hexadecimal);
pub const GLFW_VISIBLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020004, .hexadecimal);
pub const GLFW_DECORATED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020005, .hexadecimal);
pub const GLFW_AUTO_ICONIFY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020006, .hexadecimal);
pub const GLFW_FLOATING = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020007, .hexadecimal);
pub const GLFW_MAXIMIZED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020008, .hexadecimal);
pub const GLFW_CENTER_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020009, .hexadecimal);
pub const GLFW_TRANSPARENT_FRAMEBUFFER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002000A, .hexadecimal);
pub const GLFW_HOVERED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002000B, .hexadecimal);
pub const GLFW_FOCUS_ON_SHOW = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002000C, .hexadecimal);
pub const GLFW_RED_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021001, .hexadecimal);
pub const GLFW_GREEN_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021002, .hexadecimal);
pub const GLFW_BLUE_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021003, .hexadecimal);
pub const GLFW_ALPHA_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021004, .hexadecimal);
pub const GLFW_DEPTH_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021005, .hexadecimal);
pub const GLFW_STENCIL_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021006, .hexadecimal);
pub const GLFW_ACCUM_RED_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021007, .hexadecimal);
pub const GLFW_ACCUM_GREEN_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021008, .hexadecimal);
pub const GLFW_ACCUM_BLUE_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021009, .hexadecimal);
pub const GLFW_ACCUM_ALPHA_BITS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100A, .hexadecimal);
pub const GLFW_AUX_BUFFERS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100B, .hexadecimal);
pub const GLFW_STEREO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100C, .hexadecimal);
pub const GLFW_SAMPLES = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100D, .hexadecimal);
pub const GLFW_SRGB_CAPABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100E, .hexadecimal);
pub const GLFW_REFRESH_RATE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002100F, .hexadecimal);
pub const GLFW_DOUBLEBUFFER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00021010, .hexadecimal);
pub const GLFW_CLIENT_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022001, .hexadecimal);
pub const GLFW_CONTEXT_VERSION_MAJOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022002, .hexadecimal);
pub const GLFW_CONTEXT_VERSION_MINOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022003, .hexadecimal);
pub const GLFW_CONTEXT_REVISION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022004, .hexadecimal);
pub const GLFW_CONTEXT_ROBUSTNESS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022005, .hexadecimal);
pub const GLFW_OPENGL_FORWARD_COMPAT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022006, .hexadecimal);
pub const GLFW_OPENGL_DEBUG_CONTEXT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022007, .hexadecimal);
pub const GLFW_OPENGL_PROFILE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022008, .hexadecimal);
pub const GLFW_CONTEXT_RELEASE_BEHAVIOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00022009, .hexadecimal);
pub const GLFW_CONTEXT_NO_ERROR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002200A, .hexadecimal);
pub const GLFW_CONTEXT_CREATION_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002200B, .hexadecimal);
pub const GLFW_SCALE_TO_MONITOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x0002200C, .hexadecimal);
pub const GLFW_COCOA_RETINA_FRAMEBUFFER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00023001, .hexadecimal);
pub const GLFW_COCOA_FRAME_NAME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00023002, .hexadecimal);
pub const GLFW_COCOA_GRAPHICS_SWITCHING = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00023003, .hexadecimal);
pub const GLFW_X11_CLASS_NAME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00024001, .hexadecimal);
pub const GLFW_X11_INSTANCE_NAME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00024002, .hexadecimal);
pub const GLFW_NO_API = @as(c_int, 0);
pub const GLFW_OPENGL_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00030001, .hexadecimal);
pub const GLFW_OPENGL_ES_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00030002, .hexadecimal);
pub const GLFW_NO_ROBUSTNESS = @as(c_int, 0);
pub const GLFW_NO_RESET_NOTIFICATION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00031001, .hexadecimal);
pub const GLFW_LOSE_CONTEXT_ON_RESET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00031002, .hexadecimal);
pub const GLFW_OPENGL_ANY_PROFILE = @as(c_int, 0);
pub const GLFW_OPENGL_CORE_PROFILE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00032001, .hexadecimal);
pub const GLFW_OPENGL_COMPAT_PROFILE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00032002, .hexadecimal);
pub const GLFW_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00033001, .hexadecimal);
pub const GLFW_STICKY_KEYS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00033002, .hexadecimal);
pub const GLFW_STICKY_MOUSE_BUTTONS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00033003, .hexadecimal);
pub const GLFW_LOCK_KEY_MODS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00033004, .hexadecimal);
pub const GLFW_RAW_MOUSE_MOTION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00033005, .hexadecimal);
pub const GLFW_CURSOR_NORMAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00034001, .hexadecimal);
pub const GLFW_CURSOR_HIDDEN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00034002, .hexadecimal);
pub const GLFW_CURSOR_DISABLED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00034003, .hexadecimal);
pub const GLFW_ANY_RELEASE_BEHAVIOR = @as(c_int, 0);
pub const GLFW_RELEASE_BEHAVIOR_FLUSH = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00035001, .hexadecimal);
pub const GLFW_RELEASE_BEHAVIOR_NONE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00035002, .hexadecimal);
pub const GLFW_NATIVE_CONTEXT_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036001, .hexadecimal);
pub const GLFW_EGL_CONTEXT_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036002, .hexadecimal);
pub const GLFW_OSMESA_CONTEXT_API = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036003, .hexadecimal);
pub const GLFW_ARROW_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036001, .hexadecimal);
pub const GLFW_IBEAM_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036002, .hexadecimal);
pub const GLFW_CROSSHAIR_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036003, .hexadecimal);
pub const GLFW_HAND_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036004, .hexadecimal);
pub const GLFW_HRESIZE_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036005, .hexadecimal);
pub const GLFW_VRESIZE_CURSOR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00036006, .hexadecimal);
pub const GLFW_CONNECTED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040001, .hexadecimal);
pub const GLFW_DISCONNECTED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040002, .hexadecimal);
pub const GLFW_JOYSTICK_HAT_BUTTONS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00050001, .hexadecimal);
pub const GLFW_COCOA_CHDIR_RESOURCES = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00051001, .hexadecimal);
pub const GLFW_COCOA_MENUBAR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00051002, .hexadecimal);
pub const GLFW_DONT_CARE = -@as(c_int, 1);
pub const GLAPIENTRY = APIENTRY;
pub const GLFW_GLAPIENTRY_DEFINED = "";
