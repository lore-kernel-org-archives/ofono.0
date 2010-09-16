Content-Type: multipart/mixed; boundary="===============6036485426493708268=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900-v5 5/5] usbpnmodem: plug in either n900 or isigen
Date: Thu, 16 Sep 2010 17:56:19 +0300
Message-ID: <1284648979-19046-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284648979-19046-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6036485426493708268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The usbpnmodem is a stop gap solution until we get udev to support
isimodems. Currently it does the basic configuration of the phonet
interface.
---
 plugins/usbpnmodem.c |   54 ++++++++++++++++++++++++++++++++--------------=
---
 1 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/plugins/usbpnmodem.c b/plugins/usbpnmodem.c
index 68beb6f..d9e39ce 100644
--- a/plugins/usbpnmodem.c
+++ b/plugins/usbpnmodem.c
@@ -39,9 +39,21 @@
 =

 static GPhonetNetlink *link =3D NULL;
 =

+static int match_ifname(char const *name, char const *ifname)
+{
+	size_t namelen =3D strlen(name);
+
+	if (strncmp(name, ifname, namelen) !=3D 0)
+		return FALSE;
+
+	if (ifname[namelen + strspn(ifname + namelen, "0123456789")] !=3D '\0')
+		return FALSE;
+
+	return TRUE;
+}
+
 /*
- * Add or remove isimodems
- * when usbpn* phonet interfaces are added/removed
+ * Add or remove isi modems when phonet interfaces are added/removed
  */
 static void usbpn_status_cb(GIsiModem *idx,
 				GPhonetLinkState st,
@@ -49,37 +61,41 @@ static void usbpn_status_cb(GIsiModem *idx,
 				void *data)
 {
 	struct ofono_modem *modem;
-	int error;
+	char *name;
+	char *driver;
+	int address;
+
+	if (g_pn_netlink_by_modem(idx))
+		/* Modem already exists, be quiet */
+		return;
 =

 	DBG("Phonet link %s (%u) is %s",
 		ifname, g_isi_modem_index(idx),
 		st =3D=3D PN_LINK_REMOVED ? "removed" :
 		st =3D=3D PN_LINK_DOWN ? "down" : "up");
 =

-	/* Expect phonet interface name usbpn<idx> */
-	if (strncmp(ifname, "usbpn", 5) ||
-		ifname[5 + strspn(ifname + 5, "0123456789")])
-		return;
-
 	if (st =3D=3D PN_LINK_REMOVED)
 		return;
 =

-	if (g_pn_netlink_by_modem(idx)) {
-		DBG("Modem for interface %s already exists", ifname);
-		return;
-	}
-
-	error =3D g_pn_netlink_set_address(idx, PN_DEV_PC);
-	if (error && error !=3D -EEXIST) {
-		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+	if (match_ifname("usbpn", ifname)) {
+		/* ISI modem connected via usb */
+		name =3D NULL;
+		driver =3D "isigen";
+		address =3D PN_DEV_PC;
+	} else if (!strcmp("phonet0", ifname)) {
+		/* N900 modem connected via internal hsi link */
+		name =3D "n900";
+		driver =3D "n900";
+		address =3D PN_DEV_SOS;
+	} else
 		return;
-	}
 =

-	modem =3D ofono_modem_create(NULL, "isimodem");
+	modem =3D ofono_modem_create(name, driver);
 	if (!modem)
 		return;
 =

 	ofono_modem_set_string(modem, "Interface", ifname);
+	ofono_modem_set_integer(modem, "Address", address);
 =

 	if (ofono_modem_register(modem) =3D=3D 0)
 		DBG("Done regging modem %s", ofono_modem_get_path(modem));
@@ -99,6 +115,6 @@ static void usbpn_exit(void)
 	link =3D NULL;
 }
 =

-OFONO_PLUGIN_DEFINE(usbpnmodem, "Hotplug driver for USB Phonet modems", VE=
RSION,
+OFONO_PLUGIN_DEFINE(usbpnmodem, "Hotplug driver for Phonet modems", VERSIO=
N,
 			OFONO_PLUGIN_PRIORITY_DEFAULT,
 			usbpn_init, usbpn_exit)
-- =

1.7.0.4


--===============6036485426493708268==--

