Content-Type: multipart/mixed; boundary="===============4244193043010667467=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stk: Add duration_to_msecs to reduce duplication.
Date: Mon, 25 Oct 2010 07:51:26 +0200
Message-ID: <1287985887-15181-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1287985887-15181-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4244193043010667467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   61 ++++++++++++++++++++++++++-------------------------------=
----
 1 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 82bc91e..ebd3801 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -437,6 +437,24 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	/* TODO */
 }
 =

+static int duration_to_msecs(const struct stk_duration *duration)
+{
+	int msecs =3D duration->interval;
+
+	switch (duration->unit) {
+	case STK_DURATION_TYPE_MINUTES:
+		msecs *=3D 60;
+		/* Fall through.  */
+	case STK_DURATION_TYPE_SECONDS:
+		msecs *=3D 10;
+		/* Fall through.  */
+	case STK_DURATION_TYPE_SECOND_TENTHS:
+		msecs *=3D 100;
+	}
+
+	return msecs;
+}
+
 static DBusMessage *stk_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1000,23 +1018,14 @@ static gboolean handle_command_poll_interval(const =
struct stk_command *cmd,
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
 	int seconds;
 =

-	switch (cmd->poll_interval.duration.unit) {
-	case STK_DURATION_TYPE_MINUTES:
-		seconds =3D cmd->poll_interval.duration.interval * 60;
-		break;
-	case STK_DURATION_TYPE_SECONDS:
-		seconds =3D cmd->poll_interval.duration.interval;
-		break;
-	case STK_DURATION_TYPE_SECOND_TENTHS:
-		seconds =3D (4 + cmd->poll_interval.duration.interval) / 10;
-		if (seconds < 1)
-			seconds =3D 1;
-		break;
-	default:
+	if (!cmd->poll_interval.duration.interval) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
 =

+	seconds =3D MAX(duration_to_msecs(&cmd->poll_interval.duration) / 1000,
+			1);
+
 	ofono_modem_set_integer(modem, "status-poll-interval", seconds);
 =

 	if (seconds > 255) {
@@ -1219,17 +1228,8 @@ static gboolean handle_command_display_text(const st=
ruct stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (dt->duration.interval) {
-		timeout =3D dt->duration.interval;
-		switch (dt->duration.unit) {
-		case STK_DURATION_TYPE_MINUTES:
-			timeout *=3D 60;
-		case STK_DURATION_TYPE_SECONDS:
-			timeout *=3D 10;
-		case STK_DURATION_TYPE_SECOND_TENTHS:
-			timeout *=3D 100;
-		}
-	}
+	if (dt->duration.interval)
+		timeout =3D duration_to_msecs(&dt->duration);
 =

 	err =3D stk_agent_display_text(stk->current_agent, text, &dt->icon_id,
 					priority, display_text_cb, stk,
@@ -1387,17 +1387,8 @@ static gboolean handle_command_get_inkey(const struc=
t stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (gi->duration.interval) {
-		timeout =3D gi->duration.interval;
-		switch (gi->duration.unit) {
-		case STK_DURATION_TYPE_MINUTES:
-			timeout *=3D 60;
-		case STK_DURATION_TYPE_SECONDS:
-			timeout *=3D 10;
-		case STK_DURATION_TYPE_SECOND_TENTHS:
-			timeout *=3D 100;
-		}
-	}
+	if (gi->duration.interval)
+		timeout =3D duration_to_msecs(&gi->duration);
 =

 	gettimeofday(&stk->get_inkey_start_ts, NULL);
 =

-- =

1.7.1.86.g0e460.dirty


--===============4244193043010667467==--

