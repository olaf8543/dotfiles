#!/usr/bin/env python3
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib
import subprocess
import os

class PowerMenu:
    def __init__(self):
        self.builder = Gtk.Builder()
        self.builder.add_from_file(os.path.expanduser("~/.config/waybar/scripts/power_menu.xml"))
        self.builder.connect_signals(self)

        self.menu = self.builder.get_object("menu")
        self.menu.show_all()

    def on_shutdown_activate(self, widget):
        subprocess.run(["~/.config/waybar/scripts/power.sh", "shutdown"])

    def on_reboot_activate(self, widget):
        subprocess.run(["~/.config/waybar/scripts/power.sh", "reboot"])

    def run(self):
        Gtk.main()

if __name__ == "__main__":
    PowerMenu().run()
