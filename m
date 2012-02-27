Content-Type: multipart/mixed; boundary="===============2604027531290092437=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH 2/2] sim900: Disable sending AT+CNMA
Date: Mon, 27 Feb 2012 11:19:44 +0400
Message-ID: <1330327184-1497-2-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1330327184-1497-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2604027531290092437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

 SIMCOM SIM900 modem module not support AT+CNMA command
 =

---
 drivers/atmodem/sms.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c6fb8c4..c31eb39 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -389,6 +389,7 @@ static void at_cds_notify(GAtResult *result, gpointer u=
ser_data)
 static void at_cmt_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
 	const char *hexpdu;
 	long pdu_len;
 	int tpdu_len;
@@ -409,7 +410,8 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
 	ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
 =

-	at_ack_delivery(sms);
+	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
+		at_ack_delivery(sms);
 }
 =

 static void at_cmgr_notify(GAtResult *result, gpointer user_data)
-- =

1.7.7.3


--===============2604027531290092437==--

