Content-Type: multipart/mixed; boundary="===============3779352846085491179=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 1/4] Add: support for EF_ICCID in isimodem.
Date: Tue, 25 May 2010 23:37:04 +0300
Message-ID: <1274819827-27993-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3779352846085491179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/sim.c |  180 +++++++++++++++++++++++++++-----------------=
---
 drivers/isimodem/sim.h |    1 +
 2 files changed, 104 insertions(+), 77 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 6cf73d2..6f2607b 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -45,20 +45,25 @@
 =

 struct sim_data {
 	GIsiClient *client;
-	bool iccid;
 	bool registered;
 };
 =

-/* Returns fake (static) file info for EFSPN */
-static gboolean efspn_file_info(gpointer user)
+struct file_info {
+	int fileid, length, structure, record_length;
+	unsigned char access[3];
+};
+
+/* Returns file info */
+static gboolean fake_file_info(gpointer user)
 {
 	struct isi_cb_data *cbd =3D user;
 	ofono_sim_file_info_cb_t cb =3D cbd->cb;
-	unsigned char access[3] =3D { 0x0f, 0xff, 0xff };
-
-	DBG("Returning dummy file_info for EFSPN");
-	CALLBACK_WITH_SUCCESS(cb, 17, 0, 0, access, cbd->data);
+	struct file_info const *fi =3D cbd->user;
 =

+	DBG("Returning static file_info for %04x", fi->fileid);
+	CALLBACK_WITH_SUCCESS(cb,
+				fi->length, fi->structure, fi->record_length,
+				fi->access, cbd->data);
 	g_free(cbd);
 	return FALSE;
 }
@@ -66,11 +71,20 @@ static gboolean efspn_file_info(gpointer user)
 static void isi_read_file_info(struct ofono_sim *sim, int fileid,
 				ofono_sim_file_info_cb_t cb, void *data)
 {
-	if (fileid =3D=3D SIM_EFSPN_FILEID) {
-		/* Fake response for EFSPN  */
-		struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
-		g_idle_add(efspn_file_info, cbd);
-		return;
+	int i;
+	static struct file_info const info[] =3D {
+		{ SIM_EFSPN_FILEID, 17, 0, 0, { 0x0f, 0xff, 0xff } },
+		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff } },
+	};
+	int N =3D sizeof(info) / sizeof(info[0]);
+	struct isi_cb_data *cbd;
+
+	for (i =3D 0; i < N; i++) {
+		if (fileid =3D=3D info[i].fileid) {
+			cbd =3D isi_cb_data_new((void *)&info[i], cb, data);
+			g_idle_add(fake_file_info, cbd);
+			return;
+		}
 	}
 =

 	DBG("Not implemented (fileid =3D %04x)", fileid);
@@ -83,26 +97,26 @@ static bool spn_resp_cb(GIsiClient *client, const void =
*restrict data,
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
 	ofono_sim_read_cb_t cb =3D cbd->cb;
-	unsigned char spn[17] =3D { 0xff };
+	unsigned char *spn =3D NULL, buffer[17];
 	int i;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		goto error;
+		goto done;
 	}
 =

-	if (len < 39 || msg[0] !=3D SIM_SERV_PROV_NAME_RESP)
+	if (len < 39 || msg[0] !=3D SIM_SERV_PROV_NAME_RESP
+		|| msg[1] !=3D SIM_ST_READ_SERV_PROV_NAME)
 		return false;
 =

-	if (msg[1] !=3D SIM_ST_READ_SERV_PROV_NAME)
-		goto error;
-
 	if (msg[2] !=3D SIM_SERV_OK) {
 		DBG("Request failed: %s (0x%02X)",
 			sim_isi_cause_name(msg[2]), msg[2]);
-		goto error;
+		goto done;
 	}
 =

+	spn =3D buffer;
+
 	/* Set display condition bits */
 	spn[0] =3D ((msg[38] & 1) << 1) + (msg[37] & 1);
 =

@@ -115,24 +129,20 @@ static bool spn_resp_cb(GIsiClient *client, const voi=
d *restrict data,
 			c =3D '?';
 		spn[i + 1] =3D c;
 	}
-	CALLBACK_WITH_SUCCESS(cb, spn, 17, cbd->data);
-	goto out;
 =

-error:
-	DBG("Error reading SPN");
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+done:
+	if (spn)
+		CALLBACK_WITH_SUCCESS(cb, spn, 17, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 =

-out:
 	g_free(cbd);
 	return true;
 }
 =

