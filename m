Content-Type: multipart/mixed; boundary="===============0507074451895188070=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH] gobi: Telit LE910V1 qmi support
Date: Tue, 21 Mar 2017 17:31:21 +0000
Message-ID: <1490117481-1865-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0507074451895188070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

- added enumeration of the LE910 V1 (e.g. LE910-SVG) modems
  to udevng - need to re-use setup_gobi as the qmi-wwan device
  does not have any vid/pid set
- added logic to query modem's ss info from netreg probe, which
  seems to be required for an LTE modem. The modem is always
  connected, and driver never receives a status change
  notification
- disabled low power mode, if a modem is marked AlwaysOnline
- Added sanitization of the operator name string - Telit firmware
  returns non utf-8 characters, which make dbus abort ofono

Signed-off-by: Lukasz Nowak <lnowak@tycoint.com>
---
 drivers/qmimodem/devinfo.c              |  2 +-
 drivers/qmimodem/gprs.c                 |  6 ++++++
 drivers/qmimodem/network-registration.c | 18 +++++++++++++++---
 plugins/gobi.c                          | 26 ++++++++++++++------------
 plugins/udevng.c                        | 24 ++++++++++++++++++++----
 5 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 34aec94..9f0f125 100644
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
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 5e27b0e..5e5c32a 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -174,6 +174,12 @@ static void create_nas_cb(struct qmi_service *service,=
 void *user_data)
 =

 	data->nas =3D qmi_service_ref(service);
 =

+	/* First get the SS info - the modem may already be connected,
+	 * and the state-change notification may never arrive
+	 */
+	qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
+					ss_info_notify, gprs, NULL);
+
 	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
 					ss_info_notify, gprs, NULL);
 =

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 7389ca5..53deb53 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -64,8 +64,9 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status,
 	const struct qmi_nas_serving_system *ss;
 	const struct qmi_nas_current_plmn *plmn;
 	uint8_t i, roaming;
-	uint16_t value16, len;
+	uint16_t value16, len, opname_len;
 	uint32_t value32;
+	const char *opname_end;
 =

 	DBG("");
 =

@@ -100,8 +101,19 @@ static bool extract_ss_info(struct qmi_result *result,=
 int *status,
 						GUINT16_FROM_LE(plmn->mcc));
 		snprintf(operator->mnc, OFONO_MAX_MNC_LENGTH + 1, "%02d",
 						GUINT16_FROM_LE(plmn->mnc));
-		strncpy(operator->name, plmn->desc, plmn->desc_len);
-		operator->name[plmn->desc_len] =3D '\0';
+		opname_len =3D plmn->desc_len;
+		if (opname_len > OFONO_MAX_OPERATOR_NAME_LENGTH)
+			opname_len =3D OFONO_MAX_OPERATOR_NAME_LENGTH;
+
+		/* Some modems/SIMs, e.g. Telit LE910-SVG, return non-utf-8
+		 * characters in plmn-desc[]. When that happens, libdbus will
+		 * abort ofono, refusing to process a non-utf-8 string.
+		 * Try to avoid that situation, by sanitizing the string.
+		 */
+		if (!g_utf8_validate(plmn->desc, opname_len, &opname_end))
+			opname_len =3D opname_end - plmn->desc;
+		strncpy(operator->name, plmn->desc, opname_len);
+		operator->name[opname_len] =3D '\0';
 =

 		DBG("%s (%s:%s)", operator->name, operator->mcc, operator->mnc);
 	}
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6a78941..dc53f92 100644
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
index 2279bbe..3b15064 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -182,14 +182,15 @@ static gboolean setup_gobi(struct modem_info *modem)
 	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
 	const char *gps =3D NULL, *diag =3D NULL;
 	GSList *list;
+	gboolean telit =3D FALSE;
 =

 	DBG("%s", modem->syspath);
 =

 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+					info->number, info->label, info->subsystem);
 =

 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (info->number =3D=3D NULL)
@@ -199,10 +200,18 @@ static gboolean setup_gobi(struct modem_info *modem)
 			else if (g_strcmp0(info->number, "01") =3D=3D 0)
 				diag =3D info->devnode;
 			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
+				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+					net =3D info->devnode;
+				else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) {
+					telit =3D TRUE;
+					qmi =3D info->devnode;
+				} else
+					mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				gps =3D info->devnode;
-		}
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0)
+			if (g_strcmp0(info->number, "04") =3D=3D 0)
+				mdm =3D info->devnode;
 	}
 =

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
@@ -215,6 +224,12 @@ static gboolean setup_gobi(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Diag", diag);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

+	if (telit) {
+		/* Telit LE910 V1 modems */
+		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
+		ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
+	}
+
 	return TRUE;
 }
 =

@@ -1168,6 +1183,7 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
+	{ "gobi",	"option",	"1bc7", "1201"	},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
-- =

2.7.4


--===============0507074451895188070==--

