Content-Type: multipart/mixed; boundary="===============2426951749013034805=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCHv2] sim: Use quoted string with AT+CRSM data parameter
Date: Thu, 22 Mar 2012 18:28:10 +0100
Message-ID: <1332437290-31190-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2426951749013034805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix issue with some modems preventing to update elementary files
(speedup, ZTE, huawei, MBM)
---
 drivers/atmodem/sim.c |  127 ++++++++++++++++-----------------------------=
----
 1 files changed, 41 insertions(+), 86 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8ee9822..a75d51f 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -298,71 +298,44 @@ static void at_crsm_update_cb(gboolean ok, GAtResult =
*result,
 	cb(&error, cbd->data);
 }
 =

-static void at_sim_update_binary(struct ofono_sim *sim, int fileid,
-					int start, int length,
-					const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
-{
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
-	int len, ret;
-
-	if (buf =3D=3D NULL)
-		goto error;
-
-	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
-			start >> 8, start & 0xff, length);
-
-	for (; length; length--)
-		len +=3D sprintf(buf + len, "%02hhX", *value++);
-
-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
-				at_crsm_update_cb, cbd, g_free);
-
-	g_free(buf);
-
-	if (ret > 0)
-		return;
-
-error:
-	g_free(cbd);
-
-	CALLBACK_WITH_FAILURE(cb, data);
-}
-
-static void at_sim_update_record(struct ofono_sim *sim, int fileid,
-					int record, int length,
-					const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
+static void at_sim_update_file(struct ofono_sim *sim, int cmd, int fileid,
+		int p1, int p2, int p3, const unsigned char *value,
+		ofono_sim_write_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char *buf;
+	char *quote =3D "";
 	int len, ret;
-	int size =3D 36 + length * 2;
+	int size =3D 36 + p3 * 2;
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		size +=3D 2; /*Add quotes*/
+	DBG("");
+
+	/* Add quotes */
+	switch (sd->vendor) {
+	case OFONO_VENDOR_MBM:
+	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_HUAWEI:
+	case OFONO_VENDOR_SPEEDUP:
+		quote =3D "\"";
+		size +=3D 2;
+		break;
+	}
 =

 	buf =3D g_try_new(char, size);
 	if (buf =3D=3D NULL)
 		goto error;
 =

-	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
-			record, length);
+	len =3D sprintf(buf, "AT+CRSM=3D%i,%i,%i,%i,%i,%s", cmd, fileid,
+			p1, p2, p3, quote);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		len +=3D sprintf(buf + len, "\"");
-
-	for (; length; length--)
+	for (; p3; p3--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		sprintf(buf + len, "\"");
+	sprintf(buf + len, "%s", quote);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
-				at_crsm_update_cb, cbd, g_free);
+			at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
 =

@@ -375,46 +348,28 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_sim_update_cyclic(struct ofono_sim *sim, int fileid,
-					int length, const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
+static void at_sim_update_binary(struct ofono_sim *sim, int fileid,
+		int start, int length, const unsigned char *value,
+		ofono_sim_write_cb_t cb, void *data)
 {
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf;
-	int len, ret;
-	int size =3D 36 + length * 2;
-
-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		size +=3D 2; /* Add quotes */
-
-	buf =3D g_try_new(char, size);
-	if (buf =3D=3D NULL)
-		goto error;
-
-	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
-
-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		len +=3D sprintf(buf + len, "\"");
-
-	for (; length; length--)
-		len +=3D sprintf(buf + len, "%02hhX", *value++);
-
-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
-		sprintf(buf + len, "\"");
-
-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
-				at_crsm_update_cb, cbd, g_free);
-
-	g_free(buf);
-
-	if (ret > 0)
-		return;
+	at_sim_update_file(sim, 214, fileid, start >> 8, start & 0xff,
+			length, value, cb, data);
+}
 =

-error:
-	g_free(cbd);
+static void at_sim_update_record(struct ofono_sim *sim, int fileid,
+		int record, int length, const unsigned char *value,
+		ofono_sim_write_cb_t cb, void *data)
+{
+	at_sim_update_file(sim, 220, fileid, record, 4,
+			length, value, cb, data);
+}
 =

-	CALLBACK_WITH_FAILURE(cb, data);
+static void at_sim_update_cyclic(struct ofono_sim *sim, int fileid,
+		int length, const unsigned char *value,
+		ofono_sim_write_cb_t cb, void *data)
+{
+	at_sim_update_file(sim, 220, fileid, 0, 3,
+			length, value, cb, data);
 }
 =

 static void at_cimi_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.5.4


--===============2426951749013034805==--

