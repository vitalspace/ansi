# Ansi Zig

## Usage

```typescript
pub fn main() {
    const allocator = std.mem.page_allocator;
    const ansi = try Ansi().init(allocator);
    
    const message = try ansi.bgBlack(try ansi.cyan("Hello world!!"));
    defer allocator.free(message);

    std.debug.print("{s}\n", .{message});
}
```


![image](https://github.com/vitalspace/ansi/assets/29004070/d25048b5-448d-4208-9b52-40c6d2ab19b6)
