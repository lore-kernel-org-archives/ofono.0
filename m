Content-Type: multipart/mixed; boundary="===============1955483400348668740=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] gprs: skip CGAUTO for telit
Date: Thu, 16 Aug 2012 11:33:49 +0200
Message-ID: <1345109629-29468-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <502902F0.8010008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1955483400348668740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit does not support +CGAUTO and will just return an error.
To not confuse people reading the debug output, don't send the command
for telit.
---
 drivers/atmodem/gprs.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 65a8b7b..4e0823c 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -342,7 +342,11 @@ retry:
 		goto error;
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
+
+	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT)
+		DBG("Telit does not support +CGAUTO command.");
+	else
+		g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_MBM:
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============1955483400348668740==--

