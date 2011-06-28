Content-Type: multipart/mixed; boundary="===============4180027209234000684=="
MIME-Version: 1.0
From: Michael Schloh von Bennewitz <ofonoconn@encambio.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Tue, 28 Jun 2011 22:07:12 +0200
Message-ID: <20110628200710.GB20542@debut.europalab.com>
In-Reply-To: <4E08BC04.3030105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4180027209234000684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello,

After much help from Denis, here's a incoming patch for detection
of HP hs2330 butchered Ericsson F3607gw modem.


On mon., June 27, 2011, Denis Kenzior wrote:
>>From 6a2847f7aba5d84b06940ee29300d4b6fd31d682 Mon Sep 17 00:00:00 2001
>From: Denis Kenzior <denkenz@gmail.com>
>Date: Mon, 27 Jun 2011 12:17:22 -0500
>Subject: [PATCH] udev: Tweak detection rules for HP HS2330 cards
>
>---
> plugins/udev.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>diff --git a/plugins/udev.c b/plugins/udev.c
>index 1580b02..8ea937c 100644
>--- a/plugins/udev.c
>+++ b/plugins/udev.c
>@@ -122,6 +122,7 @@ static void add_mbm(struct ofono_modem *modem,
> 			g_str_has_suffix(desc, "Minicard Modem 2") ||
> 			g_str_has_suffix(desc, "Mini-Card Modem") ||
> 			g_str_has_suffix(desc, "Broadband Modem") ||
>+			g_str_has_suffix(desc, "Module Modem") ||
> 			g_str_has_suffix(desc, "Broadband USB Modem"))) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> =

>@@ -132,11 +133,13 @@ static void add_mbm(struct ofono_modem *modem,
> 	} else if (registered =3D=3D 0 &&
> 			(g_str_has_suffix(desc, "Minicard Data Modem") ||
> 			g_str_has_suffix(desc, "Mini-Card Data Modem") ||
>+			g_str_has_suffix(desc, "Module Data Modem") ||
> 			g_str_has_suffix(desc, "Broadband Data Modem"))) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> 		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
> 	} else if (g_str_has_suffix(desc, "Minicard GPS Port") ||
> 			g_str_has_suffix(desc, "Mini-Card GPS Port") ||
>+			g_str_has_suffix(desc, "Module NMEA") ||
> 			g_str_has_suffix(desc, "Broadband GPS Port")) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> 		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
>@@ -144,6 +147,7 @@ static void add_mbm(struct ofono_modem *modem,
> 			(g_str_has_suffix(desc, "Minicard Network Adapter") ||
> 			g_str_has_suffix(desc, "Mini-Card Network Adapter") ||
> 			g_str_has_suffix(desc, "Broadband Network Adapter") ||
>+			g_str_has_suffix(desc, "Module Network Adapter") ||
> 			g_str_has_suffix(desc, "Minicard NetworkAdapter"))) {
> 		devnode =3D get_property(udev_device, "INTERFACE");
> 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
>-- =

>1.7.3.4
>
Index: plugins/udev.c
--- plugins/udev.c.orig	2011-06-15 14:45:37.000000000 +0200
+++ plugins/udev.c	2011-06-28 16:33:26.003136888 +0200
@@ -122,6 +122,7 @@
 			g_str_has_suffix(desc, "Minicard Modem 2") ||
 			g_str_has_suffix(desc, "Mini-Card Modem") ||
 			g_str_has_suffix(desc, "Broadband Modem") ||
+			g_str_has_suffix(desc, "Module Modem") ||
 			g_str_has_suffix(desc, "Broadband USB Modem"))) {
 		devnode =3D udev_device_get_devnode(udev_device);
 =

@@ -132,11 +133,14 @@
 	} else if (registered =3D=3D 0 &&
 			(g_str_has_suffix(desc, "Minicard Data Modem") ||
 			g_str_has_suffix(desc, "Mini-Card Data Modem") ||
+			g_str_has_suffix(desc, "Module Data Modem") ||
+			g_str_has_suffix(desc, "Module\xc2\xa0""Data Modem") ||
 			g_str_has_suffix(desc, "Broadband Data Modem"))) {
 		devnode =3D udev_device_get_devnode(udev_device);
 		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
 	} else if (g_str_has_suffix(desc, "Minicard GPS Port") ||
 			g_str_has_suffix(desc, "Mini-Card GPS Port") ||
+			g_str_has_suffix(desc, "Module NMEA") ||
 			g_str_has_suffix(desc, "Broadband GPS Port")) {
 		devnode =3D udev_device_get_devnode(udev_device);
 		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
@@ -144,6 +148,7 @@
 			(g_str_has_suffix(desc, "Minicard Network Adapter") ||
 			g_str_has_suffix(desc, "Mini-Card Network Adapter") ||
 			g_str_has_suffix(desc, "Broadband Network Adapter") ||
+			g_str_has_suffix(desc, "Module Network Adapter") ||
 			g_str_has_suffix(desc, "Minicard NetworkAdapter"))) {
 		devnode =3D get_property(udev_device, "INTERFACE");
 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);

The only difference is the line with the hex characters.

Regards,
Michael

--===============4180027209234000684==--

