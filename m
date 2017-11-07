Content-Type: multipart/mixed; boundary="===============7062286762714003854=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/3] atmodem: implemented logical access driver API
Date: Tue, 07 Nov 2017 08:42:50 -0800
Message-ID: <1510072970-19030-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510072970-19030-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7062286762714003854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This moves the logical access API from the simauth
driver to the sim atmodem driver.
---
 drivers/atmodem/sim.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7508281..4af51ef 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -74,6 +74,7 @@ static const char *upincnt_prefix[] =3D { "+UPINCNT:", NU=
LL };
 static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
 static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
 static const char *crla_prefix[] =3D { "+CRLA:", NULL };
+static const char *cgla_prefix[] =3D { "+CGLA:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void append_file_path(char *buf, const unsigned char *path,
@@ -1871,6 +1872,70 @@ static void at_session_read_info(struct ofono_sim *s=
im, int session_id,
 				EF_STATUS_INVALIDATED, data);
 }
 =

+static void logical_access_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_logical_access_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char *str_data;
+	unsigned char *raw;
+	gint len =3D 0;
+	GAtResultIter iter;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGLA:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &len))
+		goto error;
+
+	if (!g_at_result_iter_next_string(&iter, &str_data))
+		goto error;
+
+	raw =3D alloca(len / 2);
+
+	decode_hex_own_buf(str_data, len, NULL, 0, raw);
+
+	cb(&error, raw, len / 2, cbd->data);
+
+	return;
+
+error:
+	cb(&error, NULL, 0, cbd->data);
+}
+
+static void at_logical_access(struct ofono_sim *sim, int session_id,
+		const unsigned char *pdu, unsigned int len,
+		ofono_sim_logical_access_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int ret =3D 0;
+	char cmd[(len * 2) + 19];
+
+	ret =3D sprintf(cmd, "AT+CGLA=3D%d,%d,\"", session_id, len * 2);
+
+	encode_hex_own_buf(pdu, len, 0, cmd + ret);
+	ret +=3D len * 2;
+
+	strcpy(cmd + ret, "\"");
+
+	if (g_at_chat_send(sd->chat, cmd, cgla_prefix, logical_access_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
 static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
 				void *data)
 {
@@ -1936,6 +2001,7 @@ static struct ofono_sim_driver driver =3D {
 	.session_read_binary	=3D at_session_read_binary,
 	.session_read_record	=3D at_session_read_record,
 	.session_read_info	=3D at_session_read_info,
+	.logical_access		=3D at_logical_access
 };
 =

 static struct ofono_sim_driver driver_noef =3D {
-- =

2.7.4


--===============7062286762714003854==--

