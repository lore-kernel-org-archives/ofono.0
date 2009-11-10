Content-Type: multipart/mixed; boundary="===============5206493646072499140=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Don't give up netreg init if generic CellID reporting is not
 supported.
Date: Tue, 10 Nov 2009 07:29:56 +0100
Message-ID: <1257834596-22380-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206493646072499140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c                 |   57 ++++++++++++++++++++++++++++=
+--
 drivers/atmodem/network-registration.c |   56 ++++++++++++++++++++++++++++=
+--
 2 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 6f4933a..242086c 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -216,6 +216,57 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	ofono_gprs_register(gprs);
 }
 =

+static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	gint range[2];
+	GAtResultIter iter;
+	int cgreg1 =3D 0;
+	int cgreg2 =3D 0;
+	const char *cmd;
+
+	dump_response("cgreg_read_cb", ok, result);
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGREG:"))
+		goto error;
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto error;
+
+	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
+		if (1 >=3D range[0] && 1 <=3D range[1])
+			cgreg1 =3D 1;
+		if (2 >=3D range[0] && 2 <=3D range[1])
+			cgreg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+	if (cgreg2)
+		cmd =3D "AT+CGREG=3D2";
+	else if (cgreg1)
+		cmd =3D "AT+CGREG=3D1";
+	else
+		goto error;
+
+	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
+			gprs_initialized, gprs, NULL);
+	return;
+
+error:
+	ofono_info("GPRS not supported on this device");
+	ofono_gprs_remove(gprs);
+}
+
 static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -262,10 +313,8 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult =
*result,
 =

 	ofono_gprs_set_cid_range(gprs, min, max);
 =

-	g_at_chat_send(gd->chat, "AT+CGREG=3D2", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
-			gprs_initialized, gprs, NULL);
+	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
+			at_cgreg_test_cb, gprs, NULL);
 =

 	return;
 =

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index d129861..1b67ad8 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -637,6 +637,56 @@ static void at_network_registration_initialized(gboole=
an ok, GAtResult *result,
 	ofono_netreg_register(netreg);
 }
 =

+static void at_creg_test_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	gint range[2];
+	GAtResultIter iter;
+	int creg1 =3D 0;
+	int creg2 =3D 0;
+
+	dump_response("creg_read_cb", ok, result);
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CREG:"))
+		goto error;
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto error;
+
+	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
+		if (1 >=3D range[0] && 1 <=3D range[1])
+			creg1 =3D 1;
+		if (2 >=3D range[0] && 2 <=3D range[1])
+			creg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+	if (creg2) {
+		g_at_chat_send(nd->chat, "AT+CREG=3D2", none_prefix,
+				at_network_registration_initialized,
+				netreg, NULL);
+		return;
+	}
+
+	if (creg1) {
+		g_at_chat_send(nd->chat, "AT+CREG=3D1", none_prefix,
+				at_network_registration_initialized,
+				netreg, NULL);
+		return;
+	}
+
+error:
+	ofono_error("Unable to initialize Network Registration");
+	ofono_netreg_remove(netreg);
+}
+
 static int at_netreg_probe(struct ofono_netreg *netreg, unsigned int vendo=
r,
 				void *data)
 {
@@ -652,9 +702,9 @@ static int at_netreg_probe(struct ofono_netreg *netreg,=
 unsigned int vendor,
 	if (nd->vendor =3D=3D OFONO_VENDOR_CALYPSO)
 		g_at_chat_send(chat, "AT%CSQ=3D1", NULL, NULL, NULL, NULL);
 =

-	g_at_chat_send(chat, "AT+CREG=3D2", NULL,
-				at_network_registration_initialized,
-				netreg, NULL);
+	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
+			at_creg_test_cb, netreg, NULL);
+
 	return 0;
 }
 =

-- =

1.6.1


--===============5206493646072499140==--

