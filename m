Content-Type: multipart/mixed; boundary="===============4926533435548944607=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8][RFC] Try to fetch and parse proactive commands.
Date: Mon, 15 Mar 2010 22:22:04 +0100
Message-ID: <1268688124-4141-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4926533435548944607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 63f50eb..cddb3e4 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1804,8 +1804,46 @@ void ofono_sim_removed(struct ofono_sim *sim)
 	}
 }
 =

+static void sim_command_fetch_cb(const struct ofono_error *error,
+		const unsigned char *pdu, int length, void *data)
+{
+	struct stk_command *cmd;
+	char *buf;
+	int i;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Proactive command pending but can't fetch it");
+		return;
+	}
+
+	buf =3D g_try_new(char, length * 2 + 1);
+	for (i =3D 0; i < length; i ++)
+		sprintf(buf + i * 2, "%hhx", pdu[i]);
+	DBG("Fetched PDU: %s", buf);
+
+	cmd =3D stk_command_new_from_pdu(pdu, length);
+	if (!cmd) {
+		ofono_error("Can't parse proactive command: %s", buf);
+		g_free(buf);
+
+		/* TODO: return TERMINAL RESPONSE with permanent error */
+		return;
+	}
+
+	/* TODO: execute */
+
+	g_free(buf);
+	stk_command_free(cmd);
+}
+
 void ofono_sim_proactive_command_notify(struct ofono_sim *sim, int length)
 {
+	DBG("%p: %i bytes", sim, length);
+
+	if (!sim->driver->fetch)
+		return;
+
+	sim->driver->fetch(sim, length, sim_command_fetch_cb, sim);
 }
 =

 static void sim_status_poll_schedule(struct ofono_sim *sim)
-- =

1.6.1


--===============4926533435548944607==--

