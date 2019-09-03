Content-Type: multipart/mixed; boundary="===============2413916526126160774=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: gprs: React on context deactivation
Date: Tue, 03 Sep 2019 16:06:11 +0200
Message-ID: <20190903140611.1264-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2413916526126160774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In case a context get deactivated when a AT+CGACT=3D0 is
not issued, indicate that to gprs core.
This can happen if the device has an auto activated
LTE context and modem switches over to for instance UTRAN.
---
 drivers/ubloxmodem/gprs-context.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index ff78a42a..188c2c62 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -40,6 +40,8 @@
 =

 #include "ubloxmodem.h"
 =

+#define UBLOX_FLAG_DEACTIVATING 0x01
+
 static const char *none_prefix[] =3D { NULL };
 static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
 static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
@@ -57,6 +59,7 @@ struct gprs_context_data {
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
 	enum netmode networking_mode;
+	int flags;
 };
 =

 static void uipaddr_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -426,6 +429,8 @@ static void cgact_disable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	DBG("ok %d", ok);
 =

+	gcd->flags &=3D ~UBLOX_FLAG_DEACTIVATING;
+
 	if (!ok) {
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 		return;
@@ -448,6 +453,8 @@ static void ublox_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
 =

+	gcd->flags |=3D UBLOX_FLAG_DEACTIVATING;
+
 	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", gcd->active_context);
 	g_at_chat_send(gcd->chat, buf, none_prefix,
 			cgact_disable_cb, gc, NULL);
@@ -473,10 +480,16 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 		sscanf(event, "%*s %*s %*s %u", &cid);
 	else if (g_str_has_prefix(event, "NW DEACT"))
 		sscanf(event, "%*s %*s %u", &cid);
+	else if (!(gcd->flags & UBLOX_FLAG_DEACTIVATING) &&
+		 g_str_has_prefix(event, "ME PDN DEACT"))
+		/* The modem might consider the ME deactivating without
+		 * an explicit CGACT=3D0 beeing sent
+		 */
+		sscanf(event, "%*s %*s %*s %u", &cid);
 	else
 		return;
 =

-	DBG("cid %d", cid);
+	DBG("cid %d, active cid: %d", cid, gcd->active_context);
 =

 	if ((unsigned int) cid !=3D gcd->active_context)
 		return;
-- =

2.20.1


--===============2413916526126160774==--

