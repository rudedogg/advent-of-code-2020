const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    std.debug.print("Hello day {d}\n", .{3});
}
