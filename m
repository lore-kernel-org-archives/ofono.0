Content-Type: multipart/mixed; boundary="===============8636595335848917833=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/2] add qmimodem/voice.h to add USSD defines
Date: Tue, 16 Jan 2018 16:33:24 +0100
Message-ID: <20180116153325.20491-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8636595335848917833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

USSD is part of the QMI voice service.
---
 drivers/qmimodem/voice.h | 62 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 62 insertions(+)
 create mode 100644 drivers/qmimodem/voice.h

diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
new file mode 100644
index 000000000000..ca1464910914
--- /dev/null
+++ b/drivers/qmimodem/voice.h
@@ -0,0 +1,62 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 by sysmocom s.f.m.c. GmbH <info@sysmocom.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#define QMI_VOICE_PARAM_USS_DATA 0x01
+
+#define QMI_VOICE_PARAM_ASYNC_USSD_ERROR 0x10
+#define QMI_VOICE_PARAM_ASYNC_USSD_FAILURE_CASE 0x11
+#define QMI_VOICE_PARAM_ASYNC_USSD_DATA 0x12
+
+#define QMI_VOICE_PARAM_USSD_IND_USER_ACTION 0x01
+#define QMI_VOICE_PARAM_USSD_IND_DATA 0x10
+#define QMI_VOICE_PARAM_USSD_IND_UCS2 0x11
+
+/* according to GSM TS 23.038 section 5
+ * coding group 1111, No message class, 8 bit data
+ */
+#define USSD_DCS_8BIT 0xf4
+/* coding group 01xx, Class 0, UCS2 (16 bit) */
+#define USSD_DCS_UCS2 0x48
+/* default alphabet Language unspecific */
+#define USSD_DCS_UNSPECIFIC 0x0f
+
+/* based on qmi ussd definition */
+enum qmi_ussd_dcs {
+	QMI_USSD_DCS_ASCII =3D 0x1,
+	QMI_USSD_DCS_8BIT,
+	QMI_USSD_DCS_UCS2,
+};
+
+enum qmi_ussd_user_required {
+	QMI_USSD_NO_USER_ACTION_REQUIRED =3D 0x1,
+	QMI_USSD_USER_ACTION_REQUIRED,
+};
+
+/* QMI service voice. Using an enum to prevent doublicated entries */
+enum voice_commands {
+	QMI_VOICE_CANCEL_USSD =3D		0x3c,
+	QMI_VOICE_USSD_RELEASE_IND =3D	0x3d,
+	QMI_VOICE_USSD_IND =3D		0x3e,
+	QMI_VOICE_SUPS_IND =3D		0x42,
+	QMI_VOICE_ASYNC_ORIG_USSD =3D	0x43,
+};
+
+struct qmi_ussd_data {
+	uint8_t dcs;
+	uint8_t length;
+	uint8_t data[0];
+} __attribute__((__packed__));
-- =

2.15.1


--===============8636595335848917833==--

