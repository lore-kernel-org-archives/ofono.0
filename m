Content-Type: multipart/mixed; boundary="===============2392696084355602409=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 3/3] atmodem: Poll SIM state after having entered PIN
Date: Wed, 18 Apr 2012 14:16:10 +0200
Message-ID: <1334751370-5134-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1334751370-5134-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2392696084355602409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We encountered the problem of CME ERROR 14: SIM busy on ZTE modems.
ZTE modems don't use SIM notification to check SIM state.
We poll SIM ready state before confirming PIN is entered.
---
 drivers/atmodem/sim.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c51b1d4..865d758 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -51,6 +51,7 @@ struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -972,6 +973,21 @@ static void at_epev_notify(GAtResult *result, gpointer=
 user_data)
 	sd->ready_id =3D 0;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	at_util_sim_state_query_free(sd->sim_state_query);
+	sd->sim_state_query =3D NULL;
+
+	if (present =3D=3D 1)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 static void at_pin_send_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -1005,6 +1021,16 @@ static void at_pin_send_cb(gboolean ok, GAtResult *r=
esult,
 		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
 							at_epev_notify,
 							FALSE, cbd, g_free);
+	case OFONO_VENDOR_ZTE:
+		/*
+		 * On ZTE modems, after pin is entered, SIM state is check
+		 * by doing some polling as their modem doesn't use
+		 * notification.
+		 */
+	default:
+		sd->sim_state_query =3D at_util_sim_state_query_new(sd->chat,
+						2, 20, sim_state_cb, cbd,
+						g_free);
 		return;
 	}
 =

@@ -1246,6 +1272,9 @@ static void at_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

+	/* Cleanup potential SIM state polling */
+	at_util_sim_state_query_free(sd->sim_state_query);
+
 	ofono_sim_set_data(sim, NULL);
 =

 	g_at_chat_unref(sd->chat);
-- =

1.7.5.4


--===============2392696084355602409==--

