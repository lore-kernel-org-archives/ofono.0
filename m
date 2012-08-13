Content-Type: multipart/mixed; boundary="===============8168483579932669940=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 5/8] gprs-context: print reason for ppp disconnect
Date: Mon, 13 Aug 2012 15:22:42 +0200
Message-ID: <1344864162-23095-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8168483579932669940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 58a829b..3694c27 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -105,7 +105,7 @@ static void ppp_disconnect(GAtPPPDisconnectReason reaso=
n, gpointer user_data)
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

-	DBG("");
+	DBG("Reason: %d", reason);
 =

 	g_at_ppp_unref(gcd->ppp);
 	gcd->ppp =3D NULL;
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============8168483579932669940==--

