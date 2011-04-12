Content-Type: multipart/mixed; boundary="===============3124715372864771928=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: notify sms-status-reports, too
Date: Tue, 12 Apr 2011 19:05:13 +0300
Message-ID: <1302624313-30069-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3124715372864771928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/sms.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 6f6b247..40dfa1d 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -564,6 +564,8 @@ static void routing_ntf_cb(const GIsiMessage *msg, void=
 *data)
 	GIsiSubBlockIter iter;
 =

 	uint8_t pdu[176];
+	uint8_t len;
+	uint8_t tp_mti;
 =

 	if (g_isi_msg_id(msg) !=3D SMS_PP_ROUTING_NTF)
 		return;
@@ -586,7 +588,14 @@ static void routing_ntf_cb(const GIsiMessage *msg, voi=
d *data)
 	memcpy(pdu, addr.data, addr.len);
 	memcpy(pdu + addr.len, tpdu.data, tpdu.len);
 =

-	ofono_sms_deliver_notify(sms, pdu, tpdu.len + addr.len, tpdu.len);
+	len =3D addr.len + tpdu.len;
+
+	tp_mti =3D pdu[addr.len] & 0x3;
+
+	if (tp_mti =3D=3D 0)
+		ofono_sms_deliver_notify(sms, pdu, len, tpdu.len);
+	else if (tp_mti =3D=3D 2)
+		ofono_sms_status_notify(sms, pdu, len, tpdu.len);
 =

 	/*
 	 * FIXME: We should not ack the DELIVER unless it has been
-- =

1.7.1


--===============3124715372864771928==--