-static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
-					int start, int length,
-					ofono_sim_read_cb_t cb, void *data)
+static bool isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cbd)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
 =

 	const unsigned char msg[] =3D {
 		SIM_SERV_PROV_NAME_REQ,
@@ -140,19 +150,73 @@ static void isi_read_file_transparent(struct ofono_si=
m *sim, int fileid,
 		0
 	};
 =

-	/* Hack support for EFSPN reading only */
-	if (fileid !=3D SIM_EFSPN_FILEID)
-		goto error;
+	return g_isi_request_make(sd->client, msg, sizeof(msg),
+					SIM_TIMEOUT, spn_resp_cb, cbd) !=3D NULL;
+}
 =

-	if (!cbd)
-		goto error;
+static bool read_iccid_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+				size_t len, uint16_t object, void *user)
+{
+	struct isi_cb_data *cbd =3D user;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	const unsigned char *msg =3D data;
+	const unsigned char *iccid =3D NULL;
 =

-	if (g_isi_request_make(sd->client, msg, sizeof(msg),
-				SIM_TIMEOUT, spn_resp_cb, cbd))
-		return;
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto done;
+	}
+
+	if (len < 3 || msg[0] !=3D SIM_READ_FIELD_RESP || msg[1] !=3D ICC)
+		return false;
+
+	if (msg[2] =3D=3D SIM_SERV_OK && len >=3D 13)
+		iccid =3D msg + 3;
+	else
+		DBG("Error reading ICC ID");
+
+done:
+	if (iccid)
+		CALLBACK_WITH_SUCCESS(cb, iccid, 10, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+
+	g_free(cbd);
+	return true;
+}
+
+static bool isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *cbd)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	const unsigned char req[] =3D { SIM_READ_FIELD_REQ, ICC };
+
+	return g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
+					read_iccid_resp_cb, cbd) !=3D NULL;
+}
+
+static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					ofono_sim_read_cb_t cb, void *data)
+{
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	DBG("fileid =3D %04x", fileid);
+
+	switch (fileid) {
+	case SIM_EFSPN_FILEID:
+		if (isi_read_spn(sim, cbd))
+			return;
+		break;
+
+	case SIM_EF_ICCID_FILEID:
+		if (isi_read_iccid(sim, cbd))
+			return;
+		break;
+
+	default:
+		DBG("Not implemented (fileid =3D %04x)", fileid);
+	}
 =

-error:
-	DBG("Not implemented (fileid =3D %04x)", fileid);
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 	g_free(cbd);
 }
@@ -287,40 +351,6 @@ static void isi_sim_register(struct ofono_sim *sim)
 	}
 }
 =

-static bool read_iccid_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
-{
-	struct ofono_sim *sim =3D opaque;
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	const unsigned char *msg =3D data;
-
-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
-	}
-
-	if (len < 3 || msg[0] !=3D SIM_READ_FIELD_RESP || msg[1] !=3D 0x66)
-		return false;
-
-	if (msg[2] =3D=3D SIM_SERV_OK)
-		sd->iccid =3D true;
-
-	return true;
-}
-
-static void isi_read_iccid(struct ofono_sim *sim)
-{
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-
-	const unsigned char req[] =3D {
-		SIM_READ_FIELD_REQ,
-		0x66 /* ICC ID */
-	};
-
-	g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
-				read_iccid_resp_cb, sim);
-}
-
 static bool read_hplmn_resp_cb(GIsiClient *client, const void *restrict da=
ta,
 				size_t len, uint16_t object, void *opaque)
 {
@@ -365,9 +395,6 @@ static void sim_ind_cb(GIsiClient *client, const void *=
restrict data,
 	if (sd->registered)
 		return;
 =

-	if (!sd->iccid)
-		isi_read_iccid(sim);
-
 	switch (msg[1]) {
 	case SIM_ST_PIN:
 		isi_sim_register(sim);
@@ -397,7 +424,6 @@ static void sim_reachable_cb(GIsiClient *client, bool a=
live,
 	g_isi_subscribe(client, SIM_IND, sim_ind_cb, opaque);
 =

 	/* Check if SIM is ready. */
-	isi_read_iccid(sim);
 	isi_read_hplmn(sim);
 }
 =

diff --git a/drivers/isimodem/sim.h b/drivers/isimodem/sim.h
index f270b95..e1450b7 100644
--- a/drivers/isimodem/sim.h
+++ b/drivers/isimodem/sim.h
@@ -151,6 +151,7 @@ enum sim_service_type {
 	READ_HPLMN =3D 0x2F,
 	READ_PARAMETER =3D 0x52,
 	UPDATE_PARAMETER =3D 0x53,
+	ICC =3D 0x66,
 };
 =

 #ifdef __cplusplus
-- =

1.6.3.3


--===============3779352846085491179==--

