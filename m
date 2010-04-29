Content-Type: multipart/mixed; boundary="===============2328087390687004557=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] sim-poll: Count timeout from the moment STATUS is sent to
 modem.
Date: Thu, 29 Apr 2010 13:32:56 +0200
Message-ID: <1272540776-19115-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2328087390687004557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim-poll.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
index f1a83e3..6dd7d60 100644
--- a/drivers/atmodem/sim-poll.c
+++ b/drivers/atmodem/sim-poll.c
@@ -199,20 +199,27 @@ static void at_csim_status_cb(gboolean ok, GAtResult =
*result,
 	sim_fetch_command(spd, response[len - 1]);
 }
 =

-static gboolean sim_status_poll(gpointer user_data)
+static void at_csim_status_sent_cb(guint command_id, gpointer user_data)
 {
 	struct sim_poll_data *spd =3D user_data;
 =

-	spd->poll_timeout =3D 0;
-
 	/* The SIM must respond in a given time frame which is of at
 	 * least 5 seconds in TS 11.11.  */
 	spd->status_timeout =3D g_timeout_add_seconds(5,
 			sim_status_timeout, spd);
+}
+
+static gboolean sim_status_poll(gpointer user_data)
+{
+	struct sim_poll_data *spd =3D user_data;
+
+	spd->poll_timeout =3D 0;
+	spd->status_timeout =3D -1;
 =

 	/* Send STATUS */
-	spd->status_cmd =3D g_at_chat_send(spd->chat, "AT+CSIM=3D8,A0F200C0",
-			csim_prefix, at_csim_status_cb, spd, NULL);
+	spd->status_cmd =3D g_at_chat_send_with_callback(spd->chat,
+			"AT+CSIM=3D8,A0F200C0", csim_prefix,
+			at_csim_status_sent_cb, at_csim_status_cb, spd, NULL);
 	if (spd->status_cmd =3D=3D 0)
 		at_csim_status_cb(FALSE, NULL, spd);
 =

-- =

1.6.1


--===============2328087390687004557==--

