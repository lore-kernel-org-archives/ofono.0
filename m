Content-Type: multipart/mixed; boundary="===============4956651750558675907=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 6/6] Add: set_online and post_online methods to isimodem driver
Date: Thu, 27 May 2010 19:12:48 +0300
Message-ID: <1274976768-1555-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274976768-1555-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4956651750558675907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/isimodem.c |  107 +++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 05ebfe2..8df6fd6 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -67,7 +67,8 @@ struct isi_data {
 	GPhonetLinkState linkstate;
 	unsigned interval;
 	int reported;
-	int mtc_state;
+	ofono_bool_t online;
+	struct isi_cb_data *online_cbd;
 };
 =

 static void report_powered(struct isi_data *isi, ofono_bool_t powered)
@@ -76,9 +77,27 @@ static void report_powered(struct isi_data *isi, ofono_b=
ool_t powered)
 		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
 }
 =

-static void set_power_by_mtc_state(struct isi_data *isi, int state)
+static void report_online(struct isi_data *isi, ofono_bool_t online)
 {
-	switch (isi->mtc_state =3D state) {
+	struct isi_cb_data *cbd =3D isi->online_cbd;
+	ofono_modem_online_cb cb =3D cbd->cb;
+
+	isi->online_cbd =3D NULL;
+
+	if (isi->online =3D=3D online)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void set_power_by_mtc_state(struct isi_data *isi, int mtc_state)
+{
+	if (isi->online_cbd)
+		report_online(isi, mtc_state =3D=3D MTC_NORMAL);
+
+	switch (mtc_state) {
 	case MTC_STATE_NONE:
 	case MTC_POWER_OFF:
 	case MTC_CHARGING:
@@ -88,9 +107,6 @@ static void set_power_by_mtc_state(struct isi_data *isi,=
 int state)
 =

 	case MTC_RF_INACTIVE:
 	case MTC_NORMAL:
-		report_powered(isi, 1);
-		break;
-
 	default:
 		report_powered(isi, 1);
 	}
@@ -157,7 +173,8 @@ static gboolean mtc_poll_query_cb(GIsiClient *client,
 	DBG("target modem state: %s (0x%02X)",
 		mtc_modem_state_name(msg[2]), msg[2]);
 =

-	set_power_by_mtc_state(isi, msg[1]);
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
 =

 	return TRUE;
 }
@@ -182,7 +199,8 @@ static gboolean mtc_query_cb(GIsiClient *client,
 	DBG("target modem state: %s (0x%02X)",
 		mtc_modem_state_name(msg[2]), msg[2]);
 =

-	set_power_by_mtc_state(isi, msg[1]);
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
 =

 	return TRUE;
 }
@@ -279,6 +297,7 @@ static int isi_modem_probe(struct ofono_modem *modem)
 	isi->ifname =3D ifname;
 	isi->link =3D link;
 	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
+	isi->reported =3D -1;
 =

 	return 0;
 }
@@ -296,6 +315,66 @@ static void isi_modem_remove(struct ofono_modem *modem)
 	g_free(isi);
 }
 =

+static gboolean mtc_state_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_modem *modem =3D cbd->user;
+	ofono_modem_online_cb cb =3D cbd->cb;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const unsigned char *msg =3D data;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto err;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_RESP)
+		return FALSE;
+
+	DBG("cause: %s (0x%02X)", mtc_isi_cause_name(msg[1]), msg[1]);
+
+	if (msg[1] =3D=3D MTC_OK) {
+		isi->online_cbd =3D cbd;
+		return TRUE;
+	}
+
+err:
+	if (msg && msg[1] =3D=3D MTC_ALREADY_ACTIVE)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_modem_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
+				ofono_modem_online_cb cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	const unsigned char req[] =3D {
+		MTC_STATE_REQ, online ? MTC_NORMAL : MTC_RF_INACTIVE, 0x00
+	};
+	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	if (!cbd)
+		goto error;
+
+	isi->online =3D online;
+
+	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+				mtc_state_cb, cbd))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void isi_modem_pre_sim(struct ofono_modem *modem)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
@@ -310,12 +389,20 @@ static void isi_modem_pre_sim(struct ofono_modem *mod=
em)
 static void isi_modem_post_sim(struct ofono_modem *modem)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	DBG("(%p) with %s", modem, isi->ifname);
+
+	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+}
+
+static void isi_modem_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

-	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
@@ -339,8 +426,10 @@ static struct ofono_modem_driver driver =3D {
 	.name =3D "isimodem",
 	.probe =3D isi_modem_probe,
 	.remove =3D isi_modem_remove,
+	.set_online =3D isi_modem_online,
 	.pre_sim =3D isi_modem_pre_sim,
 	.post_sim =3D isi_modem_post_sim,
+	.post_online =3D isi_modem_post_online,
 };
 =

 static int isimodem_init(void)
-- =

1.6.3.3


--===============4956651750558675907==--

