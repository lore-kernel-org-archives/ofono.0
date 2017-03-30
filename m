Content-Type: multipart/mixed; boundary="===============5218642011148799577=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 28/28] udevng: consolidate setup functions for several
 USB devices
Date: Thu, 30 Mar 2017 22:53:09 +0200
Message-ID: <20170330205309.25850-29-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5218642011148799577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch consolidates a the setup functions for several USB device
types.  These are the "simple" types that only map a couple of interfaces
to modem functions; the more complex types will be moved to this model
in a later patch.

A new function setup_usb_modem is added that maps udev-labelled interfaces
to ofono modem atoms.  The drivers will use the atoms that they know about
and ignore any others; the udev labelling should, however, normally
ensure that the only labelled interfaces are those that the driver
actually cares about (though that's not actually the case today as there
are labelled interfaces that ofono doesn't use).
---
 plugins/udevng.c | 269 ++++++---------------------------------------------=
----
 1 file changed, 27 insertions(+), 242 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 555261e..2af7e77 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -150,9 +150,10 @@ static gboolean setup_mbm(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_hso(struct modem_info *modem)
+static gboolean setup_usb_modem(struct modem_info* modem)
 {
 	const char *ctl =3D NULL, *app =3D NULL, *mdm =3D NULL, *net =3D NULL;
+	const char *aux =3D NULL, *gps =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -161,23 +162,33 @@ static gboolean setup_hso(struct modem_info *modem)
 		struct device_info *info =3D list->data;
 =

 		DBG("%s %s %s %s %s", info->devnode, info->interface,
-				info->number, info->label, info->sysattr);
+				info->number, info->label, info->subsystem);
 =

 		if (g_strcmp0(info->label, "control") =3D=3D 0)
 			ctl =3D info->devnode;
-		else if (g_strcmp0(info->label, "app") =3D=3D 0)
-			app =3D info->devnode;
 		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
 			mdm =3D info->devnode;
+		else if (g_strcmp0(info->label, "aux") =3D=3D 0)
+			aux =3D info->devnode;
+		else if (g_strcmp0(info->label, "app") =3D=3D 0)
+			app =3D info->devnode;
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
+			net =3D info->devnode;
+		else if (g_strcmp0(info->label, "gps") =3D=3D 0)
+			gps =3D info->devnode;
 	}
 =

-	DBG("control=3D%s application=3D%s modem=3D%s network=3D%s",
-						ctl, app, mdm, net);
+	DBG("driver=3D%s control=3D%s application=3D%s"
+	    " modem=3D%s aux=3D%s network=3D%s gps=3D%s",
+		modem->driver,
+		ctl, app, mdm, aux, net, gps);
 =

 	ofono_modem_set_string(modem->modem, "Control", ctl);
 	ofono_modem_set_string(modem->modem, "Application", app);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	ofono_modem_set_string(modem->modem, "GPS", gps);
 =

 	return TRUE;
 }
@@ -313,177 +324,6 @@ done:
 	return TRUE;
 }
 =

-static gboolean setup_speedup(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
-			aux =3D info->devnode;
-			if (mdm !=3D NULL)
-				break;
-		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
-			mdm =3D info->devnode;
-			if (aux !=3D NULL)
-				break;
-		}
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
-static gboolean setup_linktop(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
-static gboolean setup_icera(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-		else if (g_strcmp0(info->label, "net") =3D=3D 0)
-			mdm =3D info->devnode;
-	}
-
-	DBG("aux=3D%s modem=3D%s net=3D%s", aux, mdm, net);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
-
-	return TRUE;
-}
-
-static gboolean setup_alcatel(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
-			aux =3D info->devnode;
-		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
-			mdm =3D info->devnode;
-		}
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
-static gboolean setup_novatel(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
-static gboolean setup_nokia(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
 static gboolean setup_telit(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *net =3D NULL;
@@ -591,33 +431,6 @@ static gboolean setup_simcom(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_zte(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
 static gboolean setup_samsung(struct modem_info *modem)
 {
 	const char *control =3D NULL, *network =3D NULL;
@@ -648,34 +461,6 @@ static gboolean setup_samsung(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_quectel(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
-			aux =3D info->devnode;
-		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
-			mdm =3D info->devnode;
-		}
-	}
-
-	DBG("aux=3D%s modem=3D%s", aux, mdm);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-
-	return TRUE;
-}
-
 static gboolean setup_serial_modem(struct modem_info* modem)
 {
 	struct serial_device_info* info;
@@ -858,23 +643,23 @@ static struct {
 } driver_list[] =3D {
 	{ "isiusb",	setup_isi,	},
 	{ "mbm",	setup_mbm,	"device/interface"	},
-	{ "hso",	setup_hso,	"hsotype"		},
+	{ "hso",	setup_usb_modem },
 	{ "gobi",	setup_gobi	},
 	{ "sierra",	setup_sierra	},
 	{ "huawei",	setup_huawei	},
-	{ "speedupcdma",setup_speedup	},
-	{ "speedup",	setup_speedup	},
-	{ "linktop",	setup_linktop	},
-	{ "alcatel",	setup_alcatel	},
-	{ "novatel",	setup_novatel	},
-	{ "nokia",	setup_nokia	},
+	{ "speedupcdma",setup_usb_modem	},
+	{ "speedup",	setup_usb_modem	},
+	{ "linktop",	setup_usb_modem	},
+	{ "alcatel",	setup_usb_modem	},
+	{ "novatel",	setup_usb_modem	},
+	{ "nokia",	setup_usb_modem },
 	{ "telit",	setup_telit,	"device/interface"	},
 	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
-	{ "zte",	setup_zte	},
-	{ "icera",	setup_icera	},
+	{ "zte",	setup_usb_modem	},
+	{ "icera",	setup_usb_modem	},
 	{ "samsung",	setup_samsung	},
-	{ "quectel",	setup_quectel	},
+	{ "quectel",	setup_usb_modem	},
 	{ "ublox",	setup_ublox	},
 	{ "gemalto",	setup_gemalto	},
 	/* Following are non-USB modems */
-- =

2.9.3


--===============5218642011148799577==--

