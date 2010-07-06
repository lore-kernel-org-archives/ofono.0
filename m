Content-Type: multipart/mixed; boundary="===============4133221611937726453=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/14] stk: Handle the Timer Management proactive command.
Date: Wed, 07 Jul 2010 00:39:08 +0200
Message-ID: <1278455949-2823-14-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4133221611937726453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  165 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 165 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 940c65d..6edce2c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <gdbus.h>
 #include <errno.h>
+#include <time.h>
 =

 #include "ofono.h"
 =

@@ -40,6 +41,11 @@
 =

 static GSList *g_drivers =3D NULL;
 =

+struct stk_timer {
+	time_t expiry;
+	time_t start;
+};
+
 struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
@@ -49,6 +55,9 @@ struct ofono_stk {
 	gboolean cancelled;
 	GQueue *envelope_q;
 =

+	struct stk_timer timers[8];
+	guint timers_source;
+
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -69,6 +78,7 @@ struct sms_submit_req {
 #define ENVELOPE_RETRIES_DEFAULT 5
 =

 static void envelope_queue_run(struct ofono_stk *stk);
+static void timers_update(struct ofono_stk *stk);
 =

 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
@@ -378,6 +388,152 @@ out:
 	return TRUE;
 }
 =

+static void timer_expiration_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
+{
+	if (!ok) {
+		ofono_error("Timer Expiration reporting failed");
+		return;
+	}
+
+	if (len)
+		ofono_error("Timer Expiration returned %i bytes of data",
+				len);
+
+	DBG("Timer Expiration reporting to UICC reported no error");
+}
+
+static gboolean timers_cb(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->timers_source =3D 0;
+
+	timers_update(stk);
+
+	return FALSE;
+}
+
+static void timer_value_from_seconds(struct stk_timer_value *val, int seco=
nds)
+{
+	val->has_value =3D TRUE;
+	val->hour =3D seconds / 3600;
+	seconds -=3D val->hour * 3600;
+	val->minute =3D seconds / 60;
+	seconds -=3D val->minute * 60;
+	val->second =3D seconds;
+}
+
+static void timers_update(struct ofono_stk *stk)
+{
+	time_t min =3D 0, now =3D time(NULL);
+	int i;
+
+	if (stk->timers_source) {
+		g_source_remove(stk->timers_source);
+		stk->timers_source =3D 0;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		if (!stk->timers[i].expiry)
+			continue;
+
+		if (stk->timers[i].expiry <=3D now) {
+			struct stk_envelope e;
+			int seconds =3D now - stk->timers[i].start;
+
+			stk->timers[i].expiry =3D 0;
+
+			memset(&e, 0, sizeof(e));
+
+			e.type =3D STK_ENVELOPE_TYPE_TIMER_EXPIRATION;
+			e.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+			e.timer_expiration.id =3D i + 1;
+			timer_value_from_seconds(&e.timer_expiration.value,
+							seconds);
+
+			/*
+			 * TODO: resubmit until success, providing current
+			 * time difference every time we re-send.
+			 */
+			if (stk_send_envelope(stk, &e, timer_expiration_cb, 0))
+				timer_expiration_cb(stk, FALSE, NULL, -1);
+
+			continue;
+		}
+
+		if (stk->timers[i].expiry < now + min || min =3D=3D 0)
+			min =3D stk->timers[i].expiry - now;
+	}
+
+	if (min)
+		stk->timers_source =3D g_timeout_add_seconds(min, timers_cb, stk);
+}
+
+static gboolean handle_command_timer_mgmt(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int op =3D cmd->qualifier & 3;
+	time_t seconds, now =3D time(NULL);
+	struct stk_timer *tmr;
+
+	if (cmd->timer_mgmt.timer_id < 1 || cmd->timer_mgmt.timer_id > 8) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	tmr =3D &stk->timers[cmd->timer_mgmt.timer_id - 1];
+
+	switch (op) {
+	case 0: /* Start */
+		seconds =3D cmd->timer_mgmt.timer_value.second +
+			cmd->timer_mgmt.timer_value.minute * 60 +
+			cmd->timer_mgmt.timer_value.hour * 3600;
+
+		tmr->expiry =3D now + seconds;
+		tmr->start =3D now;
+
+		timers_update(stk);
+		break;
+
+	case 1: /* Deactivate */
+		if (!tmr->expiry) {
+			rsp->result.type =3D STK_RESULT_TYPE_TIMER_CONFLICT;
+
+			return TRUE;
+		}
+
+		seconds =3D MAX(0, tmr->expiry - now);
+		tmr->expiry =3D 0;
+
+		timers_update(stk);
+
+		timer_value_from_seconds(&rsp->timer_mgmt.value, seconds);
+		break;
+
+	case 2: /* Get current value */
+		if (!tmr->expiry) {
+			rsp->result.type =3D STK_RESULT_TYPE_TIMER_CONFLICT;
+
+			return TRUE;
+		}
+
+		seconds =3D MAX(0, tmr->expiry - now);
+		timer_value_from_seconds(&rsp->timer_mgmt.value, seconds);
+		break;
+
+	default:
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	rsp->timer_mgmt.id =3D cmd->timer_mgmt.timer_id;
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -460,6 +616,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 			respond =3D handle_command_set_idle_text(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
+			respond =3D handle_command_timer_mgmt(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
@@ -524,6 +684,11 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk->idle_mode_text =3D NULL;
 	}
 =

+	if (stk->timers_source) {
+		g_source_remove(stk->timers_source);
+		stk->timers_source =3D 0;
+	}
+
 	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
 	g_queue_free(stk->envelope_q);
 =

-- =

1.7.1.86.g0e460.dirty


--===============4133221611937726453==--

