Content-Type: multipart/mixed; boundary="===============1671187576636530571=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v3 2/2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 18:31:40 +0300
Message-ID: <20100526153140.2330.54624.stgit@potku.valot.fi>
In-Reply-To: <20100526153134.2330.70055.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1671187576636530571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ofono either crashed or busy looped with my Huawei E1552 3G modem when I
tried to deactivate GPRS context. The reason was that gcd->chat was
unreferenced already in setup_ppp() but the chat was still accessed
later in at_gprs_deactivate_primary().

To fix the problem, change the logic instead to suspend chat session
for PPP and resume when PPP has disconnected. Now it doesn't crash
anymore.

Deactivation still doesn't work properly with Huawei E1552, and most
probably with other Huawei modems, because the modem hangs up the chat
line after PPP deactivation. This needs to be fixed separately. The
workaround is to reboot the modem, for example physically unplug and plug
it in again.
---

 drivers/atmodem/gprs-context.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 9b32d59..2b82d9c 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -90,6 +90,8 @@ static void ppp_disconnect(GAtPPPDisconnectReason reason,=
 gpointer user_data)
 =

 	DBG("");
 =

+	g_at_chat_resume(gcd->chat);
+
 	switch (gcd->state) {
 	case STATE_ENABLING:
 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
@@ -110,13 +112,14 @@ static void ppp_disconnect(GAtPPPDisconnectReason rea=
son, gpointer user_data)
 static gboolean setup_ppp(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	GIOChannel *channel;
+	GAtIO *io;
+
+	io =3D g_at_chat_get_io(gcd->chat);
 =

-	channel =3D g_at_chat_get_channel(gcd->chat);
-	g_at_chat_unref(gcd->chat);
+	g_at_chat_suspend(gcd->chat);
 =

 	/* open ppp */
-	gcd->ppp =3D g_at_ppp_new(channel);
+	gcd->ppp =3D g_at_ppp_new_from_io(io);
 =

 	if (gcd->ppp =3D=3D NULL)
 		return FALSE;


--===============1671187576636530571==--

