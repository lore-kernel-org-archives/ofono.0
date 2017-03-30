Content-Type: multipart/mixed; boundary="===============7898879157396044509=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 27/28] udevng: push device existence check into drivers
Date: Thu, 30 Mar 2017 22:53:08 +0200
Message-ID: <20170330205309.25850-28-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7898879157396044509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The drivers themselves know best which "channels" are sufficient for
operation and which channels are optional.  This patch moves the
check for sufficient channels from the udevng setup_* functions into
the drivers' probe functions.
---
 plugins/alcatel.c |  9 +++++++++
 plugins/gobi.c    |  9 +++++++++
 plugins/hso.c     |  9 +++++++++
 plugins/huawei.c  |  9 +++++++++
 plugins/icera.c   |  9 +++++++++
 plugins/linktop.c |  9 +++++++++
 plugins/mbm.c     |  9 +++++++++
 plugins/nokia.c   |  9 +++++++++
 plugins/novatel.c |  9 +++++++++
 plugins/quectel.c |  9 +++++++++
 plugins/speedup.c |  9 +++++++++
 plugins/telit.c   |  9 +++++++++
 plugins/udevng.c  | 39 ---------------------------------------
 plugins/zte.c     |  9 +++++++++
 14 files changed, 117 insertions(+), 39 deletions(-)

diff --git a/plugins/alcatel.c b/plugins/alcatel.c
index fb1d1ae..c04ba3c 100644
--- a/plugins/alcatel.c
+++ b/plugins/alcatel.c
@@ -52,9 +52,18 @@ struct alcatel_data {
 static int alcatel_probe(struct ofono_modem *modem)
 {
 	struct alcatel_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct alcatel_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/gobi.c b/plugins/gobi.c
index df35f94..f0de918 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -81,9 +81,18 @@ static void gobi_debug(const char *str, void *user_data)
 static int gobi_probe(struct ofono_modem *modem)
 {
 	struct gobi_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Device");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "NetworkInterface");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct gobi_data, 1);
 	if (!data)
 		return -ENOMEM;
diff --git a/plugins/hso.c b/plugins/hso.c
index 249bb2c..3a90dd9 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -68,9 +68,18 @@ struct hso_data {
 static int hso_probe(struct ofono_modem *modem)
 {
 	struct hso_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Control");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Application");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct hso_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/huawei.c b/plugins/huawei.c
index f02315d..9e71b6b 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -96,9 +96,18 @@ struct huawei_data {
 static int huawei_probe(struct ofono_modem *modem)
 {
 	struct huawei_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Pcui");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct huawei_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/icera.c b/plugins/icera.c
index 7df5ffd..eb33230 100644
--- a/plugins/icera.c
+++ b/plugins/icera.c
@@ -60,9 +60,18 @@ struct icera_data {
 static int icera_probe(struct ofono_modem *modem)
 {
 	struct icera_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct icera_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/linktop.c b/plugins/linktop.c
index bb0d7b8..68e91af 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -58,9 +58,18 @@ struct linktop_data {
 static int linktop_probe(struct ofono_modem *modem)
 {
 	struct linktop_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct linktop_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 62258af..0876e9c 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -74,9 +74,18 @@ struct mbm_data {
 static int mbm_probe(struct ofono_modem *modem)
 {
 	struct mbm_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct mbm_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/nokia.c b/plugins/nokia.c
index ef598fa..18014a0 100644
--- a/plugins/nokia.c
+++ b/plugins/nokia.c
@@ -55,9 +55,18 @@ struct nokia_data {
 static int nokia_probe(struct ofono_modem *modem)
 {
 	struct nokia_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct nokia_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/novatel.c b/plugins/novatel.c
index a64364d..e90d320 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -60,9 +60,18 @@ struct novatel_data {
 static int novatel_probe(struct ofono_modem *modem)
 {
 	struct novatel_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct novatel_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/quectel.c b/plugins/quectel.c
index ba1aa42..a116edd 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -64,9 +64,18 @@ static void quectel_debug(const char *str, void *user_da=
ta)
 static int quectel_probe(struct ofono_modem *modem)
 {
 	struct quectel_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct quectel_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/speedup.c b/plugins/speedup.c
index d1ea35a..9aa9743 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -63,9 +63,18 @@ struct speedup_data {
 static int speedup_probe(struct ofono_modem *modem)
 {
 	struct speedup_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct speedup_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/telit.c b/plugins/telit.c
index b194b65..24c4d0e 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -509,9 +509,18 @@ static void telit_post_online(struct ofono_modem *mode=
m)
 static int telit_probe(struct ofono_modem *modem)
 {
 	struct telit_data *data;
+	const char* device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct telit_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4f94546..555261e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -140,9 +140,6 @@ static gboolean setup_mbm(struct modem_info *modem)
 		}
 	}
 =

-	if (mdm =3D=3D NULL || app =3D=3D NULL)
-		return FALSE;
-
 	DBG("modem=3D%s data=3D%s network=3D%s gps=3D%s", mdm, aux, network, gps);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -174,9 +171,6 @@ static gboolean setup_hso(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (ctl =3D=3D NULL || app =3D=3D NULL)
-		return FALSE;
-
 	DBG("control=3D%s application=3D%s modem=3D%s network=3D%s",
 						ctl, app, mdm, net);
 =

@@ -217,9 +211,6 @@ static gboolean setup_gobi(struct modem_info *modem)
 			gps =3D info->devnode;
 	}
 =

-	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
-		return FALSE;
-
 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

 	/* FIXME: gps node not used... */
@@ -310,9 +301,6 @@ static gboolean setup_huawei(struct modem_info *modem)
 		goto done;
 	}
 =

-	if (mdm =3D=3D NULL || pcui =3D=3D NULL)
-		return FALSE;
-
 done:
 	DBG("mdm=3D%s pcui=3D%s diag=3D%s qmi=3D%s net=3D%s", mdm, pcui, diag, qm=
i, net);
 =

@@ -349,9 +337,6 @@ static gboolean setup_speedup(struct modem_info *modem)
 		}
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -379,9 +364,6 @@ static gboolean setup_linktop(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -411,9 +393,6 @@ static gboolean setup_icera(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s net=3D%s", aux, mdm, net);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -443,9 +422,6 @@ static gboolean setup_alcatel(struct modem_info *modem)
 		}
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -473,9 +449,6 @@ static gboolean setup_novatel(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -503,9 +476,6 @@ static gboolean setup_nokia(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -538,9 +508,6 @@ static gboolean setup_telit(struct modem_info *modem)
 				net =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("modem=3D%s aux=3D%s gps=3D%s net=3D%s", mdm, aux, gps, net);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -643,9 +610,6 @@ static gboolean setup_zte(struct modem_info *modem)
 			mdm =3D info->devnode;
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
@@ -704,9 +668,6 @@ static gboolean setup_quectel(struct modem_info *modem)
 		}
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
 	DBG("aux=3D%s modem=3D%s", aux, mdm);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
diff --git a/plugins/zte.c b/plugins/zte.c
index 53beefe..b2b3a70 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -60,9 +60,18 @@ struct zte_data {
 static int zte_probe(struct ofono_modem *modem)
 {
 	struct zte_data *data;
+	const char *device;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Modem");
+	if (!device)
+		return -ENODEV;
+
+	device =3D ofono_modem_get_string(modem, "Aux");
+	if (!device)
+		return -ENODEV;
+
 	data =3D g_try_new0(struct zte_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
-- =

2.9.3


--===============7898879157396044509==--

