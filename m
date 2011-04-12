Content-Type: multipart/mixed; boundary="===============9163082898076209797=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: fix call_create_resp handling
Date: Tue, 12 Apr 2011 17:33:29 +0300
Message-ID: <1302618809-26929-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9163082898076209797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

In case of call creation failure modem may return a valid call id in
order to send CALL_SERVICE_DENIED_IND which we do not handle.

Fixes MeeGo bug#15855.
---
 drivers/isimodem/voicecall.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 2cbd046..121cad6 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -574,15 +574,42 @@ static void isi_call_create_resp(const GIsiMessage *m=
sg, void *data)
 {
 	struct isi_call_req_ctx *irc =3D data;
 	uint8_t call_id;
-
-	if (!check_response_status(msg, CALL_CREATE_RESP) ||
-			!g_isi_msg_data_get_byte(msg, 0, &call_id) ||
-			call_id =3D=3D CALL_ID_NONE) {
-		isi_ctx_return_failure(irc);
-		return;
+	uint8_t subblocks;
+
+	if (!check_response_status(msg, CALL_CREATE_RESP))
+		goto failure;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &call_id) ||
+			call_id =3D=3D CALL_ID_NONE)
+		goto failure;
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &subblocks))
+		goto failure;
+
+	if (subblocks !=3D 0) {
+		GIsiSubBlockIter iter;
+		struct isi_call call =3D { 0 };
+
+		for (g_isi_sb_iter_init(&iter, msg, 2);
+				g_isi_sb_iter_is_valid(&iter);
+				g_isi_sb_iter_next(&iter)) {
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case CALL_CAUSE:
+				isi_call_cause_sb_proc(NULL, &call, &iter);
+				DBG("CALL_CREATE_RESP "
+					"cause_type=3D0x%02x cause=3D0x%02x",
+					call.cause_type, call.cause);
+				goto failure;
+			}
+		}
 	}
 =

 	isi_ctx_return_success(irc);
+	return;
+
+failure:
+	isi_ctx_return_failure(irc);
 }
 =

 static struct isi_call_req_ctx *isi_modem_call_create_req(
-- =

1.7.1


--===============9163082898076209797==--

