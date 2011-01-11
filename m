Content-Type: multipart/mixed; boundary="===============4548181675233160897=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 11/11] atmodem: packet switch bearer support
Date: Tue, 11 Jan 2011 16:08:39 +0200
Message-ID: <1294754919-9687-11-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4548181675233160897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |   55 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index a38c6b4..4ae1b57 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -200,6 +200,59 @@ static void xdatastat_notify(GAtResult *result, gpoint=
er user_data)
 	}
 }
 =

+static void cpsb_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint cid, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPSB:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &cid))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &bearer))
+		return;
+
+	ofono_gprs_bearer_notify(gprs, cid, bearer);
+}
+
+static void cpsb_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint cid, bearer;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPSB:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, NULL);
+
+	while (g_at_result_iter_next_number(&iter, &cid) &&
+			g_at_result_iter_next_number(&iter, &bearer))
+		ofono_gprs_bearer_notify(gprs, cid, bearer);
+}
+
+static void cpsb_set_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (!ok)
+		return;
+
+	g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify, FALSE, gprs, NULL);
+	g_at_chat_send(gd->chat, "AT+CPSB?", none_prefix, cpsb_cb, gprs, NULL);
+}
+
 static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -208,6 +261,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
 	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
 					FALSE, gprs, NULL);
+	g_at_chat_send(gd->chat, "AT+CPSB=3D1", none_prefix,
+		cpsb_set_cb, gprs, NULL);
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_IFX:
-- =

1.7.1


--===============4548181675233160897==--

