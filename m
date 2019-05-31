Content-Type: multipart/mixed; boundary="===============0769405093032906028=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 4/4] atmodem: Use atd99 as ppp command for ublox
Date: Fri, 31 May 2019 14:44:21 +0300
Message-ID: <20190531114421.21092-5-philippe.deswert@digitalistgroup.com>
In-Reply-To: <20190531114421.21092-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0769405093032906028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Seems a number of ublox modems (unlike specified) do not support
the AT+CGDATA command. So let's use atd99 instead which does seem to work.
---
 drivers/atmodem/gprs-context.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 4e623a63..989a47e2 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -447,15 +447,18 @@ static int at_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 =

 	ofono_gprs_context_set_data(gc, gcd);
 =

-	chat =3D g_at_chat_get_slave(gcd->chat);
-	if (chat =3D=3D NULL)
-		return 0;
-
 	switch (vendor) {
 	case OFONO_VENDOR_SIMCOM_SIM900:
 		gcd->use_atd99 =3D FALSE;
 		break;
+	case OFONO_VENDOR_UBLOX:
+		DBG("Setting atd99 use for UBLOX");
+		gcd->use_atd99 =3D TRUE;
+		break;
 	default:
+		chat =3D g_at_chat_get_slave(gcd->chat);
+		if (chat =3D=3D NULL)
+			return 0;
 		g_at_chat_send(chat, "AT+CGDATA=3D?", cgdata_prefix,
 						at_cgdata_test_cb, gc, NULL);
 	}
-- =

2.20.1


--===============0769405093032906028==--

