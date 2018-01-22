Content-Type: multipart/mixed; boundary="===============0271645623068477750=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Huawei MS2131
Date: Mon, 22 Jan 2018 16:07:59 +0100
Message-ID: <195035f5-9f2c-e97f-0d14-6442ef1e79a9@monom.org>
In-Reply-To: <39634fd7-75ad-16c1-0df4-d15a1e42bcd9@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0271645623068477750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

So after some more playing around, oFono 1.21 works out
of the box. At my workplace there must be some
interference which made all modems go crazy. After
moving away all works fine. The only thing missing
was the APN config, which was easily fixed.

So many thanks for all the help.

During the testing I triggered two crashes(by removing
the device). =


Thanks,
Daniel





ofonod[25541]: plugins/udevng.c:remove_device() /sys/devices/pci0000:00/000=
0:00:14.0/usb1/1-1/1-1:1.0/ttyUSB0/tty/ttyUSB0
ofonod[25541]: plugins/udevng.c:destroy_modem() /sys/devices/pci0000:00/000=
0:00:14.0/usb1/1-1
ofonod[25541]: src/modem.c:ofono_modem_remove() 0xc8f800
ofonod[25541]: src/modem.c:modem_unregister() 0xc8f800
ofonod[25541]: src/modem.c:modem_change_state() old state: 3, new state: 0
ofonod[25541]: src/modem.c:flush_atoms() =

ofonod[25541]: src/message-waiting.c:mw_remove() atom: 0xc8d180
ofonod[25541]: src/call-barring.c:call_barring_remove() atom: 0xcc3f80
ofonod[25541]: src/call-settings.c:call_settings_remove() atom: 0xcc4660
ofonod[25541]: src/call-forwarding.c:call_forwarding_remove() atom: 0xcc4590
ofonod[25541]: src/ussd.c:ussd_remove() atom: 0xc97260
ofonod[25541]: src/network.c:__ofono_netreg_remove_status_watch() 0xc9f620
ofonod[25541]: src/cbs.c:cbs_remove() atom: 0xc71930
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid=
 1
ofonod[25541]: src/sim.c:ofono_sim_remove_spn_watch() 0xcc0d50
ofonod[25541]: src/network.c:netreg_remove() atom: 0xcb1c60
ofonod[25541]: Example Network Time Remove for modem: 0xc8f800
ofonod[25541]: Example History Remove for modem: 0xc8f800
ofonod[25541]: src/gprs.c:gprs_context_unregister() 0xcb1cd0, 0xc96120
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =

ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


(ofonod:25541): GLib-CRITICAL **: g_queue_pop_head: assertion 'queue !=3D N=
ULL' failed

(ofonod:25541): GLib-CRITICAL **: g_queue_free: assertion 'queue !=3D NULL'=
 failed

(ofonod:25541): GLib-CRITICAL **: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed
ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


(ofonod:25541): GLib-CRITICAL **: g_queue_pop_head: assertion 'queue !=3D N=
ULL' failed

(ofonod:25541): GLib-CRITICAL **: g_queue_free: assertion 'queue !=3D NULL'=
 failed

(ofonod:25541): GLib-CRITICAL **: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed
ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


(ofonod:25541): GLib-CRITICAL **: g_queue_pop_head: assertion 'queue !=3D N=
ULL' failed

(ofonod:25541): GLib-CRITICAL **: g_queue_free: assertion 'queue !=3D NULL'=
 failed

(ofonod:25541): GLib-CRITICAL **: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed
ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


(ofonod:25541): GLib-CRITICAL **: g_queue_pop_head: assertion 'queue !=3D N=
ULL' failed

(ofonod:25541): GLib-CRITICAL **: g_queue_free: assertion 'queue !=3D NULL'=
 failed

(ofonod:25541): GLib-CRITICAL **: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed
ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =


(ofonod:25541): GLib-CRITICAL **: g_queue_pop_head: assertion 'queue !=3D N=
ULL' failed

(ofonod:25541): GLib-CRITICAL **: g_queue_free: assertion 'queue !=3D NULL'=
 failed

(ofonod:25541): GLib-CRITICAL **: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed
ofonod[25541]: Modem channel disconnected
ofonod[25541]: src/gprs.c:gprs_context_remove() atom: 0xcb1d10
ofonod[25541]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =

[...]






ofonod[27950]: IP: 100.91.239.46
ofonod[27950]: DNS: 139.7.30.126, 139.7.30.125
ofonod[27950]: src/gprs.c:pri_activate_callback() 0x15feb20
ofonod[27950]: plugins/udevng.c:add_serial_device() Device is missing requi=
red OFONO_DRIVER property
ofonod[27950]: plugins/udevng.c:check_modem_list() =

ofonod[27950]: src/modem.c:modem_change_state() old state: 3, new state: 0
ofonod[27950]: src/modem.c:flush_atoms() =

