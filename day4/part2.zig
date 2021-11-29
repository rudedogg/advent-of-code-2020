const std = @import("std");

const input = @embedFile("input.txt");

const Passport = struct {
    byr: []const u8 = "",
    iyr: []const u8 = "",
    eyr: []const u8 = "",
    hgt: []const u8 = "",
    hcl: []const u8 = "",
    ecl: []const u8 = "",
    pid: []const u8 = "",
    cid: []const u8 = "",

    fn isValid(self: *Passport) bool {
        return byrValid(self) and iyrValid(self) and eyrValid(self) and hgtValid(self) and hclValid(self) and eclValid(self) and pidValid(self);
    }

    fn byrValid(self: *Passport) bool {
        const byr: u16 = std.fmt.parseUnsigned(u16, self.byr, 10) catch {
            return false;
        };
        return (byr >= 1920) and (byr <= 2002);
    }
    fn iyrValid(self: *Passport) bool {
        std.debug.print("HI{s}\n\n\n\n", .{self});
        // return true;
        const iyr: u16 = std.fmt.parseUnsigned(u16, self.iyr, 10) catch {
            return false;
        };
        return (iyr >= 2010) and (iyr <= 2020);
    }
    fn eyrValid(self: *Passport) bool {
        const eyr: u16 = std.fmt.parseUnsigned(u16, self.eyr, 10) catch {
            return false;
        };
        return (eyr >= 2020) and (eyr <= 2030);
    }

    fn hgtValid(self: *Passport) bool {
        var height: ?u16 = null;
        var isCM = (std.mem.indexOf(u8, self.hgt, "cm") != null);
        std.debug.print("isCM: {b}\n", .{isCM});
        std.debug.print("HI\n\n\n\n", .{});

        if (std.mem.indexOf(u8, self.hgt, "cm")) |cmIndex| {
            height = std.fmt.parseUnsigned(u16, self.hgt[0..cmIndex], 10) catch {
                return false;
            };
        } else if (std.mem.indexOf(u8, self.hgt, "in")) |inIndex| {
            height = std.fmt.parseUnsigned(u16, self.hgt[0..inIndex], 10) catch {
                return false;
            };
        } else {
            return false; // no cm or in
        }

        if (height) |unwrappedHeight| {
            if (isCM) {
                return (unwrappedHeight >= 150 and unwrappedHeight <= 193);
            } else {
                return (unwrappedHeight >= 59 and unwrappedHeight <= 76);
            }
        } else {
            return false;
        }
    }

    fn hclValid(self: *Passport) bool {
        if (std.mem.len(self.hcl) != 7) {
            return false;
        }
        if (self.hcl[0] == '#') {
            for (self.hcl[1..7]) |char| {
                var local = [1]u8{char};
                if (std.mem.containsAtLeast(u8, "abcdef0123456789", 1, &local) == false) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    fn eclValid(self: *Passport) bool {
        return std.mem.eql(u8, self.ecl, "amb") or std.mem.eql(u8, self.ecl, "blu") or std.mem.eql(u8, self.ecl, "gry") or std.mem.eql(u8, self.ecl, "grn") or std.mem.eql(u8, self.ecl, "hzl") or std.mem.eql(u8, self.ecl, "oth");
    }

    fn pidValid(self: *Passport) bool {
        return std.mem.len(self.pid) == 9;
    }
};

pub fn main() !void {
    std.debug.print("Hello day {d}, part 2\n", .{4});
    try part2();
}

fn part2() !void {
    // const fieldNames = [_][]const u8{ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid" };

    var validPassportCount: u16 = 0;

    var passportIterator = std.mem.split(u8, input, "\n\n");
    while (passportIterator.next()) |passport| {
        var currentPassport = Passport{};
        std.debug.print("--------------------\n", .{});
        std.debug.print("Passport: \n", .{});
        var lineIterator = std.mem.split(u8, passport, "\n");

        while (lineIterator.next()) |line| {
            currentPassport.byr = parseField("byr", line) orelse currentPassport.byr;
            currentPassport.iyr = parseField("iyr", line) orelse currentPassport.iyr;
            currentPassport.eyr = parseField("eyr", line) orelse currentPassport.eyr;
            currentPassport.hgt = parseField("hgt", line) orelse currentPassport.hgt;
            currentPassport.hcl = parseField("hcl", line) orelse currentPassport.hcl;
            currentPassport.ecl = parseField("ecl", line) orelse currentPassport.ecl;
            currentPassport.pid = parseField("pid", line) orelse currentPassport.pid;
            currentPassport.cid = parseField("cid", line) orelse currentPassport.cid;
        }
        if (currentPassport.isValid()) {
            validPassportCount += 1;
        }
        std.debug.print("isValid: {b}\n", .{currentPassport.isValid()});
    }
    std.debug.print("--------------------\n\n", .{});
    std.debug.print("Valid Passports: {d}\n\n", .{validPassportCount});
}

fn parseField(name: []const u8, haystack: []const u8) ?[]const u8 {
    var fieldValue: ?[]const u8 = null;

    var fieldIterator = std.mem.split(u8, haystack, " ");
    while (fieldIterator.next()) |field| {
        const fieldDelimeterIndex = std.mem.indexOf(u8, haystack, ":").? + 1;
        // TODO: Why doesn't this work? // if (field[0..fieldDelimeterIndex] == name) {
        if (std.mem.eql(u8, field[0 .. fieldDelimeterIndex - 1], name)) {
            fieldValue = field[fieldDelimeterIndex..];
            std.debug.print("{s} = {s}\n", .{ name, fieldValue });
        }
    }

    return fieldValue;
}
