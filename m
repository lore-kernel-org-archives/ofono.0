Content-Type: multipart/mixed; boundary="===============4252874752102352372=="
MIME-Version: 1.0
From: tournier.julien@gmail.com
Subject: [PATCH] fixing SMS notification parsing for some cinterion modem
Date: Tue, 28 Aug 2018 15:41:09 +0200
Message-ID: <20180828134109.28537-1-tournier.julien@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4252874752102352372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I've recently found a bug in the +CMT notification parsing on some cinterion
modems. Some of them (ALS3, PLS8, maybe others...) have a leading coma right
after "+CTM : ", before the PDU size, which makes the parser rejecting the
message since the PDU size is not found.

Please find attached my proposed patch.

---
 drivers/atmodem/sms.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 68b89862..d650c0f6 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -412,8 +412,21 @@ static void at_cmt_notify(GAtResult *result, gpointer =
user_data)
 =

 	switch (data->vendor) {
 	case OFONO_VENDOR_CINTERION:
-		if (!g_at_result_iter_next_number(&iter, &tpdu_len))
-			goto err;
+		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
+			/*
+			 * Can't get the PDU length, we need to skip
+			 * the leading coma for some modems (ALS3,PLS8...).
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
 		break;
 	default:
 		if (!g_at_result_iter_skip_next(&iter))
-- =

2.18.0


--===============4252874752102352372==--

