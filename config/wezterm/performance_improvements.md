# Performance Improvements for wezterm-sessions

The `wezterm-sessions` plugin is a powerful tool for managing WezTerm workspaces, but it can be slow to load sessions. This document outlines potential performance bottlenecks and suggests improvements to make workspace switching and loading faster.

## Analysis of Performance Bottlenecks

Based on the plugin's source code, the following areas are likely contributors to slow performance:

1. **Synchronous File I/O:** The plugin uses synchronous functions like `io.open`, `file:read`, and `os.remove` to read and write session files. These operations block the main thread, making the UI unresponsive, especially when dealing with large session files or slow storage.

2. **Process Inspection:** The `retrieve_pane_data` function inspects the foreground process of each pane to get its command line. It does this by reading `/proc/<pid>/cmdline`. This is a relatively slow operation, and doing it for every pane in the session can add up.

3. **`wezterm.sleep_ms(2000)`:** In `plugin/init.lua`, there's a hardcoded 2-second delay after switching workspaces. This is likely to wait for the workspace to settle, but it's a significant and inflexible delay.

4. **Inefficient Pane Restoration:** The pane restoration algorithm in `plugin/tab.lua` seems complex and potentially inefficient. It uses `wezterm.sleep_ms(200)` multiple times, which can slow down the process. The logic for finding horizontal and vertical splits involves iterating over all panes, which could be slow for complex layouts.

## Proposed Improvements

Here are some ways to improve the performance of `wezterm-sessions`:

### 1. Asynchronous Operations

- **Use `wezterm.background` for file I/O:** Instead of using synchronous file I/O, move file operations to a background thread using `wezterm.background`. This will prevent blocking the main thread and keep the UI responsive.

    *Example:*

    ```lua
    wezterm.background(function()
        local file = io.open(file_path, "w")
        if file then
            file:write(wezterm.json_encode(data))
            file:close()
            wezterm.emit('session-save-success')
        else
            wezterm.emit('session-save-error')
        end
    end)
    ```

- **Asynchronous Process Inspection:** Similarly, the process inspection can be done in the background.

### 2. Caching

- **Cache Session Data:** Instead of reading the session file from disk every time, cache the session data in memory. This would make switching to an already loaded session much faster. The cache can be invalidated when the session is saved.

### 3. Optimizing Pane Restoration

- **Remove `wezterm.sleep_ms`:** The `wezterm.sleep_ms` calls in the pane restoration logic should be removed or replaced with event-driven mechanisms. For example, instead of waiting for a fixed time, the code could wait for a specific event that indicates the pane is ready.

- **More Efficient Layout Algorithm:** The algorithm for restoring the pane layout could be optimized. Instead of iterating over all panes to find splits, it might be possible to use a more direct approach based on the pane dimensions and positions.

### 4. Lazy Loading

- **Lazy Load Tabs:** Instead of restoring all tabs and panes at once, consider a lazy loading approach. Only restore the visible tab and its panes initially. Other tabs can be restored in the background or when they are activated.

### 5. Reducing Process Inspection Overhead

- **Conditional Process Inspection:** The process inspection is only necessary for restoring the running processes. If the user doesn't need this feature, there should be an option to disable it. This would significantly speed up session loading.

- **More Efficient Process Information Retrieval:** Explore more efficient ways to get the process command line. For example, it might be possible to get this information directly from WezTerm's API without reading from `/proc`.

By implementing these improvements, `wezterm-sessions` can become a much faster and more responsive tool for managing WezTerm workspaces.
