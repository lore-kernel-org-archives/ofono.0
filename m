Content-Type: multipart/mixed; boundary="===============2080447494591993647=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: ISI crash when disconnecting N900 from USB
Date: Wed, 13 Oct 2010 07:05:52 +0300
Message-ID: <1286942752.3425.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2080447494591993647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ofonod[6748]: Aborting (signal 11)
ofonod[6748]: ++++++++ backtrace ++++++++
ofonod[6748]: [0]: /lib64/libpthread.so.0() [0x38fa60f440]
ofonod[6748]: [1]: ./src/ofonod() [0x4151d8]
ofonod[6748]: [2]: ./src/ofonod() [0x41546a]
ofonod[6748]: [3]: ./src/ofonod() [0x4112b9]
ofonod[6748]: [4]: /lib64/libc.so.6(tdestroy+0x3d) [0x38f9edfc7d]
ofonod[6748]: [5]: ./src/ofonod() [0x4116cb]
ofonod[6748]: [6]: ./src/ofonod() [0x416221]
ofonod[6748]: [7]: ./src/ofonod() [0x45db29]
ofonod[6748]: [8]: ./src/ofonod() [0x457268]
ofonod[6748]: [9]: ./src/ofonod(ofono_modem_set_powered+0x10a) [0x457f5a]
ofonod[6748]: [10]: ./src/ofonod() [0x420dd1]
ofonod[6748]: [11]: ./src/ofonod() [0x4108e0]
ofonod[6748]: [12]: /lib64/libglib-2.0.so.0(g_main_context_dispatch+0x1f2) =
[0x38fba3bd02]
ofonod[6748]: [13]: /lib64/libglib-2.0.so.0() [0x38fba3fae8]
ofonod[6748]: [14]: /lib64/libglib-2.0.so.0(g_main_loop_run+0x195) [0x38fba=
3fff5]
ofonod[6748]: [15]: ./src/ofonod() [0x4561f0]
ofonod[6748]: [16]: /lib64/libc.so.6(__libc_start_main+0xfd) [0x38f9e1ec5d]
ofonod[6748]: [17]: ./src/ofonod() [0x40b7e9]
ofonod[6748]: +++++++++++++++++++++++++++

-------- backtrace --------
[0]: isi_registration_status() [network-registration.c:271]
[1]: set_auto_resp_cb() [network-registration.c:535]
[2]: g_isi_cleanup_req() [client.c:241]
[3]: g_isi_client_destroy() [client.c:310]
[4]: isi_netreg_remove() [network-registration.c:974]
[5]: netreg_remove() [network.c:1724]
[6]: flush_atoms() [modem.c:350]
[7]: ofono_modem_set_powered() [modem.c:794]
[8]: report_powered() [isigen.c:77]
[9]: g_pn_nl_link() [netlink.c:203]
[10]: main() [main.c:240]
[11]: _start() [audio-settings.c:0]
---------------------------



--===============2080447494591993647==--

