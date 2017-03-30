Content-Type: multipart/mixed; boundary="===============6609333779925066907=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 02/28] zte: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:43 +0200
Message-ID: <20170330205309.25850-3-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6609333779925066907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 16 ++++++++++++++++
 plugins/udevng.c   | 25 +++----------------------
 2 files changed, 19 insertions(+), 22 deletions(-)
 create mode 100644 plugins/ofono.hwdb

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
new file mode 100644
index 0000000..75e553b
--- /dev/null
+++ b/plugins/ofono.hwdb
@@ -0,0 +1,16 @@
+# ZTE
+usb:v19D2*icFFiscFFipFF*
+ OFONO_DRIVER=3Dzte
+
+usb:v19D2*icFFiscFFipFFin01
+ OFONO_LABEL=3Daux
+
+usb:v19D2*icFFiscFFipFFin03
+usb:v19D2p0016*icFFiscFFipFFin02
+usb:v19D2p0017*icFFiscFFipFFin02
+ OFONO_LABEL=3Dmodem
+
+usb:v19D2p0016*icFFiscFFipFFin03
+usb:v19D2p0017*icFFiscFFipFFin03
+ OFONO_LABEL=3Dnone
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index d9153b3..d95f71f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -766,44 +766,26 @@ static gboolean setup_simcom(struct modem_info *modem)
 static gboolean setup_zte(struct modem_info *modem)
 {
 	const char *aux =3D NULL, *mdm =3D NULL;
-	const char *modem_intf;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
 =

-	if (g_strcmp0(modem->model, "0016") =3D=3D 0 ||
-				g_strcmp0(modem->model, "0017") =3D=3D 0 ||
-				g_strcmp0(modem->model, "0117") =3D=3D 0)
-		modem_intf =3D "02";
-	else
-		modem_intf =3D "03";
-
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
+		if (g_strcmp0(info->label, "aux") =3D=3D 0)
 			aux =3D info->devnode;
-			if (mdm !=3D NULL)
-				break;
-		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
 			mdm =3D info->devnode;
-			if (aux !=3D NULL)
-				break;
-		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, modem_intf) =3D=3D 0)
-				mdm =3D info->devnode;
-		}
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
 		return FALSE;
 =

-	DBG("aux=3D%s modem=3D%s qcdm=3D%s", aux, mdm, qcdm);
+	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -1457,7 +1439,6 @@ static struct {
 	{ "speedup",	"option",	"2020"		},
 	{ "alcatel",	"option",	"1bbb", "0017"	},
 	{ "novatel",	"option",	"1410"		},
-	{ "zte",	"option",	"19d2"		},
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
-- =

2.9.3


--===============6609333779925066907==--

