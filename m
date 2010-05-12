Content-Type: multipart/mixed; boundary="===============4786017909614395736=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [RFC] [PATCH 2/3] Add: online and change_state methods to isimodem
 driver
Date: Wed, 12 May 2010 17:31:11 +0300
Message-ID: <1273674672-32241-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1273674672-32241-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4786017909614395736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/isimodem.c |  180 +++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 148 insertions(+), 32 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 4085a55..26299ca 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -68,6 +68,11 @@ struct isi_data {
 	unsigned interval;
 	int reported;
 	int mtc_state;
+	int online;
+	struct {
+		ofono_modem_online_cb callback;
+		void *data;
+	} online_request;
 };
 =

 static void report_powered(struct isi_data *isi, ofono_bool_t powered)
@@ -76,9 +81,33 @@ static void report_powered(struct isi_data *isi, ofono_b=
ool_t powered)
 		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
 }
 =

-static void set_power_by_mtc_state(struct isi_data *isi, int state)
+static void report_online(struct isi_data *isi, uint8_t mtc_state)
 {
-	switch (isi->mtc_state =3D state) {
+	ofono_modem_online_cb callback =3D isi->online_request.callback;
+	void *data =3D isi->online_request.data;
+	struct ofono_error error =3D {
+		OFONO_ERROR_TYPE_FAILURE
+	};
+
+	if (!callback)
+		return;
+
+	isi->online_request.callback =3D 0;
+	isi->online_request.data =3D 0;
+	if (isi->online ? mtc_state =3D=3D MTC_NORMAL : mtc_state !=3D MTC_NORMAL)
+		callback(NULL, data);
+	else
+		callback(&error, data);
+}
+
+
+static void set_power_by_mtc_state(struct isi_data *isi, int mtc_state)
+{
+	isi->mtc_state =3D mtc_state;
+
+	report_online(isi, mtc_state);
+
+	switch (mtc_state) {
 	case MTC_STATE_NONE:
 	case MTC_POWER_OFF:
 	case MTC_CHARGING:
@@ -87,6 +116,9 @@ static void set_power_by_mtc_state(struct isi_data *isi,=
 int state)
 		break;
 =

 	case MTC_RF_INACTIVE:
+		report_powered(isi, 1);
+		break;
+
 	case MTC_NORMAL:
 		report_powered(isi, 1);
 		break;
@@ -96,6 +128,7 @@ static void set_power_by_mtc_state(struct isi_data *isi,=
 int state)
 	}
 }
 =

+
 static void mtc_state_ind_cb(GIsiClient *client, const void *restrict data,
 				size_t len, uint16_t object, void *opaque)
 {
@@ -155,7 +188,8 @@ static bool mtc_poll_query_cb(GIsiClient *client, const=
 void *restrict data,
 	DBG("target modem state: %s (0x%02X)",
 		mtc_modem_state_name(msg[2]), msg[2]);
 =

-	set_power_by_mtc_state(isi, msg[1]);
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
 =

 	return true;
 }
@@ -179,7 +213,8 @@ static bool mtc_query_cb(GIsiClient *client, const void=
 *restrict data,
 	DBG("target modem state: %s (0x%02X)",
 		mtc_modem_state_name(msg[2]), msg[2]);
 =

-	set_power_by_mtc_state(isi, msg[1]);
+	if (msg[1] =3D=3D msg[2])
+		set_power_by_mtc_state(isi, msg[1]);
 =

 	return true;
 }
@@ -276,6 +311,7 @@ static int isi_modem_probe(struct ofono_modem *modem)
 	isi->ifname =3D ifname;
 	isi->link =3D link;
 	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
+	isi->reported =3D -1;
 =

 	return 0;
 }
@@ -292,51 +328,131 @@ static void isi_modem_remove(struct ofono_modem *mod=
em)
 	g_free(isi);
 }
 =

