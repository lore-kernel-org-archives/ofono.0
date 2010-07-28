Content-Type: multipart/mixed; boundary="===============0960333883405772072=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH v3] Fix busylooped in ppp_disconnect for huawei modem
Date: Wed, 28 Jul 2010 08:25:26 +0800
Message-ID: <1280276726-17360-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0960333883405772072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei modem closes the modem port after PPP disconnect. So the channel
of gatchat is NULL in ppp_disconnect. In such case, we resume the chat
and it causes huawei_disconnect() get called and the gprs context is
removed later.

Before removing this gprs context, we should reply the pending DBus
message to the client.
---
 drivers/atmodem/gprs-context.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index fea80b0..6589560 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -93,7 +93,6 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason,=
 gpointer user_data)
 =

 	g_at_ppp_unref(gcd->ppp);
 	gcd->ppp =3D NULL;
-	g_at_chat_resume(gcd->chat);
 =

 	switch (gcd->state) {
 	case STATE_ENABLING:
@@ -110,6 +109,12 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
+	/*
+	 * If the channel of gcd->chat is NULL, it might cause
+	 * gprs_context_remove get called and the gprs context will be
+	 * removed.
+	 */
+	g_at_chat_resume(gcd->chat);
 }
 =

 static gboolean setup_ppp(struct ofono_gprs_context *gc)
@@ -257,7 +262,7 @@ static void at_gprs_context_remove(struct ofono_gprs_co=
ntext *gc)
 =

 	DBG("");
 =

-	if (gcd->state !=3D STATE_IDLE) {
+	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
 		g_at_ppp_unref(gcd->ppp);
 		g_at_chat_resume(gcd->chat);
 	}
-- =

1.7.0.4


--===============0960333883405772072==--

