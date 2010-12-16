Content-Type: multipart/mixed; boundary="===============6731639407207525878=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] zte: poll sim before sim_inserted_notify
Date: Thu, 16 Dec 2010 20:36:39 +0200
Message-ID: <1292524599-17114-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6731639407207525878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Ensure that SIM is ready before calling ofono_sim_inserted_notify().
---
 plugins/zte.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 82f322a..50f6280 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -55,6 +55,9 @@ struct zte_data {
 	GAtChat *aux;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct ofono_sim *sim;
+	guint poll_source;
+	guint poll_count;
 };
 =

 static int zte_probe(struct ofono_modem *modem)
@@ -221,6 +224,13 @@ static int zte_disable(struct ofono_modem *modem)
 	if (data->aux =3D=3D NULL)
 		return 0;
 =

+	data->sim =3D NULL;
+
+	if (data->poll_source) {
+		g_source_remove(data->poll_source);
+		data->poll_source =3D 0;
+	}
+
 	g_at_chat_cancel_all(data->aux);
 	g_at_chat_unregister_all(data->aux);
 	g_at_chat_send(data->aux, "AT+CFUN=3D0", none_prefix,
@@ -262,19 +272,56 @@ error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+static gboolean poll_sim(gpointer user_data);
+
+static void sim_poll_result(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct zte_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (ok) {
+		ofono_sim_inserted_notify(data->sim, ok);
+		return;
+	}
+
+	if (++data->poll_count > 5)
+		/* Give up after 5 seconds - there is probably no SIM */
+		return;
+
+	data->poll_source =3D g_timeout_add_seconds(1, poll_sim, modem);
+}
+
+static gboolean poll_sim(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct zte_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->poll_source =3D 0;
+
+	g_at_chat_send(data->aux, "AT+CPIN?", none_prefix,
+			sim_poll_result, modem, NULL);
+
+	return FALSE;
+}
+
 static void zte_pre_sim(struct ofono_modem *modem)
 {
 	struct zte_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-				"atmodem", data->aux);
 =

-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+	data->poll_count =3D 0;
+
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+	if (data->sim)
+		poll_sim(modem);
 }
 =

 static void zte_post_sim(struct ofono_modem *modem)
-- =

1.7.1


--===============6731639407207525878==--

