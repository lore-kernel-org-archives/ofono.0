Content-Type: multipart/mixed; boundary="===============7528035536077059020=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 4/8] gprs: add quirk for Telit modems
Date: Mon, 13 Aug 2012 15:22:28 +0200
Message-ID: <1344864148-23060-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7528035536077059020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit does not support AT+CGAUTO, use AT#AUTOATT=3D0 instead.
---
 drivers/atmodem/gprs.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 65a8b7b..f87548e 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -342,7 +342,13 @@ retry:
 		goto error;
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
+
+	/* Telit does not support AT+CGAUTO */
+	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT)
+		cmd =3D "AT#AUTOATT=3D0";
+	else
+		cmd =3D "AT+CGAUTO=3D0";
+	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_MBM:
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============7528035536077059020==--

