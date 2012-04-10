Content-Type: multipart/mixed; boundary="===============3475113710659301645=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/2] ussd: Fix speedup ussd encoding
Date: Tue, 10 Apr 2012 17:35:05 +0200
Message-ID: <1334072105-32105-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1334072105-32105-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3475113710659301645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Speedup dongles encode USSD strings in GSM7
packed, so we don't have to pack it ourselves.
---
 drivers/atmodem/ussd.c |   13 ++++++++++---
 plugins/speedup.c      |    2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index f5b38e2..e90db11 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -136,9 +136,15 @@ static void cusd_parse(GAtResult *result, struct ofono=
_ussd *ussd)
 	case SMS_CHARSET_7BIT:
 		switch (data->charset) {
 		case AT_UTIL_CHARSET_GSM:
-			msg_ptr =3D pack_7bit_own_buf((const guint8 *) content,
-							-1, 0, TRUE, &msg_len,
-							0, msg);
+			if (data->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
+				msg_ptr =3D decode_hex_own_buf(content, -1,
+								&msg_len,
+								0, msg);
+			else
+				msg_ptr =3D pack_7bit_own_buf((const guint8 *)
+								content, -1, 0,
+								TRUE, &msg_len,
+								0, msg);
 			break;
 =

 		case AT_UTIL_CHARSET_UTF8:
@@ -242,6 +248,7 @@ static void cusd_cancel_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	switch (data->vendor) {
 	case OFONO_VENDOR_GOBI:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_SPEEDUP:
 		/* All errors and notifications arrive unexpected and
 		 * thus just reset the state here. This is safer than
 		 * getting stuck in a dead-lock. */
diff --git a/plugins/speedup.c b/plugins/speedup.c
index ca6ed13..5cc380f 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -282,7 +282,7 @@ static void speedup_post_online(struct ofono_modem *mod=
em)
 =

 	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->aux);
-	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+	ofono_ussd_create(modem, OFONO_VENDOR_SPEEDUP,
 						"atmodem", data->aux);
 }
 =

-- =

1.7.5.4


--===============3475113710659301645==--

