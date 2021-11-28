const std = @import("std");

const input = @embedFile("input.txt");

const Passport = struct {
    // byr: bool = true,
    byr: []const u8 = "",
    iyr: bool = false,
    eyr: bool = false,
    hgt: bool = false,
    hcl: bool = false,
    ecl: bool = false,
    pid: bool = false,
    cid: bool = false,

    fn isValid(self: *Passport) bool {
        std.debug.print("Hi: {s}", .{self});
        return true;
        // return self.byr and self.iyr and self.eyr and self.hgt and self.hcl and self.ecl and self.pid;
    }
    // fn byrValid() bool {
    //     return byr.
    // }
};

pub fn main() !void {
    std.debug.print("Hello day {d}, part 2\n", .{4});
    try part2();
}

fn part2() !void {
    const fieldNames = [_][]const u8{ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid" };

    var validPassportCount: u16 = 0;

    var passportIterator = std.mem.split(u8, input, "\n\n");
    while (passportIterator.next()) |passport| {
        var currentPassport = Passport{};
        std.debug.print("--------------------\n", .{});
        std.debug.print("Passport: \n", .{});
        var lineIterator = std.mem.split(u8, passport, "\n");

        while (lineIterator.next()) |line| {
            for (fieldNames) |fieldName| {
                const fieldContents = parseField(fieldName, line);
                // @field(currentPassport, "byr") = "Aa";
                std.debug.print("{s}\n", .{fieldContents});
            }
            std.debug.print("{s}\n", .{line});
            // currentPassport.byr = currentPassport.byr or std.mem.indexOf(u8, line, "byr") != null;
            // currentPassport.byr = currentPassport.byr or std.mem.containsAtLeast(u8, line, 1, "byr");

            currentPassport.iyr = currentPassport.iyr or std.mem.indexOf(u8, line, "iyr") != null;
            currentPassport.eyr = currentPassport.eyr or std.mem.indexOf(u8, line, "eyr") != null;
            currentPassport.hgt = currentPassport.hgt or std.mem.indexOf(u8, line, "hgt") != null;
            currentPassport.hcl = currentPassport.hcl or std.mem.indexOf(u8, line, "hcl") != null;
            currentPassport.ecl = currentPassport.ecl or std.mem.indexOf(u8, line, "ecl") != null;
            currentPassport.pid = currentPassport.pid or std.mem.indexOf(u8, line, "pid") != null;
            currentPassport.cid = currentPassport.cid or std.mem.indexOf(u8, line, "cid") != null;
        }
        if (currentPassport.isValid()) {
            validPassportCount += 1;
        }
        std.debug.print("isValid: {s}\n", .{currentPassport});
        std.debug.print("isValid: {b}\n", .{currentPassport.isValid()});
        std.debug.print("--------------------\n\n", .{});
    }
    std.debug.print("Valid Passports: {d}\n\n", .{validPassportCount});
}

fn parseField(name: []const u8, haystack: []const u8) ?[]const u8 {
    var fieldValue: ?[]const u8 = null;

    var fieldIterator = std.mem.split(u8, haystack, " ");
    while (fieldIterator.next()) |field| {
        const fieldDelimeterIndex = std.mem.indexOf(u8, haystack, ":").? + 1;
        // TODO: Why doesn't this work? // if (field[0..fieldDelimeterIndex] == name) {
        if (std.mem.eql(u8, field[0..fieldDelimeterIndex], name)) {
            fieldValue = field[fieldDelimeterIndex..];
        }
        std.debug.print("Field Value: {s}\n", .{fieldValue});
    }

    const fieldStartIndex = std.mem.indexOf(u8, haystack, name);
    const fieldEndIndex = std.mem.lastIndexOf(u8, haystack, " ") orelse std.mem.indexOf(u8, haystack, "\n");
    std.debug.print("Parsing line: {s}\n", .{haystack});
    std.debug.print("Parsing fieldName: {s}\n", .{name});
    std.debug.print("fieldStartIndex: {d}\n", .{fieldStartIndex});
    std.debug.print("fieldEndIndex: {d}\n", .{fieldEndIndex});
    if (fieldStartIndex == null or fieldEndIndex == null) {
        return null;
    }
    // return haystack[fieldStartIndex.?..fieldEndIndex.?];
    return fieldValue;
    // var lineIterator = std.mem.split(u8, haystack, "\n");

    // while (lineIterator.next()) |line| {
    //     return name + line;
    // }
}
