Content-Type: multipart/mixed; boundary="===============6450702953739347004=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Crash with activated GPRS and then loosing signal
Date: Thu, 21 Oct 2010 23:23:32 +0200
Message-ID: <1287696212.3316.167.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6450702953739347004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ofonod[24512]: GPRS1: > AT+CGDATA=3D"M-RAW_IP",1\r
ofonod[24512]: GPRS1: < \r\nCONNECT\r\n
ofonod[24512]: Net: < \r\n+XCIEV: 4,\r\n
ofonod[24512]: Net: < \r\n+XCIEV: 3,\r\n
ofonod[24512]: Net: < \r\n+XCIEV: 2,\r\n
ofonod[24512]: Net: < \r\n+XCIEV: 1,\r\n
ofonod[24512]: Net: < \r\n+CREG: 2\r\n
process 24512: arguments to dbus_message_new_signal() were incorrect, asser=
tion "_dbus_check_is_valid_path (path)" failed in file dbus-message.c line =
1287.
This is normally a bug in some application using the D-Bus library.
  D-Bus not built with -rdynamic so unable to print a backtrace
ofonod[24512]: Aborting (signal 6)
ofonod[24512]: ++++++++ backtrace ++++++++
ofonod[24512]: [0]: [0xb78c7400]
ofonod[24512]: [1]: /lib/libc.so.6(abort+0x188) [0x202ea8]
ofonod[24512]: [2]: /lib/libdbus-1.so.3() [0x580285]
ofonod[24512]: [3]: /lib/libdbus-1.so.3() [0x57c176]
ofonod[24512]: [4]: /lib/libdbus-1.so.3(dbus_message_new_signal+0x114) [0x5=
6e904]
ofonod[24512]: [5]: ./ofonod(ofono_dbus_signal_property_changed+0x23) [0x80=
8eef3]
ofonod[24512]: [6]: ./ofonod() [0x8090978]
ofonod[24512]: [7]: ./ofonod() [0x80927b8]
ofonod[24512]: [8]: ./ofonod(ofono_netreg_status_notify+0x246) [0x8092c86]
ofonod[24512]: [9]: ./ofonod() [0x8066ec9]
ofonod[24512]: [10]: /lib/libglib-2.0.so.0(g_slist_foreach+0x25) [0x487310]
ofonod[24512]: [11]: ./ofonod() [0x8056476]
ofonod[24512]: [12]: ./ofonod() [0x80584af]
ofonod[24512]: [13]: /lib/libglib-2.0.so.0() [0x4a3c81]
ofonod[24512]: [14]: /lib/libglib-2.0.so.0(g_main_context_dispatch+0x1b7) [=
0x4717f9]
ofonod[24512]: [15]: /lib/libglib-2.0.so.0() [0x471e20]
ofonod[24512]: [16]: /lib/libglib-2.0.so.0(g_main_loop_run+0x221) [0x4723b7]
ofonod[24512]: [17]: ./ofonod() [0x808b029]
ofonod[24512]: [18]: /lib/libc.so.6(__libc_start_main+0xe7) [0x1eabb7]
ofonod[24512]: [19]: ./ofonod() [0x8050581]
ofonod[24512]: +++++++++++++++++++++++++++

-------- backtrace --------
[0]: ofono_dbus_signal_property_changed() [dbus.c:179]
[1]: set_network_operator_status() [network.c:316]
[2]: current_operator_callback() [network.c:1227]
[3]: ofono_netreg_status_notify() [network.c:1329]
[4]: creg_notify() [network-registration.c:983]
[5]: at_chat_match_notify() [gatchat.c:414]
[6]: received_data() [gatio.c:121]
[7]: main() [main.c:240]
[8]: _start() [audio-settings.c:0]
---------------------------



--===============6450702953739347004==--

