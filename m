Content-Type: multipart/mixed; boundary="===============6952100867913073767=="
MIME-Version: 1.0
From: Nicolas Paccou <nicolas.paccou@linux.intel.com>
Subject: RE: Incoming patch HS2330 detection, plugins/udev.c
Date: Wed, 20 Jul 2011 12:55:28 +0000
Message-ID: <004401cc46dc$48a564d0$d9f02e70$@paccou@linux.intel.com>
In-Reply-To: <1309437084-3062-1-git-send-email-ofonoconn@encambio.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6952100867913073767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

I'm Nicolas Paccou, I'm in charge of validating the changes applied in new
oFono release.
Unfortunately, I have not the hardware to be able to regress your patch.

I wanted to know if you have tested your patch on HS2330 modem ?
If yes, can you tell me if the result is ok ?
If not, do you able to test it and tell me the result please ?

Thanks,
Nicolas

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of
Michael Schloh von Bennewitz
Sent: Thursday, June 30, 2011 2:31 PM
To: Ofono List
Subject: Incoming patch HS2330 detection, plugins/udev.c

This patch is assembled according to discussions on #ofono
irc.freenode.net and mailing list thread 'Problem detecting/using wwan0
modem' in June 2011, after comprehensive guidance from Denis KENZIOR.

Denis had already modified plugins/udev.c in git commit
6a2847f7aba5d84b06940ee29300d4b6fd31d682 to correct detection of
OEM Ericsson F3607gw modems relabeled by HP and sold as HS2330.
Because some (or all?) HS2330 modems contain flawed text identifiers
containing strange (probably erroneous) binary sequences in place of
the ASCII space '\x20' character, the previous commit is incomplete.
The following logic detects the modem properly, by comparing binary
data as well as ASCII text values.

Michael Schloh von Bennewitz
http://michael.schloh.com/
30 June 2011

Index: plugins/udev.c
diff -Nau plugins/udev.c.orig plugins/udev.c
--- plugins/udev.c.orig	2011-06-30 13:42:29.279704948 +0200
+++ plugins/udev.c	2011-06-30 13:43:48.117205221 +0200
@@ -134,6 +134,7 @@
 			(g_str_has_suffix(desc, "Minicard Data Modem") ||
 			g_str_has_suffix(desc, "Mini-Card Data Modem") ||
 			g_str_has_suffix(desc, "Module Data Modem") ||
+			g_str_has_suffix(desc, "Module\xc2\xa0""Data Modem")
||
 			g_str_has_suffix(desc, "Broadband Data Modem"))) {
 		devnode =3D udev_device_get_devnode(udev_device);
 		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


--===============6952100867913073767==--

