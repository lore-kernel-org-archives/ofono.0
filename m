Content-Type: multipart/mixed; boundary="===============3046061937499341938=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v3 1/2] gobi: Do not use low-power modes for some modems
Date: Fri, 24 Mar 2017 14:51:45 +0000
Message-ID: <1490367106-8401-2-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490367106-8401-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3046061937499341938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Telit QMI modems have a problem with the low-power operating modes.
After entering and leaving such a state, UIM service does not return.
The sim card is still marked as powered-down. The QMI interface does
not have a way to power it back on.

To avoid this, keep modems with the "AlwaysOnline" flag online
in the disable-modem and offline-modem procedures.
---
 plugins/gobi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6a78941..06f906d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -168,6 +168,16 @@ static void get_oper_mode_cb(struct qmi_result *result=
, void *user_data)
 =

 	data->oper_mode =3D mode;
 =

+	/*
+	 * Telit QMI LTE modem must remain online. If powered down, it also
+	 * powers down the sim card, and QMI interface has no way to bring
+	 * it back alive.
+	 */
+	if (ofono_modem_get_boolean(modem, "AlwaysOnline")) {
+		ofono_modem_set_powered(modem, TRUE);
+		return;
+	}
+
 	switch (data->oper_mode) {
 	case QMI_DMS_OPER_MODE_ONLINE:
 		param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
@@ -353,6 +363,14 @@ static int gobi_disable(struct ofono_modem *modem)
 	qmi_service_cancel_all(data->dms);
 	qmi_service_unregister_all(data->dms);
 =

+	/*
+	 * Telit QMI modem must remain online. If powered down, it also
+	 * powers down the sim card, and QMI interface has no way to bring
+	 * it back alive.
+	 */
+	if (ofono_modem_get_boolean(modem, "AlwaysOnline"))
+		goto out;
+
 	param =3D qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
 					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
 	if (!param)
@@ -362,6 +380,7 @@ static int gobi_disable(struct ofono_modem *modem)
 					power_disable_cb, modem, NULL) > 0)
 		return -EINPROGRESS;
 =

+out:
 	shutdown_device(modem);
 =

 	return -EINPROGRESS;
-- =

2.7.4


--===============3046061937499341938==--

