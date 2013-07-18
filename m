Content-Type: multipart/mixed; boundary="===============6243968449057996561=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH v2 2/3] atmodem: Add gprs-context quirk for SIM900
Date: Thu, 18 Jul 2013 09:49:57 +0200
Message-ID: <1374133798-20488-2-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374133798-20488-1-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6243968449057996561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SIM900 module from SIMCOM does have a AT+CGDATA command.
However, it is not possible to make a ppp connection when CGDATA
has been used to bring up the gprs context.

This patch adds a quirk that uses the alternative ATD*99***<cid>#
command instead.
---
 drivers/atmodem/gprs-context.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 3694c27..2217097 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -208,7 +208,11 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		return;
 	}
 =

-	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+	if (gcd->vendor =3D=3D OFONO_VENDOR_SIMCOM_SIM900)
+		sprintf(buf, "ATD*99***%u#", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+
 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				at_cgdata_cb, gc, NULL) > 0)
 		return;
-- =

1.7.10.4


--===============6243968449057996561==--

