Content-Type: multipart/mixed; boundary="===============7850398510595365894=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 9/9] quectel: initialize call, phonebook and sms when ready
Date: Wed, 10 Jul 2019 23:51:48 +0200
Message-ID: <20190710215148.78083-10-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7850398510595365894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel M95 modem issues a "Call ready" notification when call and
phonebook are ready, so set up a listener for that.

The only way to know when sms is ready is to issue QINITSTAT queries.
Since sms is always ready after call and phonebook, the queries are
initiated after creating call/phonebook.
---
 plugins/quectel.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 8bf9a963..e96a66d7 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -42,6 +42,9 @@
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/sim.h>
+#include <ofono/sms.h>
+#include <ofono/phonebook.h>
+#include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
@@ -51,6 +54,7 @@
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -69,8 +73,10 @@ struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
 	guint cpin_ready;
+	guint call_ready;
 	bool have_sim;
 	enum ofono_vendor vendor;
+	struct l_timeout *sms_ready_timer;
 =

 	/* used by quectel uart driver */
 	GAtChat *uart;
@@ -338,6 +344,67 @@ static void cgmm_cb(int ok, GAtResult *result, void *u=
ser_data)
 			NULL);
 }
 =

+static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int status;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	DBG("qinistat: %d", status);
+
+	if (status !=3D 3) {
+		l_timeout_modify_ms(data->sms_ready_timer, 500);
+		return;
+	}
+
+	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
+	l_timeout_remove(data->sms_ready_timer);
+	data->sms_ready_timer =3D NULL;
+}
+
+static void sms_ready_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_prefix, qinistat_cb,
+			modem, NULL);
+}
+
+static void call_ready_notify(GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *sim_inserted;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_chat_unregister(data->aux, data->call_ready);
+	data->sms_ready_timer =3D l_timeout_create_ms(500, sms_ready_cb, modem,
+							NULL);
+	if (!data->sms_ready_timer) {
+		close_serial(modem);
+		return;
+	}
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
+	ofono_voicecall_create(modem, 0, "atmodem", data->aux);
+}
+
 static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -357,6 +424,14 @@ static int open_ttys(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	data->call_ready =3D g_at_chat_register(data->aux, "Call Ready",
+						call_ready_notify, false,
+						modem, NULL);
+	if (!data->call_ready) {
+		close_serial(modem);
+		return -ENOTTY;
+	}
+
 	g_at_chat_set_slave(data->modem, data->aux);
 =

 	g_at_chat_send(data->modem, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL,
-- =

2.22.0


--===============7850398510595365894==--

