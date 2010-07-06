Content-Type: multipart/mixed; boundary="===============8639125474440367287=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/14] stk: Handle the Poll Interval proactive command.
Date: Wed, 07 Jul 2010 00:39:09 +0200
Message-ID: <1278455949-2823-15-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8639125474440367287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 6edce2c..e77c723 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -534,6 +534,47 @@ static gboolean handle_command_timer_mgmt(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean handle_command_poll_interval(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	int seconds;
+
+	switch (cmd->poll_interval.duration.unit) {
+	case STK_DURATION_TYPE_MINUTES:
+		seconds =3D cmd->poll_interval.duration.interval * 60;
+		break;
+	case STK_DURATION_TYPE_SECONDS:
+		seconds =3D cmd->poll_interval.duration.interval;
+		break;
+	case STK_DURATION_TYPE_SECOND_TENTHS:
+		seconds =3D (4 + cmd->poll_interval.duration.interval) / 10;
+		if (seconds < 1)
+			seconds =3D 1;
+		break;
+	}
+
+	if (ofono_modem_set_integer(modem, "status-poll-interval", seconds)) {
+		seconds =3D ofono_modem_get_integer(modem,
+							"status-poll-interval");
+		if (!seconds)
+			seconds =3D 30;
+	}
+
+	if (seconds > 255) {
+		rsp->poll_interval.max_interval.unit =3D
+			STK_DURATION_TYPE_MINUTES;
+		rsp->poll_interval.max_interval.interval =3D seconds / 60;
+	} else {
+		rsp->poll_interval.max_interval.unit =3D
+			STK_DURATION_TYPE_SECONDS;
+		rsp->poll_interval.max_interval.interval =3D seconds;
+	}
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -620,6 +661,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 			respond =3D handle_command_timer_mgmt(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_POLL_INTERVAL:
+			respond =3D handle_command_poll_interval(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============8639125474440367287==--

