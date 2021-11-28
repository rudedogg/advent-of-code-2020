const std = @import("std");

const input = @embedFile("input.txt");

const Slope = struct {
    x: u8,
    y: u8,
};

pub fn main() !void {
    std.debug.print("Hello day {d}\n", .{3});
    // try part1();
    try part2();
}

fn part1() !void {
    const collisions = try calculateCollisions(Slope{ .x = 3, .y = 1 });
    std.debug.print("Collisions: {d}\n", .{collisions});
}

fn part2() !void {
    const slope1 = Slope{ .x = 1, .y = 1 };
    const collisions1 = try calculateCollisions(slope1);

    const slope2 = Slope{ .x = 3, .y = 1 };
    const collisions2 = try calculateCollisions(slope2);

    const slope3 = Slope{ .x = 5, .y = 1 };
    const collisions3 = try calculateCollisions(slope3);

    const slope4 = Slope{ .x = 7, .y = 1 };
    const collisions4 = try calculateCollisions(slope4);

    const slope5 = Slope{ .x = 1, .y = 2 };
    const collisions5 = try calculateCollisions(slope5);

    const totalCollisions = collisions1 * collisions2 * collisions3 * collisions4 * collisions5;

    std.debug.print("Part 2 Answer: {d}\n", .{totalCollisions});
}

fn calculateCollisions(slope: Slope) !u32 {
    var collisions: u32 = 0;
    var lineIterator = std.mem.split(u8, input, "\n");
    var lineLength = std.mem.indexOf(u8, input, "\n").?;
    var lineNumber: u64 = 1;
    var currentX: u16 = slope.x;
    var currentY: u16 = slope.y;

    // Skip the first line, since it's the starting point
    if (slope.y != 0) {
        _ = lineIterator.next();
    }

    while (lineIterator.next()) |line| {
        const wrappedX: u64 = currentX % lineLength;
        // std.debug.print("wrappedX: {d}\n", .{wrappedX});

        if (lineNumber % slope.y == 0) {
            // Need to check this line, since our slope will hit it.
            // std.debug.print("Checking line: {d}\n", .{lineNumber});
            // std.debug.print("Line: {s}\n", .{line});
            // std.debug.print("Checking character: {u}\n", .{line[wrappedX]});
            // std.debug.print("------------------\n", .{});
            if (line[wrappedX] == '#') {
                collisions += 1;
            }
            // Move the sleigh by the slope specified
            currentX += slope.x;
            currentY += slope.y;
        }

        lineNumber += 1;
    }
    std.debug.print("Line Length: {d}\n", .{lineLength});

    std.debug.print("Slope: x={d}, y={d} | Collisions: {d}\n", .{ slope.x, slope.y, collisions });
    return collisions;
}
