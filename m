Content-Type: multipart/mixed; boundary="===============5038250724653584793=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCHv2 1/2] speedup: add cpin polling mechanism
Date: Thu, 21 Jul 2011 12:01:52 +0200
Message-ID: <1311242513-17724-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1311242513-17724-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5038250724653584793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure that the SIM card is ready before sending commands
---
 plugins/speedup.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index 7e89b6f..afd9b40 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -49,10 +49,14 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 =

 struct speedup_data {
 	GAtChat *modem;
 	GAtChat *aux;
+	guint cpin_poll_source;
+	guint cpin_poll_count;
+	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 };
@@ -83,6 +87,9 @@ static void speedup_remove(struct ofono_modem *modem)
 	g_at_chat_unref(data->modem);
 	g_at_chat_unref(data->aux);
 =

+	if (data->cpin_poll_source > 0)
+		g_source_remove(data->cpin_poll_source);
+
 	g_free(data);
 }
 =

@@ -152,13 +159,68 @@ static void speedup_disconnect(gpointer user_data)
 		ofono_gprs_add_context(data->gprs, data->gc);
 }
 =

+static gboolean init_simpin_check(gpointer user_data);
+
+static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_error error;
+
+	DBG("");
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	/* Modem returns an error if SIM is not ready. */
+	switch (error.error) {
+	case 10:
+	case 13:
+		data->have_sim =3D FALSE;
+		break;
+	case 14: /* SIM Busy, wait and check again the SIM pin status */
+		if (data->cpin_poll_count++ < 20) {
+			data->cpin_poll_source =3D
+				g_timeout_add_seconds(1, init_simpin_check,
+						modem);
+			return;
+		}
+		/*SIM card is present but not accessible*/
+		data->have_sim =3D FALSE;
+		break;
+	default:
+		data->have_sim =3D TRUE;
+	}
+
+	data->cpin_poll_count =3D 0;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static gboolean init_simpin_check(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct speedup_data *data =3D ofono_modem_get_data(modem);
+
+	data->cpin_poll_source =3D 0;
+
+	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+
+	return FALSE;
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 =

 	DBG("");
 =

-	ofono_modem_set_powered(modem, ok);
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	init_simpin_check(modem);
 }
 =

 static int speedup_enable(struct ofono_modem *modem)
@@ -272,7 +334,7 @@ static void speedup_pre_sim(struct ofono_modem *modem)
 				"atmodem", data->aux);
 =

 	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_inserted_notify(sim, data->have_sim);
 }
 =

 static void speedup_post_sim(struct ofono_modem *modem)
-- =

1.7.4.1


--===============5038250724653584793==--

