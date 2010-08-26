Content-Type: multipart/mixed; boundary="===============1620415786945791033=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem/gprs: fix attached_status response
Date: Thu, 26 Aug 2010 16:08:41 +0300
Message-ID: <1282828121-8948-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1620415786945791033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/gprs.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 3f79972..7c6a806 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -41,6 +41,16 @@
 #include "gpds.h"
 #include "debug.h"
 =

+/* 27.007 Section 10.1.20 <stat> */
+enum network_registration_status {
+	GPRS_STAT_NOT_REGISTERED =3D 0,
+	GPRS_STAT_REGISTERED =3D 1,
+	GPRS_STAT_SEARCHING =3D 2,
+	GPRS_STAT_DENIED =3D 3,
+	GPRS_STAT_UNKNOWN =3D 4,
+	GPRS_STAT_ROAMING =3D 5
+};
+
 struct gprs_data {
 	GIsiClient *client;
 };
@@ -252,6 +262,7 @@ static gboolean status_resp_cb(GIsiClient *client,
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
 	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	int status;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
@@ -263,9 +274,18 @@ static gboolean status_resp_cb(GIsiClient *client,
 =

 	/* FIXME: the core still expects reg status, and not a boolean
 	 * attached status here.*/
+	switch (msg[1]) {
+	case GPDS_ATTACHED:
+		status =3D GPRS_STAT_REGISTERED;
+		break;
+	case GPDS_DETACHED:
+		status =3D GPRS_STAT_NOT_REGISTERED;
+		break;
+	default:
+		status =3D GPRS_STAT_UNKNOWN;
+	}
 =

-	/* CALLBACK_WITH_SUCCESS(cb, msg[1] =3D=3D GPDS_ATTACHED, cbd->data); */
-	CALLBACK_WITH_SUCCESS(cb, 1, cbd->data);
+	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
 =

 	goto out;
 =

-- =

1.7.0.4


--===============1620415786945791033==--

