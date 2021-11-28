const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    try part1();
    try part2();
}

pub fn part1() !void {
    var validCount: u16 = 0;
    var lineIterator = std.mem.split(u8, input, "\n");
    while (lineIterator.next()) |line| {
        // std.debug.print("Line: {s}\n", .{line});
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

        // std.debug.print("firstSpace: {d}\n", .{firstSpace});
        // std.debug.print("minCharacterCount: {s}\n", .{minCharacterCount});
        // std.debug.print("maxCharacterCount: {s}\n", .{maxCharacterCount});
        // std.debug.print("character: {s}\n", .{character});
        // std.debug.print("password: {s}\n", .{password});
        // std.debug.print("isValid: {b}\n", .{(characterCount >= minCharacterCountInt) and (characterCount <= maxCharacterCountInt)});
        // std.debug.print("----------------------------------\n", .{});
    }
    std.debug.print("part 1 - validCount: {d}\n", .{validCount});
}

pub fn part2() !void {
    var validCount: u16 = 0;
    var lineIterator = std.mem.split(u8, input, "\n");
    while (lineIterator.next()) |line| {
        // std.debug.print("Line: {s}\n", .{line});
        const firstSpace = std.mem.indexOf(u8, line, " ");
        const firstDash = std.mem.indexOf(u8, line, "-");
        const colon = std.mem.indexOf(u8, line, ":");

        const firstCharacterSlotIndex = line[0..firstDash.?];
        const lastChacterSlotIndex = line[(firstDash.? + 1)..firstSpace.?];
        const firstCharacterSlotIndexInt = try std.fmt.parseUnsigned(u8, firstCharacterSlotIndex, 10);
        const lastCharacterSlotIndexInt = try std.fmt.parseUnsigned(u8, lastChacterSlotIndex, 10);

        const character = line[(firstSpace.? + 1)..colon.?];
        const password = line[(colon.? + 2)..];

        const inFirstCharacterSlot = password[firstCharacterSlotIndexInt - 1] == character[0];
        const inLastCharacterSlot = password[lastCharacterSlotIndexInt - 1] == character[0];

        var characterInstances: u8 = 0;
        if (inFirstCharacterSlot) {
            characterInstances += 1;
        }
        if (inLastCharacterSlot) {
            characterInstances += 1;
        }
        if (characterInstances == 1) {
            validCount = validCount + 1;
        }

        // std.debug.print("firstSpace: {d}\n", .{firstSpace});
        // std.debug.print("firstCharcter: {u}\n", .{password[firstCharacterSlotIndexInt - 1]});
        // std.debug.print("firstCharacterSlotIndex: {s}\n", .{firstCharacterSlotIndex});
        // std.debug.print("inFirstCharcterSlot: {b}\n", .{inFirstCharacterSlot});
        // std.debug.print("lastCharcter: {u}\n", .{password[lastCharacterSlotIndexInt - 1]});
        // std.debug.print("lastChacterSlotIndex: {s}\n", .{lastChacterSlotIndex});
        // std.debug.print("inLastCharcterSlot: {b}\n", .{inLastCharacterSlot});
        // std.debug.print("character: {s}\n", .{character});
        // std.debug.print("password: {s}\n", .{password});
        // std.debug.print("isValid: {b}\n", .{(characterInstances == 1)});
        // std.debug.print("----------------------------------\n", .{});
    }
    std.debug.print("part 2 - validCount: {d}\n", .{validCount});
}
