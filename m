Content-Type: multipart/mixed; boundary="===============5189183242952249052=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH] Add vendor quirk for SIMCOM
Date: Thu, 28 Feb 2013 19:43:35 +0400
Message-ID: <1362066215-27452-2-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1362066215-27452-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5189183242952249052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

---
 drivers/atmodem/gprs-context.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 3694c27..c5a0ae7 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -208,7 +208,11 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		return;
 	}
 =

-	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+	if (gcd->vendor =3D=3D OFONO_VENDOR_SIMCOM) =

+		memcpy(buf, "ATD*99#", 7);
+	else
+		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+
 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				at_cgdata_cb, gc, NULL) > 0)
 		return;
-- =

1.7.10.4


--===============5189183242952249052==--

