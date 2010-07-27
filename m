Content-Type: multipart/mixed; boundary="===============3476374905161897689=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 10:39:31 +0800
Message-ID: <1280198371-2401-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3476374905161897689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei modem closes the modem port after PPP disconnect. So the channel
of gatchat is NULL in ppp_disconnect. In such case, we should not resume
the chat and call disconnect function when removing the context.
Secondly, before removing the gprs context, we should reply the pending
DBus message to the client.
---
 drivers/atmodem/gprs-context.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index fea80b0..e2f291a 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -88,11 +88,22 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtIO *io =3D g_at_chat_get_io(gcd->chat);
 =

 	DBG("");
 =

 	g_at_ppp_unref(gcd->ppp);
 	gcd->ppp =3D NULL;
+
+	if (g_at_io_get_channel(io) =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
+					NULL, NULL, NULL, gcd->cb_data);
+		gcd->active_context =3D 0;
+		gcd->state =3D STATE_IDLE;
+		g_at_chat_resume(gcd->chat);
+		return;
+	}
+
 	g_at_chat_resume(gcd->chat);
 =

 	switch (gcd->state) {
@@ -257,7 +268,7 @@ static void at_gprs_context_remove(struct ofono_gprs_co=
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


--===============3476374905161897689==--

