Content-Type: multipart/mixed; boundary="===============1954763874617899551=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 06/11] stk: Add 'ofono_stk_deactivate_context_cb' definition
Date: Mon, 04 Jul 2011 18:06:37 +0200
Message-ID: <1309795602-26046-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1954763874617899551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 1e4d237..58fdbdf 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -512,6 +512,24 @@ static void cancel_pending_dtmf(struct ofono_stk *stk)
 =

 static void ofono_stk_deactivate_context_cb(int error, void *data)
 {
+	struct ofono_stk *stk =3D data;
+
+	DBG("");
+
+	if (stk->pending_cmd && stk->pending_cmd->type =3D=3D
+			STK_COMMAND_TYPE_CLOSE_CHANNEL) {
+		stk->bip.channel.status =3D
+				STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+
+		if (error < 0)
+			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+		else
+			send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+	} else {
+		/* TODO send channel status event */
+	}
+
+	stk->bip.channel.id =3D 0;
 }
 =

 static void stk_close_channel(struct ofono_stk *stk)
-- =

1.7.1


--===============1954763874617899551==--

