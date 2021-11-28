const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    var validCount: u16 = 0;
    var lineIterator = std.mem.split(u8, input, "\n");
    while (lineIterator.next()) |line| {
        std.debug.print("Line: {s}\n", .{line});
        const firstSpace = std.mem.indexOf(u8, line, " ");
        const firstDash = std.mem.indexOf(u8, line, "-");
        const colon = std.mem.indexOf(u8, line, ":");

        const minCharacterCount = line[0..firstDash.?];
        const maxCharacterCount = line[(firstDash.? + 1)..firstSpace.?];
        const minCharacterCountInt = try std.fmt.parseUnsigned(u8, minCharacterCount, 10);
        const maxCharacterCountInt = try std.fmt.parseUnsigned(u8, maxCharacterCount, 10);

        const character = line[(firstSpace.? + 1)..colon.?];
        const password = line[(colon.? + 2)..];

        const characterCount = std.mem.count(u8, password, character);
        if ((characterCount >= minCharacterCountInt) and (characterCount <= maxCharacterCountInt)) {
            validCount = validCount + 1;
        }

        std.debug.print("firstSpace: {d}\n", .{firstSpace});
        std.debug.print("minCharacterCount: {s}\n", .{minCharacterCount});
        std.debug.print("maxCharacterCount: {s}\n", .{maxCharacterCount});
        std.debug.print("character: {s}\n", .{character});
        std.debug.print("password: {s}\n", .{password});
        std.debug.print("isValid: {b}\n", .{(characterCount >= minCharacterCountInt) and (characterCount <= maxCharacterCountInt)});
        std.debug.print("----------------------------------\n", .{});
    }
    std.debug.print("validCount: {d}\n", .{validCount});
}
