const std = @import("std");

fn Ansi() type {
    return struct {
        allocator: std.mem.Allocator,

        fn init(allocator: std.mem.Allocator) !Ansi() {
            return .{ .allocator = allocator };
        }

        fn printColor(this: @This(), T: anytype, colorCode: []const u8) ![]const u8 {
            switch (@typeInfo(@TypeOf(T))) {
                .Bool => return try std.fmt.allocPrint(this.allocator, "{s}{}{s}", .{ colorCode, T, "\x1b[0m" }),
                .Pointer => return try std.fmt.allocPrint(this.allocator, "{s}{s}{s}", .{ colorCode, T, "\x1b[0m" }),
                .ComptimeInt, .Int => return try std.fmt.allocPrint(this.allocator, "{s}{}{s}", .{ colorCode, T, "\x1b[0m" }),
                .ComptimeFloat => return try std.fmt.allocPrint(this.allocator, "{s}{d:.}{s}", .{ colorCode, T, "\x1b[0m" }),
                else => {},
            }
        }

        fn default(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[39m");
        }

        fn black(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[30m");
        }

        fn red(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[31m");
        }

        fn green(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[32m");
        }

        fn yellow(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[33m");
        }

        fn blue(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[34m");
        }

        fn magenta(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[35m");
        }

        fn cyan(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[36m");
        }

        fn white(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[37m");
        }

        fn bgDefult(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[0m");
        }

        fn bgBlack(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[40m");
        }

        fn bgRed(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[41m");
        }

        fn bgGreen(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[42m");
        }

        fn bgYellow(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[43m");
        }

        fn bgBlue(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[44m");
        }

        fn bgMagenta(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[45m");
        }

        fn bgCyan(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[46m");
        }

        fn bgWhite(this: @This(), T: anytype) ![]const u8 {
            return try this.printColor(T, "\x1b[47m");
        }
    };
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const ansi = try Ansi().init(allocator);

    var i: u8 = 0;
    while (i < 8) : (i += 1) {
        const textColor = switch (i) {
            0 => try ansi.black("hello world"),
            1 => try ansi.red("hello world"),
            2 => try ansi.green("hello world"),
            3 => try ansi.yellow("hello world"),
            4 => try ansi.blue("hello world"),
            5 => try ansi.magenta("hello world"),
            6 => try ansi.cyan("hello world"),
            else => try ansi.white("hello world"),
        };
        defer allocator.free(textColor);

        var j: u8 = 0;
        while (j < 8) : (j += 1) {
            const bgColor = switch (j) {
                0 => try ansi.bgBlack(textColor),
                1 => try ansi.bgRed(textColor),
                2 => try ansi.bgGreen(textColor),
                3 => try ansi.bgYellow(textColor),
                4 => try ansi.bgBlue(textColor),
                5 => try ansi.bgMagenta(textColor),
                6 => try ansi.bgCyan(textColor),
                else => try ansi.bgWhite(textColor),
            };
            defer allocator.free(bgColor);

            std.debug.print("{s}\n", .{bgColor});
        }
    }
}
