Content-Type: multipart/mixed; boundary="===============0300156379400291095=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 6/6] atmodem: packet switch bearer support
Date: Thu, 13 Jan 2011 12:49:41 +0200
Message-ID: <1294915781-8330-6-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294915781-8330-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0300156379400291095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index defb154..daa3933 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -200,6 +200,37 @@ static void xdatastat_notify(GAtResult *result, gpoint=
er user_data)
 	}
 }
 =

+static void cpsb_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPSB:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, NULL))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &bearer))
+		return;
+
+	ofono_gprs_bearer_notify(gprs, bearer);
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
+}
+
 static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -208,6 +239,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
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


--===============0300156379400291095==--

