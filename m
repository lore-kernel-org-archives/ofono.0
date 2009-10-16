Content-Type: multipart/mixed; boundary="===============3729161455745356070=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Free converted string after use.
Date: Fri, 16 Oct 2009 19:44:36 +0200
Message-ID: <1255715076-3776-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3729161455745356070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also make sure we don't read beyond end of the string.
---
 drivers/atmodem/ussd.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index c29f8f6..1d819a3 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -59,7 +59,7 @@ static void at_ussd_request(struct ofono_ussd *ussd, cons=
t char *str,
 {
 	GAtChat *chat =3D ofono_ussd_get_data(ussd);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	unsigned char *converted;
+	unsigned char *converted =3D NULL;
 	int dcs;
 	int max_len;
 	long written;
@@ -83,7 +83,10 @@ static void at_ussd_request(struct ofono_ussd *ussd, con=
st char *str,
 	if (written > max_len)
 		goto error;
 =

-	sprintf(buf, "AT+CUSD=3D1,\"%s\",%d", converted, dcs);
+	sprintf(buf, "AT+CUSD=3D1,\"%*s\",%d", (int) written, converted, dcs);
+
+	g_free(converted);
+	converted =3D NULL;
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				cusd_request_cb, cbd, g_free) > 0)
@@ -92,6 +95,8 @@ static void at_ussd_request(struct ofono_ussd *ussd, cons=
t char *str,
 error:
 	if (cbd)
 		g_free(cbd);
+	if (converted)
+		g_free(converted);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
 }
-- =

1.6.1


--===============3729161455745356070==--

