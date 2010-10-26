Content-Type: multipart/mixed; boundary="===============2841791575846026689=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] ifxmodem: Notify core about commands handled in modem.
Date: Tue, 26 Oct 2010 10:52:08 +0200
Message-ID: <1288083128-24058-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1288083128-24058-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2841791575846026689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/stk.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index a7ca089..3b620a4 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -197,6 +197,7 @@ static void sati_notify(GAtResult *result, gpointer use=
r_data)
 =

 static void satn_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_stk *stk =3D user_data;
 	GAtResultIter iter;
 	const guint8 *pdu;
 	gint len;
@@ -217,6 +218,19 @@ static void satn_notify(GAtResult *result, gpointer us=
er_data)
 	 * command was for Setup Call then a response with AT+SATD
 	 * is required.  This is not handled properly yet.
 	 */
+
+	if (len =3D=3D 0)
+		return;
+
+	/*
+	 * A proactive command starts with a Proactive UICC Command BER-TLV
+	 * short tag (0xd0) with optional pad bytes, a Terminal Response
+	 * starts with the Command Details CTLV tag (0x81).
+	 */
+	if (pdu[0] !=3D 0x81)
+		ofono_stk_proactive_command_handled_notify(stk, len, pdu);
+	else
+		ofono_stk_terminal_response_sent_notify(stk, len, pdu);
 }
 =

 static void satf_notify(GAtResult *result, gpointer user_data)
-- =

1.7.1.86.g0e460.dirty


--===============2841791575846026689==--

