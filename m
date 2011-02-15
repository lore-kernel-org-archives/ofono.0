Content-Type: multipart/mixed; boundary="===============2832828027032628274=="
MIME-Version: 1.0
From: yanni <neelslotter@vodamail.co.za>
Subject: ofonod keeps on dying v0.42
Date: Tue, 15 Feb 2011 16:48:22 +0200
Message-ID: <1297781302.9120.15.camel@yanni-laptop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2832828027032628274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Good Day

I'm running ofono-4.2 with 2 Huawei E180 modems, one modem is performing
basic SMS tests and the other modem is doing some ussd tests. =


below is the output from ofonod if it dies.
any idea what's going wrong?
 =

ofonod -d -n =

###
ofonod[10792]: src/gprs.c:registration_status_cb() /huawei5 error 0
status 1
ofonod[10792]: src/gprs.c:ofono_gprs_status_notify() /huawei5 status 1
ofonod[10792]: drivers/atmodem/sms.c:at_cmgs_cb() Got MR: 21
ofonod[10792]: src/sms.c:tx_finished() tx_finished
ofonod[10792]: Aborting (signal 11)
ofonod[10792]: ++++++++ backtrace ++++++++
ofonod[10792]: [0]: [0xa0e400]
ofonod[10792]: [1]: ofonod [0x8079de7]
ofonod[10792]: [2]: ofonod [0x806d251]
ofonod[10792]: [3]: ofonod [0x806df51]
ofonod[10792]: [4]: ofonod [0x806fbb7]
ofonod[10792]: [5]: /lib/libglib-2.0.so.0 [0x549dab]
ofonod[10792]: [6]: /lib/libglib-2.0.so.0(g_main_context_dispatch+0x1f8)
[0x512e88]
ofonod[10792]: [7]: /lib/libglib-2.0.so.0 [0x516730]
ofonod[10792]: [8]: /lib/libglib-2.0.so.0(g_main_loop_run+0x1bf)
[0x516b9f]
ofonod[10792]: [9]: ofonod [0x80b0cd9]
ofonod[10792]: [10]: /lib/tls/i686/cmov/libc.so.6(__libc_start_main
+0xe6) [0x13db56]
ofonod[10792]: [11]: ofonod [0x8052961]
ofonod[10792]: +++++++++++++++++++++++++++


--===============2832828027032628274==--

