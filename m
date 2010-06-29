Content-Type: multipart/mixed; boundary="===============5492368699697815060=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] atmodem: Don't unregister *EPEV in *EPEV handler.
Date: Tue, 29 Jun 2010 05:00:27 +0200
Message-ID: <1277780427-8241-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5492368699697815060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handlers are called when looping over the unsolicited responses hash,
registering or unregistering modifies that hash and confuses glib.
---
 drivers/atmodem/sim.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7499d60..2b4a8c6 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -45,6 +45,7 @@ struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint epev_id;
+	guint epev_source;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -510,6 +511,18 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static gboolean at_epev_unregister(gpointer user_data)
+{
+	struct sim_data *sd =3D user_data;
+
+	sd->epev_source =3D 0;
+
+	g_at_chat_unregister(sd->chat, sd->epev_id);
+	sd->epev_id =3D 0;
+
+	return FALSE;
+}
+
 static void at_epev_notify(GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -517,10 +530,12 @@ static void at_epev_notify(GAtResult *result, gpointe=
r user_data)
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
 	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
 =

+	if (sd->epev_source)
+		return;
+
 	cb(&error, cbd->data);
 =

-	g_at_chat_unregister(sd->chat, sd->epev_id);
-	sd->epev_id =3D 0;
+	sd->epev_source =3D g_timeout_add(0, at_epev_unregister, sd);
 }
 =

 static void at_pin_send_cb(gboolean ok, GAtResult *result,
@@ -803,6 +818,9 @@ static void at_sim_remove(struct ofono_sim *sim)
 =

 	ofono_sim_set_data(sim, NULL);
 =

+	if (sd->epev_source)
+		g_source_remove(sd->epev_source);
+
 	g_free(sd);
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============5492368699697815060==--

