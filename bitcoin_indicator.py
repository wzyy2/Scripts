#!/usr/bin/env python3
from gi.repository import Gtk, AppIndicator3, GLib
import signal
import gi
import requests

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')


class Indicator():
    def __init__(self):
        self.app = 'bitcoin'
        iconpath = "/usr/share/unity/icons/panel-shadow.png"
        self.indicator = AppIndicator3.Indicator.new(
            self.app, "", AppIndicator3.IndicatorCategory.OTHER)
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(Gtk.Menu())

    def main(self):
        GLib.timeout_add(1000, self.update_value)
        Gtk.main()

    def update_value(self):
        r = requests.get(
            'https://www.okex.me/api/spot/v3/instruments/BTC-USDT/ticker')
        self.indicator.set_label(r.json()["last"], self.app)

        return True

    def stop(self, source):
        Gtk.main_quit()


indicator = Indicator()
signal.signal(signal.SIGINT, signal.SIG_DFL)
indicator.main()
