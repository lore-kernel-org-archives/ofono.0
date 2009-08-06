Content-Type: multipart/mixed; boundary="===============8069382804637888916=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Segmentation fault
Date: Thu, 06 Aug 2009 14:51:27 +0300
Message-ID: <4A7AC3BF.1090008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8069382804637888916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm getting segmentation fault with the latest git version. As a modem
I'm using Nokia E51.

Sent dbus commands:

[root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono /
org.ofono.at.Manager.Create string:"dev:/dev/ttyACM0" string:"at"
method return sender=3D:1.404 -> dest=3D:1.405 reply_serial=3D2
   object path "/modem1"
[root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono /
org.ofono.at.Manager.Destroy objpath:"/modem1"
method return sender=3D:1.404 -> dest=3D:1.406 reply_serial=3D2
[root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono /
org.ofono.at.Manager.Create string:"dev:/dev/ttyACM0" string:"at"
method return sender=3D:1.404 -> dest=3D:1.407 reply_serial=3D2
   object path "/modem2"

gdb output:

ofonod[2191]: SIMManager interface for modem: /modem2 created
ofonod[2191]: Registered call forwarding interface
ofonod[2191]: Registered call settings interface
ofonod[2191]: Sending voice initialization commands
ofonod[2191]: cops_list_cb got result: 1
ofonod[2191]: Final response: OK
ofonod[2191]: Got 0 elements

Program received signal SIGSEGV, Segmentation fault.
operator_list_callback (error=3D0xbfffe85c, total=3D0, list=3D0x0,
data=3D0x80888f0) at network.c:981
981     network.c: No such file or directory.
        in network.c
Missing separate debuginfos, use: debuginfo-install dbus.i586 glibc.i586
(gdb) where
#0  operator_list_callback (error=3D0xbfffe85c, total=3D0, list=3D0x0,
data=3D0x80888f0) at network.c:981
#1  0x0806d4fe in cops_list_cb (ok=3D1, result=3D0xbffff0d4,
user_data=3D0x8089600) at atmodem/network-registration.c:316
#2  0x08074513 in g_at_chat_finish_command (p=3D0x8087820, ok=3D1,
final=3D0x808af98 "OK") at gatchat.c:347
#3  0x08074e0e in g_at_chat_handle_command_response () at gatchat.c:396
#4  have_line (p=3D0x8087820, strip_preceding=3D1) at gatchat.c:480
#5  0x080752a9 in new_bytes () at gatchat.c:664
#6  received_data (channel=3D0x80876f0, cond=3D<value optimized out>,
data=3D0x8087820) at gatchat.c:759
#7  0xb7f336c7 in ?? () from /usr/lib/libglib-2.0.so.0
#8  0x080876f0 in ?? ()
#9  0x00000001 in ?? ()
#10 0x08087820 in ?? ()
#11 0x00000000 in ?? ()

Regards,
Marko


--===============8069382804637888916==--

