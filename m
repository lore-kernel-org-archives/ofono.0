Content-Type: multipart/mixed; boundary="===============5778241977077974825=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/4] sim: implement GetIcon
Date: Mon, 04 Oct 2010 15:33:20 -0700
Message-ID: <1286231602-18692-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1286231602-18692-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5778241977077974825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 6f10d4c..a671a8d 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -43,6 +43,7 @@
 #include "simutil.h"
 #include "storage.h"
 #include "simfs.h"
+#include "stkutil.h"
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -721,6 +722,190 @@ static DBusMessage *sim_enter_pin(DBusConnection *con=
n, DBusMessage *msg,
 	return NULL;
 }
 =

+static void sim_get_image_cb(gboolean ok, const char *xpm, int xpm_len,
+					void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	DBusMessage *reply;
+
+	if (!ok)
+		reply =3D __ofono_error_failed(sim->pending);
+	else {
+		reply =3D dbus_message_new_method_return(sim->pending);
+		dbus_message_append_args(reply, DBUS_TYPE_STRING, &xpm,
+					DBUS_TYPE_INVALID);
+	}
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
+struct image_data {
+	struct ofono_sim *sim;
+	unsigned char width;
+	unsigned char height;
+	enum stk_img_scheme scheme;
+	unsigned short iidf_id;
+	unsigned short iidf_offset;
+	unsigned short iid_len;
+	void *image;
+	unsigned short clut_len;
+	gboolean need_clut;
+	gpointer user_data;
+	unsigned char id;
+};
+
+static void sim_iidf_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct image_data *image =3D userdata;
+	unsigned short offset;
+	unsigned short num_entries;
+	char *xpm;
+	struct ofono_sim *sim =3D image->sim;
+
+	if (!ok) {
+		sim_get_image_cb(ok, NULL, 0, image->user_data);
+		goto iidf_read_out;
+	}
+
+	if (image->need_clut =3D=3D FALSE) {
+		if (image->scheme =3D=3D STK_IMG_SCHEME_BASIC) {
+			xpm =3D stk_image_to_xpm(data, image->iid_len,
+						image->scheme, NULL, 0);
+		} else {
+			xpm =3D stk_image_to_xpm(image->image, image->iid_len,
+						image->scheme, data,
+						image->clut_len);
+		}
+
+		if (xpm =3D=3D NULL) {
+			sim_get_image_cb(0, NULL, 0, image->user_data);
+			goto iidf_read_out;
+		}
+
+		sim_fs_cache_image(sim->simfs, (const char *) xpm,
+					image->id);
+
+		sim_get_image_cb(ok, xpm, strlen(xpm), image->user_data);
+
+		g_free(xpm);
+
+		goto iidf_read_out;
+	}
+
+	offset =3D data[4] << 8 | data[5];
+	num_entries =3D data[3];
+
+	if (num_entries =3D=3D 0)
+		num_entries =3D 256;
+
+	/* indicate that we're on our second read */
+	image->need_clut =3D FALSE;
+
+	image->clut_len =3D num_entries * 3;
+
+	image->image =3D g_memdup(data, length);
+
+	/* read the clut data */
+	ofono_sim_read_bytes(image->sim, image->iidf_id,
+				offset, image->clut_len,
+				sim_iidf_read_cb, image);
+
+	return;
+
+iidf_read_out:
+	g_free(image->image);
+	g_free(image);
+}
+
+static void sim_get_image(struct ofono_sim *sim, unsigned char id,
+			gpointer user_data)
+{
+	struct image_data *data;
+	unsigned char *efimg;
+	char *image;
+
+	/* icon ids should start at 1, our array starts at zero */
+	if (id =3D=3D 0) {
+		sim_get_image_cb(0, NULL, 0, user_data);
+		return;
+	}
+
+	id--;
+
+	image =3D sim_fs_get_cached_image(sim->simfs, id);
+
+	if (image =3D=3D NULL)
+		goto read_image;
+
+	sim_get_image_cb(1, image, strlen(image), user_data);
+
+	g_free(image);
+
+	return;
+
+read_image:
+
+	if (sim->efimg_length <=3D (id * 9)) {
+		sim_get_image_cb(0, NULL, 0, user_data);
+		return;
+	}
+
+	efimg =3D &sim->efimg[id * 9];
+
+	data =3D g_try_new0(struct image_data, 1);
+	if (data =3D=3D NULL)
+		return;
+
+	data->width =3D efimg[0];
+	data->height =3D efimg[1];
+	data->scheme =3D efimg[2];
+	data->iidf_id =3D efimg[3] << 8 | efimg[4];
+	data->iidf_offset =3D efimg[5] << 8 | efimg[6];
+	data->iid_len =3D efimg[7] << 8 | efimg[8];
+	data->user_data =3D user_data;
+	data->sim =3D sim;
+	data->id =3D id;
+
+	if (data->scheme =3D=3D STK_IMG_SCHEME_BASIC)
+		data->need_clut =3D FALSE;
+	else
+		data->need_clut =3D TRUE;
+
+	/* read the image data */
+	ofono_sim_read_bytes(sim, data->iidf_id,
+				data->iidf_offset, data->iid_len,
+				sim_iidf_read_cb, data);
+}
+
+static DBusMessage *sim_get_icon(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	unsigned char id;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &id,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	/* zero means no icon */
+	if (id =3D=3D 0)
+		return __ofono_error_invalid_args(msg);
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	if (sim->efimg =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	sim->pending =3D dbus_message_ref(msg);
+
+	sim_get_image(sim, id, sim);
+
+	return NULL;
+}
+
 static DBusMessage *sim_reset_pin(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -773,6 +958,8 @@ static GDBusMethodTable sim_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "UnlockPin",		"ss",	"",		sim_unlock_pin,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetIcon",		"y",	"s",		sim_get_icon,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

-- =

1.7.2.1


--===============5778241977077974825==--

