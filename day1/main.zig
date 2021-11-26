const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    // https://github.com/ziglang/zig/blob/a2c546fea30de2caf1efb454d327e70270c07338/lib/std/mem.zig#L1732
    var outerIterator = std.mem.split(u8, input, "\n");
    while (outerIterator.next()) |outerNumber| {
        const outerUInt = try std.fmt.parseUnsigned(u32, outerNumber, 10);
        var innerIterator = std.mem.split(u8, input, "\n");
        while (innerIterator.next()) |innerNumber| {
            const innerUInt = try std.fmt.parseUnsigned(u32, innerNumber, 10);
            if (outerUInt + innerUInt == 2020) {
                std.debug.print("Number 1: {d}\n", .{outerUInt});
                std.debug.print("Number 2: {d}\n", .{innerUInt});
                return;
            }
        }
    }
}
