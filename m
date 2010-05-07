Content-Type: multipart/mixed; boundary="===============1392867580982072095=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH v2 3/6] sim-poll: Count timeout from the moment STATUS is sent
 to modem.
Date: Fri, 07 May 2010 02:26:57 +0200
Message-ID: <1273192017-11160-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1392867580982072095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim-poll.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sim-poll.c b/drivers/atmodem/sim-poll.c
index bd2caa6..111dce8 100644
--- a/drivers/atmodem/sim-poll.c
+++ b/drivers/atmodem/sim-poll.c
@@ -198,20 +198,27 @@ static void at_csim_status_cb(gboolean ok, GAtResult =
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
-			csim_prefix, at_csim_status_cb, spd);
+	spd->status_cmd =3D g_at_chat_send_full(spd->chat, "AT+CSIM=3D8,A0F200C0",
+			csim_prefix, at_csim_status_sent_cb, at_csim_status_cb,
+			spd, NULL);
 	if (spd->status_cmd =3D=3D 0)
 		at_csim_status_cb(FALSE, NULL, spd);
 =

-- =

1.6.1


--===============1392867580982072095==--

