Content-Type: multipart/mixed; boundary="===============0899432150871587778=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2 2/5] qmimodem: read ss_info at probe time
Date: Wed, 22 Mar 2017 18:14:50 +0000
Message-ID: <1490206493-17454-3-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490206493-17454-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0899432150871587778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

LTE modems (observed with Telit LE910 V1) can power on
already registered to a network. In that case, the SS_INFO
change notification will never arrive, and the gprs driver
will never be marked as attached.

To avoid this situation, read SS_INFO at probe time, and if
registered, mark the gprs driver as attached.
---
 drivers/qmimodem/gprs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 5e27b0e..983223e 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -174,6 +174,13 @@ static void create_nas_cb(struct qmi_service *service,=
 void *user_data)
 =

 	data->nas =3D qmi_service_ref(service);
 =

+	/*
+	 * First get the SS info - the modem may already be connected,
+	 * and the state-change notification may never arrive
+	 */
+	qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
+					ss_info_notify, gprs, NULL);
+
 	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
 					ss_info_notify, gprs, NULL);
 =

-- =

2.7.4


--===============0899432150871587778==--

