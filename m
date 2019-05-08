Content-Type: multipart/mixed; boundary="===============1601818373371418537=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] atmodem: Fix a race if a context get deactivated while read
Date: Wed, 08 May 2019 09:27:56 +0200
Message-ID: <20190508072756.6093-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1601818373371418537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

When a context gets activated we read its settings, but
if the context gets deactivated during this time we should
not indicate that the context is activated when the settings
are received.
---
 drivers/atmodem/gprs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index d3fd893c..dd734585 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -161,6 +161,11 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult =
*result,
 		return;
 	}
 =

+	if (gd->last_auto_context_id =3D=3D 0) {
+		DBG("Context got deactivated while calling CGDCONT");
+		return;
+	}
+
 	g_at_result_iter_init(&iter, result);
 =

 	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
@@ -251,6 +256,12 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 =

 		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
 				at_cgdcont_read_cb, gprs, NULL);
+	} else if (g_str_has_prefix(event, "ME PDN DEACT")) {
+		unsigned int context_id;
+		sscanf(event, "%*s %*s %*s %u", &context_id);
+		/* Indicate that this cid is not activated anymore */
+		if (gd->last_auto_context_id =3D=3D context_id)
+			gd->last_auto_context_id =3D 0;
 	}
 }
 =

-- =

2.20.1


--===============1601818373371418537==--

