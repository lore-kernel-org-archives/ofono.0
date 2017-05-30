Content-Type: multipart/mixed; boundary="===============1904014817639881163=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] qmimodem/sms: don't check for free ME space on receive
Date: Tue, 30 May 2017 13:32:38 +0200
Message-ID: <20170530113238.15099-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1904014817639881163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the ME storage is full, the modem will reject new messages
with a SMPP RP-Error 'Protocol error, unspecific'.
It seems the qmimodem is first checking the ME storage for
free space, then deliver the SMS via QMI and not saving it
to the ME anyway.
Using QMI_WMS_STORAGE_TYPE_NONE it doesn't check for free space.

Tested-on: Quectel EC20
---
 drivers/qmimodem/sms.c | 2 +-
 drivers/qmimodem/wms.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 43bf22d1..91501b75 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -411,7 +411,7 @@ static void get_routes_cb(struct qmi_result *result, vo=
id *user_data)
 	new_list->count =3D GUINT16_TO_LE(1);
 	new_list->route[0].msg_type =3D QMI_WMS_MSG_TYPE_P2P;
 	new_list->route[0].msg_class =3D QMI_WMS_MSG_CLASS_NONE;
-	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NV;
+	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NONE;
 	new_list->route[0].action =3D QMI_WMS_ACTION_TRANSFER_AND_ACK;
 =

 	param =3D qmi_param_new();
diff --git a/drivers/qmimodem/wms.h b/drivers/qmimodem/wms.h
index dae86c17..21fe4d95 100644
--- a/drivers/qmimodem/wms.h
+++ b/drivers/qmimodem/wms.h
@@ -62,6 +62,7 @@ struct qmi_wms_param_message {
 #define QMI_WMS_STORAGE_TYPE_UIM		0
 #define QMI_WMS_STORAGE_TYPE_NV			1
 #define QMI_WMS_STORAGE_TYPE_UNKNOWN		2
+#define QMI_WMS_STORAGE_TYPE_NONE		255
 =

 #define QMI_WMS_MESSAGE_MODE_GSMWCDMA		1
 =

-- =

2.13.0


--===============1904014817639881163==--

