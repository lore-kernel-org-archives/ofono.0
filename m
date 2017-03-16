Content-Type: multipart/mixed; boundary="===============6203673042591882085=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH] support Telit LE910 modem
Date: Thu, 16 Mar 2017 10:32:04 +0100
Message-ID: <20170316093204.25275-2-gluedig@gmail.com>
In-Reply-To: <20170316093204.25275-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6203673042591882085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/devinfo.c |  2 +-
 plugins/gobi.c             | 26 ++++++++++++++------------
 plugins/udevng.c           | 46 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 34aec94a..9f0f1259 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -125,7 +125,7 @@ static void get_ids_cb(struct qmi_result *result, void =
*user_data)
 	}
 =

 	str =3D qmi_result_get_string(result, QMI_DMS_RESULT_ESN);
-	if (!str) {
+	if (!str || strcmp(str, "0") =3D=3D 0) {
 		str =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMEI);
 		if (!str) {
 			CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6a789411..dc53f92a 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -167,22 +167,24 @@ static void get_oper_mode_cb(struct qmi_result *resul=
t, void *user_data)
 	}
 =

 	data->oper_mode =3D mode;
-
 	switch (data->oper_mode) {
 	case QMI_DMS_OPER_MODE_ONLINE:
-		param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
-		if (!param) {
+		if (ofono_modem_get_boolean(modem, "AlwaysOnline") !=3D TRUE) {
+			DBG("set QMI_DMS_OPER_MODE_PERSIST_LOW_POWER");
+			param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
+						    QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
+			if (!param) {
+				shutdown_device(modem);
+				return;
+			}
+
+			if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
+					     power_reset_cb, modem, NULL) > 0)
+				return;
+
 			shutdown_device(modem);
-			return;
+			break;
 		}
-
-		if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
-					power_reset_cb, modem, NULL) > 0)
-			return;
-
-		shutdown_device(modem);
-		break;
 	default:
 		ofono_modem_set_powered(modem, TRUE);
 		break;
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2279bbe9..b3c4bc74 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -218,6 +218,51 @@ static gboolean setup_gobi(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_le910(struct modem_info *modem)
+{
+	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL, *aux =3D NULL;
+	GSList *list;
+
+	DBG("%p %s", modem, modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				    info->number, info->label, info->subsystem);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+			if (g_strcmp0(info->number, "02") =3D=3D 0) {
+			    if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			    else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
+			}
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
+			if (g_strcmp0(info->number, "04") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "05") =3D=3D 0)
+				aux =3D info->devnode;
+		}
+	}
+
+	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
+		return FALSE;
+
+	DBG("qmi=3D%s net=3D%s", qmi, net);
+	DBG("mdm=3D%s aux=3D%s", mdm, aux);
+
+	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	ofono_modem_set_string(modem->modem, "Aux", aux);
+	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
+	ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
+	ofono_modem_set_driver(modem->modem, "gobi");
+
+	return TRUE;
+}
+
 static gboolean setup_sierra(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL, *=
qmi =3D NULL;
@@ -942,6 +987,7 @@ static struct {
 	{ "mbm",	setup_mbm,	"device/interface"	},
 	{ "hso",	setup_hso,	"hsotype"		},
 	{ "gobi",	setup_gobi	},
+	{ "le910",	setup_le910	},
 	{ "sierra",	setup_sierra	},
 	{ "option",	setup_option	},
 	{ "huawei",	setup_huawei	},
-- =

2.11.0


--===============6203673042591882085==--

