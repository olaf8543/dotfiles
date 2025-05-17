
go to 

`~/.local/share/applications`
and
`vim <appname>.desktop`

add the following, adjusting as necessary

```
[Desktop Entry]
Name=<Application Name>
Exec=/home/<username>/Applications/<AppImage_file>
Icon=/path/to/icon.png
Type=Application
Categories=<Category>;
```

now run 
`update-desktop-database ~/.local/share/applications`
to save your changes.