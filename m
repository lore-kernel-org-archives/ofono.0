Content-Type: multipart/mixed; boundary="===============8986818739192022526=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 5/7] sim: read an image from an EFiidf
Date: Thu, 05 Aug 2010 14:32:38 -0700
Message-ID: <1281043960-9616-6-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8986818739192022526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    6 +++
 src/sim.c     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6c5a657..1303203 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -113,6 +113,9 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_sim_get_image_cb_t)(int ok, const char *xpm, int xpm_=
len,
+					void *userdata);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -177,6 +180,9 @@ enum ofono_sim_phase ofono_sim_get_phase(struct ofono_s=
im *sim);
 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
 =

+void ofono_sim_get_image(struct ofono_sim *sim, unsigned char id,
+			ofono_sim_get_image_cb_t cb, gpointer user_data);
+
 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
 				ofono_sim_state_event_notify_cb_t cb,
 				void *data, ofono_destroy_func destroy);
diff --git a/src/sim.c b/src/sim.c
index fa3823b..e19fb06 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -42,6 +42,7 @@
 #include "smsutil.h"
 #include "simutil.h"
 #include "storage.h"
+#include "stkutil.h"
 =

 #define SIM_CACHE_MODE 0600
 #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
@@ -2231,3 +2232,129 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+struct image_data {
+	struct ofono_sim *sim;
+	unsigned char width;
+	unsigned char height;
+	enum stk_img_scheme scheme;
+	unsigned short iidf_id;
+	unsigned short iidf_offset;
+	unsigned short iid_len;
+	const unsigned char *image;
+	const unsigned char *clut;
+	unsigned short clut_len;
+	gboolean need_clut;
+	ofono_sim_get_image_cb_t user_cb;
+	gpointer user_data;
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
+
+	/*
+	 * make sure everthing was ok, and that what we read matched
+	 * what we asked for.  If not, return an error to the caller
+	 */
+	if (!ok) {
+		image->user_cb(ok, NULL, 0, image->user_data);
+		goto iidf_read_out;
+	}
+
+	if (image->need_clut =3D=3D FALSE) {
+		if (image->scheme =3D=3D STK_IMG_SCHEME_BASIC)
+			image->image =3D data;
+		else
+			image->clut =3D data;
+
+		/* convert to xpm, free stuff, and call user callback */
+		xpm =3D stk_image_to_xpm(image->image, image->iid_len,
+					image->scheme, image->clut,
+					image->clut_len);
+
+		image->user_cb(ok, xpm, strlen(xpm), image->user_data);
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
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				offset, image->clut_len,
+				sim_iidf_read_cb, image);
+
+	return;
+
+iidf_read_out:
+	/* TBD - what if image->image was memduped? */
+	g_free(image);
+}
+
+static void print_image_descriptor(struct image_data *data)
+{
+	g_print("image id: 0x%x\n", data->iidf_id);
+	g_print("width: %d\n", data->width);
+	g_print("height: %d\n", data->height);
+	g_print("len: %d\n", data->iid_len);
+	g_print("iidf offset: %d\n", data->iidf_offset);
+}
+
+void ofono_sim_get_image(struct ofono_sim *sim, unsigned char id,
+			ofono_sim_get_image_cb_t cb, gpointer user_data)
+{
+	struct image_data *data;
+	unsigned char *efimg;
+
+	if (sim->efimg_length < (id * 9)) {
+		cb(-1, NULL, 0, user_data);
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
+	data->user_cb =3D cb;
+	data->user_data =3D user_data;
+	data->sim =3D sim;
+
+	print_image_descriptor(data);
+
+	if (data->scheme =3D=3D STK_IMG_SCHEME_BASIC)
+		data->need_clut =3D FALSE;
+	else
+		data->need_clut =3D TRUE;
+
+	/* read the image data */
+	ofono_sim_read_bytes(sim, data->iidf_id,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				data->iidf_offset, data->iid_len,
+				sim_iidf_read_cb, data);
+}
-- =

1.7.1.1


--===============8986818739192022526==--

