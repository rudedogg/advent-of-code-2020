const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    // https://github.com/ziglang/zig/blob/a2c546fea30de2caf1efb454d327e70270c07338/lib/std/mem.zig#L1732
    var iter = std.mem.split(u8, input, "\n");
    std.debug.print("iter: {s}\n", .{@TypeOf(iter)});
    std.debug.print("it.next: {s}\n", .{@TypeOf(iter.next().?)});

    // std.debug.print("it.next: {s}\n", .{@sizeOf(iter.next().?)});
    // std.debug.print("it.next: {u}\n", .{iter.next().?});
    // const asInt = @as(u16, iter.next().?);
    // const asInt = @intCast(u16, iter.next().?);
    // const int = iter.next().?;
    // const asInt = @bitCast(u32, iter.next().?);
    // std.debug.print("converted: {d}\n", .{asInt});

    while (iter.next()) |number| {
        const num1 = try std.fmt.parseUnsigned(u32, number, 10);
        // std.debug.print("num1: {d}\n", .{num1});
        var iter2 = std.mem.split(u8, input, "\n");
        while (iter2.next()) |number2| {
            // std.debug.print("number2: {d}\n", .{number2});
            const num2 = try std.fmt.parseUnsigned(u32, number2, 10);
            if (num1 + num2 == 2020) {
                std.debug.print("found it!: {d}\n", .{num1});
                std.debug.print("found it!: {d}\n", .{num2});
                return;
            }
        }
    }

    // std.debug.print("converted: {d}\n", .{x});
    // std.debug.print("type: {s}\n", .{@TypeOf(x)});
    // std.debug.print("num * 2: {d}\n", .{x * 2});

    // const asInt = @bitCast(u32, iter.next().?);
    // const asInt = @bitCast(u16, iter.next().?);
    // std.debug.print("converted: {u}\n", .{asInt});
    // std.debug.print("it.next: {u32}\n", .{});
    // std.debug.print("type: {s}\n", .{@TypeOf(iter.next().?)});

    // for (input) |number| {
    //     std.debug.print("d: {d}\n", .{number});
    //     std.debug.print("u: {u}\n", .{number});
    // }
}
