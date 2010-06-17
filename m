Content-Type: multipart/mixed; boundary="===============5602228249599468369=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] atmodem: Add PIN entry quirk for mbm.
Date: Thu, 17 Jun 2010 15:42:13 +0200
Message-ID: <1276782135-26871-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5602228249599468369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Wait for *EPEV unsolicited response after PIN entered, otherwise the
next AT+CPIN? query still returns the old value for a fraction of a
second and ofono gets stuck until the next PIN entry attempt.
---
 drivers/atmodem/sim.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index e722fbb..8d5a9fa 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,6 +44,7 @@
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	guint epev_id;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -509,6 +510,45 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_epev_notify(GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+
+	cb(&error, cbd->data);
+
+	g_at_chat_unregister(sd->chat, sd->epev_id);
+	sd->epev_id =3D 0;
+}
+
+static void at_pin_send_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	/*
+	 * On the MBM modem, AT+CPIN? keeps returning SIM PIN for a moment
+	 * after successful AT+CPIN=3D"..", but sends *EPEV when that changes.
+	 */
+	if (ok && sd->vendor =3D=3D OFONO_VENDOR_MBM) {
+		sd->epev_id =3D g_at_chat_register(sd->chat, "*EPEV",
+							at_epev_notify,
+							FALSE, cbd, g_free);
+		return;
+	}
+
+	cb(&error, cbd->data);
+
+	g_free(cbd);
+}
+
 static void at_lock_unlock_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -532,10 +572,12 @@ static void at_pin_send(struct ofono_sim *sim, const =
char *passwd,
 	if (!cbd)
 		goto error;
 =

+	cbd->user =3D sd;
+
 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_lock_unlock_cb, cbd, g_free);
+				at_pin_send_cb, cbd, NULL);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -740,6 +782,8 @@ static int at_sim_probe(struct ofono_sim *sim, unsigned=
 int vendor,
 =

 	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM)
 		g_at_chat_add_terminator(chat, "+CPIN:", 6, TRUE);
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		g_at_chat_send(chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
 =

 	ofono_sim_set_data(sim, sd);
 	g_idle_add(at_sim_register, sim);
-- =

1.7.1.86.g0e460.dirty


--===============5602228249599468369==--

