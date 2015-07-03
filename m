Content-Type: multipart/mixed; boundary="===============3345718588030495290=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: [PATCH] Handle NW DETACH and ME DETACH
Date: Fri, 03 Jul 2015 10:43:34 +0200
Message-ID: <1435913014-22733-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3345718588030495290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

 * According to the Telit AT reference, NW DETACH and ME DETACH
   imply network deactivation.
 * Handle in drivers/atmodem/gprs-context.c, function cgev_notify.
---
 drivers/atmodem/gprs-context.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 7e9a43c..db32b17 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -360,20 +360,24 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 =

-	if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE &&
+	if (g_str_has_prefix(event, "NW DETACH") =3D=3D FALSE &&
+			g_str_has_prefix(event, "ME DETACH") =3D=3D FALSE) {
+
+		if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE &&
 				g_str_has_prefix(event, "ME DEACT") =3D=3D FALSE)
-		return;
+			return;
 =

-	if (!g_at_result_iter_skip_next(&iter))
-		return;
+		if (!g_at_result_iter_skip_next(&iter))
+			return;
 =

-	if (!g_at_result_iter_next_number(&iter, &cid))
-		return;
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			return;
 =

-	DBG("cid %d", cid);
+		DBG("cid %d", cid);
 =

-	if ((unsigned int) cid !=3D gcd->active_context)
-		return;
+		if ((unsigned int) cid !=3D gcd->active_context)
+			return;
+	}
 =

 	if (gcd->state !=3D STATE_IDLE && gcd->ppp)
 		g_at_ppp_shutdown(gcd->ppp);
-- =

2.1.0


--===============3345718588030495290==--

