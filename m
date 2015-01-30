Content-Type: multipart/mixed; boundary="===============3455508391657327650=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] sierra: add sim state polling after CFUN enable
Date: Fri, 30 Jan 2015 11:34:32 +0100
Message-ID: <1422614072-23635-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3455508391657327650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

When pin is queried shortly after a Siera dongle is plugged in, "AT+CPIN?"
responds with "CME ERROR 14: SIM".
Poll the sim, as already done by several other vendor plugins.
---
 plugins/sierra.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index a458e38..458fec2 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -48,6 +48,8 @@ static const char *none_prefix[] =3D { NULL };
 =

 struct sierra_data {
 	GAtChat *modem;
+	gboolean have_sim;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static void sierra_debug(const char *str, void *user_data)
@@ -80,6 +82,9 @@ static void sierra_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	/* Cleanup potential SIM state polling */
+	at_util_sim_state_query_free(data->sim_state_query);
+
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->modem);
 =

@@ -119,6 +124,21 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sierra_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	data->have_sim =3D present;
+	ofono_modem_set_powered(modem, TRUE);
+
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -131,7 +151,9 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		data->modem =3D NULL;
 	}
 =

-	ofono_modem_set_powered(modem, ok);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->modem,
+						2, 20, sim_state_cb, modem,
+						NULL);
 }
 =

 static int sierra_enable(struct ofono_modem *modem)
@@ -222,7 +244,7 @@ static void sierra_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIERRA,
 					"atmodem", data->modem);
 =

-	if (sim)
+	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.9.2


--===============3455508391657327650==--

