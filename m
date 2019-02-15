Content-Type: multipart/mixed; boundary="===============5740942475796466810=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 6/8] gprs-context : Force use of atd99
Date: Fri, 15 Feb 2019 14:11:40 +0200
Message-ID: <20190215121142.28163-7-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5740942475796466810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippe.deswert@digitalistgroup.com>

QUIRCK: For some reason I really need to force the use of the atd99 command=
 here.
---
 drivers/atmodem/gprs-context.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 93894efd..a0776f2a 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -214,7 +214,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		return;
 	}
 =

-	if (gcd->use_atd99)
+	if (gcd->use_atd99 || gcd->vendor =3D=3D OFONO_VENDOR_UBLOX)
 		sprintf(buf, "ATD*99***%u#", gcd->active_context);
 	else
 		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
@@ -457,6 +457,9 @@ static int at_gprs_context_probe(struct ofono_gprs_cont=
ext *gc,
 	case OFONO_VENDOR_SIMCOM_SIM900:
 		gcd->use_atd99 =3D FALSE;
 		break;
+	case OFONO_VENDOR_UBLOX:
+		gcd->use_atd99 =3D TRUE;
+		break;
 	default:
 		g_at_chat_send(chat, "AT+CGDATA=3D?", cgdata_prefix,
 						at_cgdata_test_cb, gc, NULL);
-- =

2.20.1


--===============5740942475796466810==--

