Content-Type: multipart/mixed; boundary="===============5925523243270519551=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/4] atmodem: Add a polling based on CPIN query to detect SIM
 state change
Date: Fri, 22 Jul 2011 18:15:28 +0200
Message-ID: <1311351329-1241-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1311351329-1241-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5925523243270519551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On ZTE/Speedup modem, AT+CPIN? keeps returning CME ERROR 14 for a moment
after successful AT+CPIN=3D".."
As there is no card status notification, a pooling with CPIN queries is used
to detect the state change.
---
 drivers/atmodem/sim.c |   55 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index a4a09f5..b28f3f8 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -46,10 +46,13 @@
 =

 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 =

+#define POLL_INTERVAL	1
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	guint cpin_poll_count;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -61,6 +64,8 @@ static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CP=
INRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

+static void pin_status_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta);
+
 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -757,6 +762,44 @@ static void at_cpin_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	cb(&error, pin_type, cbd->data);
 }
 =

+static gboolean pin_status_poll(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	if (g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix, pin_status_cb,
+			cbd, NULL) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+
+	return FALSE;
+}
+
+static void pin_status_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (error.error =3D=3D 14 && sd->cpin_poll_count++ < 5) {
+		/* SIM Busy, wait and check again the pin status */
+		sd->ready_id =3D g_timeout_add_seconds(POLL_INTERVAL,
+							pin_status_poll, cbd);
+		return;
+	}
+
+	sd->cpin_poll_count =3D 0;
+	sd->ready_id =3D 0;
+	cb(&error, cbd->data);
+
+	g_free(cbd);
+}
+
 static void at_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
 			void *data)
 {
@@ -852,6 +895,18 @@ static void at_pin_send_cb(gboolean ok, GAtResult *res=
ult,
 							at_epev_notify,
 							FALSE, cbd, g_free);
 		return;
+	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_SPEEDUP:
+		/* On ZTE/Speedup modem, AT+CPIN? keeps returning CME ERROR 14
+		 * for a moment after successful AT+CPIN=3D".."
+		 * As there is no card status notification, a pooling with
+		 * CPIN queries is used to detect the state change
+		 */
+		sd->cpin_poll_count =3D 0;
+
+		g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix,
+						pin_status_cb, cbd, NULL);
+		return;
 	}
 =

 done:
-- =

1.7.1


--===============5925523243270519551==--