-static void isi_modem_pre_sim(struct ofono_modem *modem)
+static bool mtc_state_cb(GIsiClient *client, const void *restrict data,
+			size_t len, uint16_t object, void *opaque)
+{
+	struct isi_data *isi =3D opaque;
+	const unsigned char *msg =3D data;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto err;
+	}
+
+	if (len < 3 || msg[0] !=3D MTC_STATE_RESP)
+		return false;
+	DBG("cause: %s (0x%02X)", mtc_isi_cause_name(msg[1]), msg[1]);
+	if (msg[1] =3D=3D 0)
+		return true;
+
+err:
+	if (isi->online_request.callback) {
+		ofono_modem_online_cb cb =3D isi->online_request.callback;
+		void *cbdata =3D isi->online_request.data;
+		struct ofono_error error =3D {
+			OFONO_ERROR_TYPE_FAILURE
+		};
+		isi->online_request.callback =3D 0;
+		isi->online_request.data =3D 0;
+		cb(&error, cbdata);
+	}
+
+	return true;
+}
+
+static int mtc_state_req(struct isi_data *isi, uint8_t state)
+{
+	const unsigned char req[] =3D {
+		MTC_STATE_REQ, state, 0x00
+	};
+
+	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
+					mtc_state_cb, isi))
+		return 0;
+	else
+		return -errno;
+}
+
+static void isi_modem_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
+			ofono_modem_online_cb callback, void *data)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	int err;
 =

-	DBG("(%p) with %s", modem, isi->ifname);
+	isi->online =3D online;
+	isi->online_request.callback =3D callback;
+	isi->online_request.data =3D data;
 =

-	ofono_sim_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_devinfo_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_voicecall_create(isi->modem, 0, "isimodem", isi->idx);
+	err =3D mtc_state_req(isi, online ? MTC_NORMAL : MTC_RF_INACTIVE);
+
+	if (err)
+		report_online(isi, MTC_STATE_NONE);
 }
 =

-static void isi_modem_post_sim(struct ofono_modem *modem)
+static void isi_modem_change_state(struct ofono_modem *modem,
+				enum ofono_modem_state new_state,
+				enum ofono_modem_state old_state)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

-	DBG("(%p) with %s", modem, isi->ifname);
-
-	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
-	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-	else
-		DBG("Failed to add context");
+	DBG("(%p w/ %s, %u, %u)", modem, isi ? isi->ifname : "?",
+		new_state, old_state);
+
+	if (isi =3D=3D NULL)
+		return;
+
+	if (new_state < old_state) {
+		if (new_state >=3D OFONO_MODEM_STATE_PRE_SIM)
+			mtc_state_req(isi, MTC_RF_INACTIVE);
+		report_online(isi, MTC_RF_INACTIVE);
+		isi->online =3D FALSE;
+		return;
+	}
+
+	switch (new_state) {
+	case OFONO_MODEM_STATE_POWER_OFF:
+		break;
+
+	case OFONO_MODEM_STATE_PRE_SIM:
+		ofono_sim_create(modem, 0, "isimodem", isi->idx);
+		ofono_devinfo_create(modem, 0, "isimodem", isi->idx);
+		ofono_voicecall_create(modem, 0, "isimodem", isi->idx);
+		break;
+
+	case OFONO_MODEM_STATE_OFFLINE:
+		ofono_phonebook_create(modem, 0, "isimodem", isi->idx);
+		break;
+
+	case OFONO_MODEM_STATE_ONLINE:
+		ofono_netreg_create(modem, 0, "isimodem", isi->idx);
+		ofono_sms_create(modem, 0, "isimodem", isi->idx);
+		ofono_cbs_create(modem, 0, "isimodem", isi->idx);
+		ofono_ssn_create(modem, 0, "isimodem", isi->idx);
+		ofono_ussd_create(modem, 0, "isimodem", isi->idx);
+		ofono_call_forwarding_create(modem, 0, "isimodem", isi->idx);
+		ofono_call_settings_create(modem, 0, "isimodem", isi->idx);
+		ofono_call_barring_create(modem, 0, "isimodem", isi->idx);
+		ofono_call_meter_create(modem, 0, "isimodem", isi->idx);
+		ofono_radio_settings_create(modem, 0, "isimodem", isi->idx);
+		gprs =3D ofono_gprs_create(modem, 0, "isimodem", isi->idx);
+		gc =3D ofono_gprs_context_create(modem, 0, "isimodem", isi->idx);
+
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+		else
+			DBG("Failed to add context");
+		break;
+	}
 }
 =

 static struct ofono_modem_driver driver =3D {
 	.name =3D "isimodem",
 	.probe =3D isi_modem_probe,
 	.remove =3D isi_modem_remove,
-	.pre_sim =3D isi_modem_pre_sim,
-	.post_sim =3D isi_modem_post_sim,
+	.online =3D isi_modem_online,
+	.change_state =3D isi_modem_change_state,
 };
 =

 static int isimodem_init(void)
-- =

1.6.3.3


--===============4786017909614395736==--

