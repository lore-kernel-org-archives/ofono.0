Content-Type: multipart/mixed; boundary="===============6484609694119877645=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 2/3] atmodem: add a huawei hack to check attachment status
Date: Fri, 23 Apr 2010 16:40:20 +0300
Message-ID: <20100423134020.2107.54598.stgit@potku.valot.fi>
In-Reply-To: <20100423133926.2107.66535.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6484609694119877645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei doesn't seem to send CGREG notifications (or I wasn't able to
properly configure the modem to do it), so add an ugly to hack poll the
state with CGATT.
---

 drivers/atmodem/gprs.c |   51 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 052417a..41dced2 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -43,13 +43,17 @@
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *cgatt_prefix[] =3D { "+CGATT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	guint cgatt_timer;
 };
 =

+static void at_poll_cgatt(struct ofono_gprs *grps);
+
 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -165,6 +169,50 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 	}
 }
 =

+
+static gboolean at_poll_cgatt_timeout(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+
+	at_poll_cgatt(gprs);
+
+	return FALSE;
+}
+
+static void at_poll_cgatt_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+	int status;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGATT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	if (status > 0) {
+		ofono_gprs_status_notify(gprs, status);
+		return;
+	}
+
+	gd->cgatt_timer =3D g_timeout_add(1000, at_poll_cgatt_timeout, gprs);
+}
+
+static void at_poll_cgatt(struct ofono_gprs *gprs)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	g_at_chat_send(gd->chat, "AT+CGATT?", cgatt_prefix, at_poll_cgatt_cb,
+		       gprs, NULL);
+}
+
 static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -175,6 +223,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 				FALSE, gprs, NULL);
 =

 	ofono_gprs_register(gprs);
+
+	at_poll_cgatt(gprs);
 }
 =

 static void at_cgreg_test_cb(gboolean ok, GAtResult *result,
@@ -310,6 +360,7 @@ static void at_gprs_remove(struct ofono_gprs *gprs)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

+	g_source_remove(gd->cgatt_timer);
 	ofono_gprs_set_data(gprs, NULL);
 	g_free(gd);
 }


--===============6484609694119877645==--

