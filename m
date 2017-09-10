Content-Type: multipart/mixed; boundary="===============3295741611835508649=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH v2] qmimodem: implement SIM write functions
Date: Sat, 09 Sep 2017 22:48:53 -0700
Message-ID: <20170912055903.561D960F2C@rivendell.scintill.net>
In-Reply-To: <473f6daa-c2da-0389-24d6-f8c51407a591@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3295741611835508649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi Denis,

Sorry about the style issues. I think I've cleaned them all up
here, and implemented the other tweaks.

-Joey

 drivers/qmimodem/sim.c | 121 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 8d40028..71c7e04 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -317,6 +317,124 @@ error:
 	g_free(cbd);
 }
 =

+static void write_generic_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	uint16_t len;
+	const uint8_t *card_result;
+	uint8_t sw1, sw2;
+
+	card_result =3D qmi_result_get(result, 0x10, &len);
+	if (card_result =3D=3D NULL || len !=3D 2) {
+		DBG("card_result: %p, len: %d", card_result, (int) len);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	sw1 =3D card_result[0];
+	sw2 =3D card_result[1];
+
+	DBG("%02x, %02x", sw1, sw2);
+
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		struct ofono_error error;
+
+		ofono_error("%s: error sw1 %02x sw2 %02x", __func__, sw1, sw2);
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void write_generic(struct ofono_sim *sim,
+			uint16_t qmi_message, int fileid,
+			int start_or_recordnum,
+			int length, const unsigned char *value,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_write_cb_t cb, void *user_data)
+{
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	unsigned char aid_data[2] =3D { 0x00, 0x00 };
+	unsigned char write_data[4 + length];
+	unsigned char fileid_data[9];
+	int fileid_len;
+	struct qmi_param *param;
+
+	DBG("file id 0x%04x path len %d", fileid, path_len);
+
+	fileid_len =3D create_fileid_data(data->app_type, fileid,
+			path, path_len, fileid_data);
+
+	if (fileid_len < 0)
+		goto error;
+
+	write_data[0] =3D start_or_recordnum & 0xff;
+	write_data[1] =3D (start_or_recordnum & 0xff00) >> 8;
+	write_data[2] =3D length & 0xff;
+	write_data[3] =3D (length & 0xff00) >> 8;
+	memcpy(&write_data[4], value, length);
+
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	qmi_param_append(param, 0x01, sizeof(aid_data), aid_data);
+	qmi_param_append(param, 0x02, fileid_len, fileid_data);
+	qmi_param_append(param, 0x03, 4 + length, write_data);
+
+	if (qmi_service_send(data->uim, qmi_message, param,
+					write_generic_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, user_data);
+
+	g_free(cbd);
+}
+
+static void qmi_write_transparent(struct ofono_sim *sim,
+				int fileid, int start, int length,
+				const unsigned char *value,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_write_cb_t cb, void *user_data)
+{
+	write_generic(sim, QMI_UIM_WRITE_TRANSPARENT, fileid, start,
+				length, value, path, path_len, cb, user_data);
+}
+
+static void qmi_write_linear(struct ofono_sim *sim,
+				int fileid, int record, int length,
+				const unsigned char *value,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_write_cb_t cb, void *user_data)
+{
+	write_generic(sim, QMI_UIM_WRITE_RECORD, fileid, record,
+				length, value, path, path_len, cb, user_data);
+}
+
+static void qmi_write_cyclic(struct ofono_sim *sim,
+				int fileid, int length,
+				const unsigned char *value,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_write_cb_t cb, void *user_data)
+{
+	write_generic(sim, QMI_UIM_WRITE_RECORD, fileid, 0,
+				length, value, path, path_len, cb, user_data);
+}
+
 static void get_imsi_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -777,6 +895,9 @@ static struct ofono_sim_driver driver =3D {
 	.read_file_transparent	=3D qmi_read_transparent,
 	.read_file_linear	=3D qmi_read_record,
 	.read_file_cyclic	=3D qmi_read_record,
+	.write_file_transparent =3D qmi_write_transparent,
+	.write_file_linear	=3D qmi_write_linear,
+	.write_file_cyclic	=3D qmi_write_cyclic,
 	.read_imsi		=3D qmi_read_imsi,
 	.query_passwd_state	=3D qmi_query_passwd_state,
 	.query_pin_retries	=3D qmi_query_pin_retries,
-- =

2.7.4


--===============3295741611835508649==--

