Content-Type: multipart/mixed; boundary="===============8252160513409511232=="
MIME-Version: 1.0
From: tournier.julien@gmail.com
Subject: [PATCH 0/1] atmodem: Handle broken +CMT notifications of some
 cinterion modems
Date: Wed, 29 Aug 2018 16:48:27 +0200
Message-ID: <20180829144827.4577-1-tournier.julien@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8252160513409511232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Julien Tournier <tournier.julien@gmail.com>

Hi Denis,

Here is the fixed patch for the +CMT notification parsing on some cinterion
modems that have a leading coma. I hope i took all your remarks into account


 drivers/atmodem/sms.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- =

2.18.0

From 937a78ccdac4975e1a292a8e9259060d2d94adc2 Mon Sep 17 00:00:00 2001
From: Julien Tournier <tournier.julien@gmail.com>
Date: Wed, 29 Aug 2018 15:55:58 +0200
Subject: [PATCH 1/1] atmodem: Handle broken +CMT notifications of some cint=
erion modems
---
 drivers/atmodem/sms.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 68b89862..9c920667 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -412,9 +412,24 @@ static void at_cmt_notify(GAtResult *result, gpointer =
user_data)
 =

 	switch (data->vendor) {
 	case OFONO_VENDOR_CINTERION:
-		if (!g_at_result_iter_next_number(&iter, &tpdu_len))
-			goto err;
-		break;
+		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
+			/*
+			 * On some cinterions modems (ALS3,PLS8...), we can't directly
+			 * get the PDU length, we need to skip the leading coma
+			 *  \r\n+CMT: ,23\r\nCAFECAFECAFE... ...\r\n
+			 *             ^------- PDU length
+			 */
+			DBG("Retrying to find the PDU length");
+
+			if (!g_at_result_iter_skip_next(&iter))
+				goto err;
+
+			/* Next attempt at finding the PDU length. */
+			if (!g_at_result_iter_next_number(&iter, &tpdu_len))
+				goto err;
+		}
+
+ 		break;
 	default:
 		if (!g_at_result_iter_skip_next(&iter))
 			goto err;
-- =

2.18.0


--===============8252160513409511232==--

