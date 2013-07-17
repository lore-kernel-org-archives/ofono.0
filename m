Content-Type: multipart/mixed; boundary="===============7145287947116551745=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH 2/3] atmodem: Add gprs-context quirk for SIM900
Date: Wed, 17 Jul 2013 09:14:14 +0200
Message-ID: <1374045255-26600-3-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374045255-26600-2-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7145287947116551745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SIM900 module from SIMCOM does have a AT+CGDATA command.
However, it is not possible to make a ppp connection when CGDATA
has been used to bring up the gprs context.

This patch ads a quirk that uses the alternative ATD*99***<cid>#
command instead.
---
 drivers/atmodem/gprs-context.c |    8 ++++++--
 drivers/atmodem/vendor.h       |    1 +
 plugins/sim900.c               |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 3694c27..f46d881 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -208,8 +208,12 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		return;
 	}
 =

-	sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+        if (gcd->vendor =3D=3D OFONO_VENDOR_SIMCOM_SIM900)
+		sprintf(buf, "ATD*99***%u#", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
+
+        if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				at_cgdata_cb, gc, NULL) > 0)
 		return;
 =

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 0532d10..2b1a567 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -39,6 +39,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_SPEEDUP,
 	OFONO_VENDOR_SAMSUNG,
 	OFONO_VENDOR_SIMCOM,
+        OFONO_VENDOR_SIMCOM_SIM900,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL
diff --git a/plugins/sim900.c b/plugins/sim900.c
index 643de51..3b4fd84 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -361,7 +361,7 @@ static void sim900_post_sim(struct ofono_modem *modem)
 	if (gprs =3D=3D NULL)
 		return;
 =

-	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
 					"atmodem", data->dlcs[GPRS_DLC]);
 	if (gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

1.7.10.4


--===============7145287947116551745==--

