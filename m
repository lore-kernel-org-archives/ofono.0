Content-Type: multipart/mixed; boundary="===============8370959458301575413=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] calypsomodem: Notify core about commands handled in modem.
Date: Tue, 26 Oct 2010 10:52:06 +0200
Message-ID: <1288083128-24058-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1288083128-24058-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8370959458301575413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/calypsomodem/stk.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 052e1f9..7168fb0 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -209,13 +209,34 @@ static void sata_notify(GAtResult *result, gpointer u=
ser_data)
 =

 static void satn_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_stk *stk =3D user_data;
+	GAtResultIter iter;
+	const guint8 *pdu;
+	gint len;
+	gboolean ret;
+
 	DBG("");
 =

+	/* Proactive command has been handled by the modem.  */
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "%SATN:"))
+		return;
+
+	ret =3D g_at_result_iter_next_hexstring(&iter, &pdu, &len);
+	if (!ret || len =3D=3D 0)
+		return;
+
 	/*
-	 * Proactive command has been handled by the modem.  Should
-	 * the core be notified?  For now we just ignore it because
-	 * we must not respond to the command.
+	 * A proactive command starts with a Proactive UICC Command BER-TLV
+	 * short tag (0xd0) with optional pad bytes, a Terminal Response
+	 * starts with the Command Details CTLV tag (0x81).
 	 */
+	if (pdu[0] !=3D 0x81)
+		ofono_stk_proactive_command_handled_notify(stk, len, pdu);
+	else
+		ofono_stk_terminal_response_sent_notify(stk, len, pdu);
 }
 =

 static void calypso_stk_register(gboolean ok, GAtResult *result,
-- =

1.7.1.86.g0e460.dirty


--===============8370959458301575413==--

