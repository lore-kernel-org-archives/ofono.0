Content-Type: multipart/mixed; boundary="===============8096657038101186817=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] atmodem: Check for auto activated contexts during init
Date: Wed, 24 Jul 2019 19:24:19 +0200
Message-ID: <20190724172419.29405-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8096657038101186817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

To detect if a context gets activated before we register
for unsolicited events we need to check if any is
already activated, and flag it auto activated.
---
 drivers/atmodem/gprs.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index fbee5c94..10108281 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -43,6 +43,7 @@
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
@@ -192,6 +193,48 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult =
*result,
 				activated_cid);
 }
 =

+static void at_cgact_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_warn("Can't read CGACT contexts.");
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGACT:")) {
+		int read_cid =3D -1;
+		int read_status =3D -1;
+
+		if (!g_at_result_iter_next_number(&iter, &read_cid))
+			break;
+
+		if (!g_at_result_iter_next_number(&iter, &read_status))
+			break;
+
+		if (read_status !=3D 1)
+			continue;
+
+		/* Flag this as auto context as it was obviously active */
+		if (gd->last_auto_context_id =3D=3D 0)
+			gd->last_auto_context_id =3D read_cid;
+
+		if (read_cid !=3D gd->last_auto_context_id)
+			continue;
+
+		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
+				at_cgdcont_read_cb, gprs, NULL);
+
+		break;
+	}
+}
+
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -495,6 +538,10 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		break;
 	}
 =

+	/* Check if there is any already activated contexts at init */
+	g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
+			at_cgact_cb, gprs, NULL);
+
 	ofono_gprs_register(gprs);
 }
 =

-- =

2.20.1


--===============8096657038101186817==--

