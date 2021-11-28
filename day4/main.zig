const std = @import("std");

const input = @embedFile("input.txt");

const Passport = struct {
    byr: bool = false,
    iyr: bool = false,
    eyr: bool = false,
    hgt: bool = false,
    hcl: bool = false,
    ecl: bool = false,
    pid: bool = false,
    cid: bool = false,

    fn isValid(self: *Passport) bool {
        return self.byr and self.iyr and self.eyr and self.hgt and self.hcl and self.ecl and self.pid;
    }
};

pub fn main() !void {
    std.debug.print("Hello day {d}\n", .{4});
    // var req_fields = ["byr"]
    try part1();
    // try part2();
}

fn part1() !void {
    var validPassportCount: u16 = 0;

    var passportIterator = std.mem.split(u8, input, "\n\n");
    while (passportIterator.next()) |passport| {
        var currentPassport = Passport{};
        std.debug.print("--------------------\n", .{});
        std.debug.print("Passport: \n", .{});
        var lineIterator = std.mem.split(u8, passport, "\n");
        while (lineIterator.next()) |line| {
            std.debug.print("{s}\n", .{line});
            // currentPassport.byr = currentPassport.byr or std.mem.indexOf(u8, line, "byr") != null;
            currentPassport.byr = currentPassport.byr or std.mem.containsAtLeast(u8, line, 1, "byr");
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

fn part2() !void {}
