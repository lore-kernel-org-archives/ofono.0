Content-Type: multipart/mixed; boundary="===============0853997530625956125=="
MIME-Version: 1.0
From: Michael Schloh von Bennewitz <ofonoconn@encambio.com>
Subject: Incoming patch HS2330 detection, plugins/udev.c
Date: Thu, 30 Jun 2011 14:31:24 +0200
Message-ID: <1309437084-3062-1-git-send-email-ofonoconn@encambio.com>
In-Reply-To: <20110628200710.GB20542@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0853997530625956125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
+			g_str_has_suffix(desc, "Module\xc2\xa0""Data Modem") ||
 			g_str_has_suffix(desc, "Broadband Data Modem"))) {
 		devnode =3D udev_device_get_devnode(udev_device);
 		ofono_modem_set_string(modem, DATA_DEVICE, devnode);

--===============0853997530625956125==--

