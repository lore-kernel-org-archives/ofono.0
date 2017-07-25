Content-Type: multipart/mixed; boundary="===============6167335967249072597=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] drivers/qmimodem: don't change the RAT when registering to an
 operator
Date: Tue, 25 Jul 2017 15:17:49 +0200
Message-ID: <20170725131749.17831-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6167335967249072597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When registering to an operator ofono uses the old RAT.
In the case the modem is not connected to any network, this would use
QMI_NAS_NETWORK_RAT_NONE which results in the error OP_DEVICE_UNSUPPORTED.

Use QMI_NAS_NETWORK_RAT_NO_CHANGE instead to not define any preference.
---
 drivers/qmimodem/nas.h                  | 1 +
 drivers/qmimodem/network-registration.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index 09807f83..d2feb464 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -97,6 +97,7 @@ struct qmi_nas_network_rat {
 	} __attribute__((__packed__)) info[0];
 } __attribute__((__packed__));
 =

+#define QMI_NAS_NETWORK_RAT_NONE		0x00
 #define QMI_NAS_NETWORK_RAT_GSM			0x04
 #define QMI_NAS_NETWORK_RAT_UMTS		0x05
 #define QMI_NAS_NETWORK_RAT_LTE			0x08
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 52ad69a6..04de5a5b 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -356,7 +356,7 @@ static void qmi_register_manual(struct ofono_netreg *ne=
treg,
 =

 	info.mcc =3D atoi(mcc);
 	info.mnc =3D atoi(mnc);
-	info.rat =3D data->current_rat;
+	info.rat =3D QMI_NAS_NETWORK_RAT_NO_CHANGE;
 =

 	qmi_param_append(param, QMI_NAS_PARAM_REGISTER_MANUAL_INFO,
 						sizeof(info), &info);
-- =

2.13.3


--===============6167335967249072597==--

