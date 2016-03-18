Content-Type: multipart/mixed; boundary="===============1179265240378064867=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 4/5] atmodem: gprs: handle automatic context activation
Date: Fri, 18 Mar 2016 12:58:53 +0100
Message-ID: <1458302334-6149-5-git-send-email-dragos@endocode.com>
In-Reply-To: <1458302334-6149-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1179265240378064867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the event comes, trigger CGCONT? to read the APN for the
activated cid and then call ogono_gprs_cid_activated to handle
the event.
---
 drivers/atmodem/gprs.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 4505477..bc3c633 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -49,6 +49,7 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	unsigned int last_auto_context_id;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -141,6 +142,49 @@ static void at_gprs_registration_status(struct ofono_g=
prs *gprs,
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int activated_cid =3D gd->last_auto_context_id;
+	const char *apn =3D NULL;
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_warn("Can't read CGDCONT contexts.");
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		int read_cid;
+
+		if (!g_at_result_iter_next_number(&iter, &read_cid))
+			break;
+
+		if (read_cid !=3D activated_cid)
+			continue;
+
+		/* ignore protocol */
+		g_at_result_iter_skip_next(&iter);
+
+		g_at_result_iter_next_string(&iter, &apn);
+
+		break;
+	}
+
+	if (apn)
+		ofono_gprs_cid_activated(gprs, activated_cid, apn);
+	else
+		ofono_warn("cid %u: Received activated but no apn present",
+				activated_cid);
+}
+
+
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -157,6 +201,7 @@ static void cgreg_notify(GAtResult *result, gpointer us=
er_data)
 static void cgev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	GAtResultIter iter;
 	const char *event;
 =

@@ -172,6 +217,11 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 			g_str_equal(event, "ME DETACH")) {
 		ofono_gprs_detached_notify(gprs);
 		return;
+	} else if (g_str_has_prefix(event, "ME PDN ACT")) {
+		sscanf(event, "%*s %*s %*s %u", &gd->last_auto_context_id);
+
+		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
+				at_cgdcont_read_cb, gprs, NULL);
 	}
 }
 =

-- =

2.5.0


--===============1179265240378064867==--

