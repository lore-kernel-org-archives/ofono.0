Content-Type: multipart/mixed; boundary="===============2416459697447180929=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 25/28] mbm: use standard atom names
Date: Thu, 30 Mar 2017 22:53:06 +0200
Message-ID: <20170330205309.25850-26-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2416459697447180929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/location-reporting.c |  2 +-
 plugins/mbm.c                         |  6 +++---
 plugins/udevng.c                      | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 7c50ac2..4a2196a 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -105,7 +105,7 @@ static int enable_data_stream(struct ofono_location_rep=
orting *lr)
 	int fd;
 =

 	modem =3D ofono_location_reporting_get_modem(lr);
-	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	gps_dev =3D ofono_modem_get_string(modem, "GPS");
 =

 	options =3D g_hash_table_new(g_str_hash, g_str_equal);
 	if (options =3D=3D NULL)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 7d6f92a..62258af 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -314,8 +314,8 @@ static int mbm_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	modem_dev =3D ofono_modem_get_string(modem, "ModemDevice");
-	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
+	modem_dev =3D ofono_modem_get_string(modem, "Modem");
+	data_dev =3D ofono_modem_get_string(modem, "Aux");
 =

 	DBG("%s, %s", modem_dev, data_dev);
 =

@@ -449,7 +449,7 @@ static void mbm_post_online(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	gps_dev =3D ofono_modem_get_string(modem, "GPS");
 	if (gps_dev)
 		data->lr =3D ofono_location_reporting_create(modem, 0,
 					"mbmmodem", data->modem_port);
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2d9ddbe..36c36b7 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -107,7 +107,7 @@ static gboolean setup_isi(struct modem_info *modem)
 =

 static gboolean setup_mbm(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *app =3D NULL, *network =3D NULL, *gps =3D NULL;
+	const char *mdm =3D NULL, *aux =3D NULL, *network =3D NULL, *gps =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -124,7 +124,7 @@ static gboolean setup_mbm(struct modem_info *modem)
 			if (mdm =3D=3D NULL)
 				mdm =3D info->devnode;
 			else
-				app =3D info->devnode;
+				aux =3D info->devnode;
 		} else if (g_str_has_suffix(info->sysattr,
 						"GPS Port") =3D=3D TRUE ||
 				g_str_has_suffix(info->sysattr,
@@ -143,11 +143,11 @@ static gboolean setup_mbm(struct modem_info *modem)
 	if (mdm =3D=3D NULL || app =3D=3D NULL)
 		return FALSE;
 =

-	DBG("modem=3D%s data=3D%s network=3D%s gps=3D%s", mdm, app, network, gps);
+	DBG("modem=3D%s data=3D%s network=3D%s gps=3D%s", mdm, aux, network, gps);
 =

-	ofono_modem_set_string(modem->modem, "ModemDevice", mdm);
-	ofono_modem_set_string(modem->modem, "DataDevice", app);
-	ofono_modem_set_string(modem->modem, "GPSDevice", gps);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "Aux", aux);
+	ofono_modem_set_string(modem->modem, "GPS", gps);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", network);
 =

 	return TRUE;
-- =

2.9.3


--===============2416459697447180929==--

