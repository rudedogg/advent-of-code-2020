const std = @import("std");

pub fn main() void {
    std.debug.print("I am {s}!\n", .{"ready"});
}