ofonod[27950]: src/message-waiting.c:mw_remove() atom: 0x160d790
ofonod[27950]: src/call-barring.c:call_barring_remove() atom: 0x15f8790
ofonod[27950]: src/call-settings.c:call_settings_remove() atom: 0x15f8640
ofonod[27950]: src/call-forwarding.c:call_forwarding_remove() atom: 0x15f85=
00
ofonod[27950]: src/ussd.c:ussd_remove() atom: 0x15f8360
ofonod[27950]: src/network.c:__ofono_netreg_remove_status_watch() 0x15f8150
ofonod[27950]: src/cbs.c:cbs_remove() atom: 0x15fa7f0
ofonod[27950]: drivers/atmodem/gprs-context.c:at_gprs_detach_shutdown() cid=
 1
ofonod[27950]: src/sim.c:ofono_sim_remove_spn_watch() 0x15f0c50
ofonod[27950]: src/network.c:netreg_remove() atom: 0x161d170
ofonod[27950]: Example Network Time Remove for modem: 0x15ece10
ofonod[27950]: Example History Remove for modem: 0x15ece10
ofonod[27950]: src/gprs.c:gprs_context_unregister() 0x15e9b00, 0x15f1350
ofonod[27950]: src/gprs.c:gprs_context_remove() atom: 0x15e9b40
ofonod[27950]: drivers/atmodem/gprs-context.c:at_gprs_context_remove() =

ofonod[27950]: src/gprs.c:gprs_unregister() 0x15f1350
ofonod[27950]: src/gprs.c:gprs_remove() atom: 0x15f1400
ofonod[27950]: plugins/push-notification.c:push_notification_cleanup() 0x15=
d62d0
ofonod[27950]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x15cd540
ofonod[27950]: src/sms.c:sms_remove() atom: 0x15f1200
ofonod[27950]: src/radio-settings.c:radio_settings_remove() atom: 0x15fc6d0
ofonod[27950]: src/phonebook.c:phonebook_remove() atom: 0x15edd90
ofonod[27950]: src/audio-settings.c:audio_settings_remove() atom: 0x15edc00
ofonod[27950]: src/voicecall.c:voicecall_remove() atom: 0x1609170
ofonod[27950]: src/sim.c:sim_remove() atom: 0x15f1530
ofonod[27950]: src/modem.c:devinfo_remove() atom: 0x160de10
ofonod[27950]: plugins/huawei.c:huawei_disable() 0x15ece10
ofonod[27950]: PCUI: > AT+CFUN=3D0\r
ofonod[27950]: plugins/udevng.c:remove_device() /sys/devices/virtual/net/pp=
p0
ofonod[27950]: PCUI: < \r\n+CGREG: 0\r\n
ofonod[27950]: PCUI: < \r\n+CREG: 0\r\n
ofonod[27950]: PCUI: < \r\nOK\r\n
ofonod[27950]: plugins/huawei.c:cfun_disable() =

ofonod[27950]: examples/emulator.c:powered_watch() Removing modem 0x15ece10=
 from the list
ofonod[27950]: examples/emulator.c:powered_watch() Removing server watch: 48
ofonod[27950]: src/modem.c:modem_change_state() old state: 0, new state: 0
ofonod[27950]: plugins/huawei.c:huawei_enable() 0x15ece10
ofonod[27950]: src/modem.c:get_modem_property() modem 0x15ece10 property Mo=
dem
ofonod[27950]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[27950]: src/modem.c:get_modem_property() modem 0x15ece10 property Pc=
ui
ofonod[27950]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB2
ofonod[27950]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[27950]: Modem channel disconnected
ofonod[27950]: Aborting (signal 11) [./src/ofonod]
ofonod[27950]: ++++++++ backtrace ++++++++
ofonod[27950]: #0  0x7f0dc91616f0 in /lib64/libc.so.6
ofonod[27950]: #1  0x49bbb0 in __ofono_atom_free() at src/modem.c:394
ofonod[27950]: #2  0x47be9e in modem_disconnect() at plugins/huawei.c:611
ofonod[27950]: #3  0x7f0dc99a95d8 in /lib64/libglib-2.0.so.0
ofonod[27950]: #4  0x7f0dc99aae24 in /lib64/libglib-2.0.so.0
ofonod[27950]: #5  0x7f0dc99acc60 in /lib64/libglib-2.0.so.0
ofonod[27950]: #6  0x7f0dc99acf60 in /lib64/libglib-2.0.so.0
ofonod[27950]: #7  0x7f0dc99ad272 in /lib64/libglib-2.0.so.0
ofonod[27950]: #8  0x40ffc1 in main() at src/main.c:258
ofonod[27950]: #9  0x7f0dc914b00a in /lib64/libc.so.6
ofonod[27950]: +++++++++++++++++++++++++++

--===============0271645623068477750==--

