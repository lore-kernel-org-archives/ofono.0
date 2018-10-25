Content-Type: multipart/mixed; boundary="===============3349784725939220030=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v2] atmodem/atutil.h: cb_data ref/unref possibility
Date: Thu, 25 Oct 2018 07:46:27 +0200
Message-ID: <20181025054627.27462-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3349784725939220030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

the cb_data can be used by creating the structure with cb_data_new,
and then there are two possibilities:
- use it in a single callback function, and destroy it with a call to
  g_free.
  Example:
  - calling function:
    struct cb_data *cbd =3D cb_data_new(cb, data);
    if (g_at_chat_send(chat, buf, NULL, at_cgatt_cb, cbd, g_free) > 0)
	return;
    g_free(cbd);
  - called function (here at_cgatt_cb):
	static void at_cgatt_cb(gboolean ok, GAtResult *result,
						gpointer user_data)
	{
		struct cb_data *cbd =3D user_data;
		ofono_gprs_cb_t cb =3D cbd->cb;
		struct ofono_error error;

		decode_at_error(&error,
				g_at_result_final_response(result));

		cb(&error, cbd->data);
	}
    note the absence of explicit g_free(cbd);

- pass it through a train of callback functions, adding a reference at
  each pass cb_data_ref, and removing it with cb_data_unref.
  the use of cb_data_ref would replace a new object creation, while the
  use of cb_data_unref the use of g_free.
  Example:
  - calling function:
	struct cb_data *cbd =3D cb_data_new(cb, data);
	// no cb_ref at the creation
	if (g_at_chat_send(chat, buf, NULL,
				at_lte_set_default_attach_info_cb,
				cbd, cb_data_unref) > 0)
		goto end;
	cb_data_unref(cbd);
  - called function 1 (at_lte_set_default_attach_info_cb):
	static void at_lte_set_default_attach_info_cb(gboolean ok,
				GAtResult *result, gpointer user_data)
	{
		struct cb_data *cbd =3D user_data;

		cbd =3D cb_data_ref(cbd);
		if (g_at_chat_send(chat, buf, NULL,
				at_cgatt_cb, cbd, cb_data_unref) > 0)
			return;
		cb_data_unref(cbd);
	}
  - called function 2 (at_cgatt_cb):
    like above. no call to g_free or cb_data_unref. The terminal function
    doesn't need to know about the reference scheme.

v2: fixed prototype for cb_data_unref to be compatible with g_free
---
 drivers/atmodem/atutil.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index f1389a94..aa8b619c 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -104,6 +104,7 @@ char *at_util_get_cgdcont_command(guint cid, enum ofono=
_gprs_proto proto,
 							const char *apn);
 =

 struct cb_data {
+	gint ref_count;
 	void *cb;
 	void *data;
 	void *user;
@@ -114,12 +115,37 @@ static inline struct cb_data *cb_data_new(void *cb, v=
oid *data)
 	struct cb_data *ret;
 =

 	ret =3D g_new0(struct cb_data, 1);
+	ret->ref_count =3D 1;
 	ret->cb =3D cb;
 	ret->data =3D data;
 =

 	return ret;
 }
 =

+static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
+{
+	if (cbd =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&cbd->ref_count);
+
+	return cbd;
+}
+
+static inline void cb_data_unref(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	gboolean is_zero;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
+
+	if (is_zero =3D=3D TRUE)
+		g_free(cbd);
+}
+
 static inline int at_util_convert_signal_strength(int strength)
 {
 	int result;
-- =

2.17.1


--===============3349784725939220030==--

