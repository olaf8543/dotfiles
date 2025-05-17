#!/usr/bin/env python3
import sys
import rich
from rich.console import Console
from rich.table import Table
from rich.text import Text

console = Console()

include_permissions = '--permissions' in sys.argv

table = Table(
    show_header=True,
    header_style="bold #fa694e",
    box=rich.box.ROUNDED,
)
table.add_column(header=Text("Name", justify="center"))
table.add_column(header=Text("Type", justify="center"))
table.add_column(header=Text("Size", justify="center"))
if include_permissions:
    table.add_column(header=Text("Permissions", justify="center"))
table.add_column(header=Text("Date Modified", justify="center"))

lines = sys.stdin.read().splitlines()

for row in lines[1:]:
    parts = row.strip().split(maxsplit=5)

    permissions = parts[0]
    size = parts[1]
    date_modified = f"{parts[2]} {parts[3]}"
    name = parts[5] if len(parts) > 5 else parts[4]

    file_type = "dir" if permissions.startswith("d") else "file"

    if file_type == "dir":
        styled_name = Text(name, style="bold #fa694e")
    else:
        styled_name = Text(name, style="bold #fdf087")

    row_data = [styled_name, file_type, size]
    if include_permissions:
        row_data.append(permissions)
    row_data.append(date_modified)

    table.add_row(*row_data)

console.print(table)
