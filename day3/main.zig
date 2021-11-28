const std = @import("std");

const input = @embedFile("input.txt");

const Slope = struct {
    x: u8,
    y: u8,
};

pub fn main() !void {
    std.debug.print("Hello day {d}\n", .{3});
    try part1();
    // try part2();
}

fn part1() !void {
    const collisions = try calculateCollisions(Slope{ .x = 3, .y = 1 });
    std.debug.print("Collisions: {d}\n", .{collisions});
}

// fn part2() !void {
//     const collisions = try calculateCollisions(Slope{ .x = 3, .y = 1 });
//     std.debug.print("Collisions: {d}\n", .{collisions});
// }

fn calculateCollisions(slope: Slope) !u32 {
    var collisions: u32 = 0;
    var lineIterator = std.mem.split(u8, input, "\n");
    var lineLength: u64 = 0;
    var lineNumber: u64 = 0;
    var currentX: u16 = (slope.x);
    var currentY: u16 = slope.y;

    // Skip the first line, since it's the starting point
    if (slope.y == 1 and lineNumber == 0) {
        _ = lineIterator.next();
    }

    while (lineIterator.next()) |line| {
        // Calculate the line length if we haven't already
        if (lineLength == 0) {
            lineLength = std.mem.len(line);
        }

        const wrappedX: u64 = currentX % lineLength;
        std.debug.print("wrappedX: {d}\n", .{wrappedX});

        if (lineNumber % slope.y == 0) {
            // Need to check this line, since our slope will hit it.
            std.debug.print("Checking line: {d}\n", .{lineNumber});
            std.debug.print("Line: {s}\n", .{line});
            std.debug.print("Checking character: {u}\n", .{line[wrappedX]});
            std.debug.print("------------------\n", .{});
            if (line[wrappedX] == "#"[0]) {
                collisions += 1;
            }
        }
        lineNumber += 1;

        // Move the sleigh by the slope specified
        currentX += slope.x;
        currentY += slope.y;

        // const firstSpace = std.mem.indexOf(u8, line, " ");
        // const firstSpace = std.mem.indexOf(u8, line, " ");
        // const firstDash = std.mem.indexOf(u8, line, "-");
        // const colon = std.mem.indexOf(u8, line, ":");

        // const firstCharacterSlotIndex = line[0..firstDash.?];
        // const lastChacterSlotIndex = line[(firstDash.? + 1)..firstSpace.?];
        // const firstCharacterSlotIndexInt = try std.fmt.parseUnsigned(u8, firstCharacterSlotIndex, 10);
        // const lastCharacterSlotIndexInt = try std.fmt.parseUnsigned(u8, lastChacterSlotIndex, 10);
    }
    std.debug.print("Line Length: {d}\n", .{lineLength});

    return collisions;
}
