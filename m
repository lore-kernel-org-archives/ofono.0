Content-Type: multipart/mixed; boundary="===============7284930503247416637=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 4/6] isimodem: add support for FastDormancy property
Date: Mon, 25 Oct 2010 16:28:08 +0300
Message-ID: <1288013290-6124-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288013290-6124-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7284930503247416637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/radio-settings.c |   91 +++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 90 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index d220476..558e032 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -41,11 +41,16 @@
 #include "isimodem.h"
 #include "isiutil.h"
 #include "debug.h"
+#include "gpds.h"
 #include "gss.h"
 #include "network.h"
 =

+#define PN_WRAN 0xb4
+
 struct radio_data {
 	GIsiClient *client;
+	uint16_t wran_object;
+	uint16_t quick_release:1;
 };
 =

 static enum ofono_radio_access_mode isi_mode_to_ofono_mode(guint8 mode)
@@ -236,6 +241,65 @@ error:
 	g_free(cbd);
 }
 =

+static void update_fast_dormancy(struct radio_data *rd)
+{
+	struct sockaddr_pn dst =3D {
+		.spn_family =3D AF_PHONET,
+		.spn_resource =3D 0x3a,
+		.spn_dev =3D rd->wran_object >> 8,
+		.spn_obj =3D rd->wran_object & 0xff,
+	};
+
+	if (!rd->wran_object)
+		return;
+
+	if (rd->quick_release) {
+		const unsigned char msg[] =3D {
+			0x1f, 0x00, 0x01, 0x01, 0x01, 0x00
+		};
+
+		g_isi_sendto(rd->client, &dst, msg, sizeof(msg), 0,
+				NULL, NULL, NULL);
+	} else {
+		const unsigned char msg[] =3D {
+			0x1f, 0x00, 0x01, 0x01, 0x02, 0x0a
+		};
+
+		g_isi_sendto(rd->client, &dst, msg, sizeof(msg), 0,
+				NULL, NULL, NULL);
+	}
+
+	DBG("3G PS quick release %s",
+		rd->quick_release ? "enabled" : "disabled");
+}
+
+static void gpds_context_activating_ind_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	struct radio_data *rd =3D opaque;
+	update_fast_dormancy(rd);
+}
+
+static void isi_query_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	CALLBACK_WITH_SUCCESS(cb, rd->quick_release, data);
+}
+
+static void isi_set_fast_dormancy(struct ofono_radio_settings *rs,
+				int enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	rd->quick_release =3D enable;
+	update_fast_dormancy(rd);
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
 static gboolean isi_radio_settings_register(gpointer user)
 {
 	struct ofono_radio_settings *rs =3D user;
@@ -249,9 +313,31 @@ static gboolean isi_radio_settings_register(gpointer u=
ser)
 =

 	ofono_radio_settings_register(rs);
 =

+	g_isi_add_subscription(rd->client,
+				PN_GPDS, GPDS_CONTEXT_ACTIVATING_IND,
+				gpds_context_activating_ind_cb, rd);
+	g_isi_commit_subscriptions(rd->client);
+
 	return FALSE;
 }
 =

+static void wran_reachable_cb(GIsiClient *client, gboolean alive,
+				uint16_t object, void *opaque)
+{
+	struct radio_data *rd =3D opaque;
+
+	if (!alive) {
+		DBG("fast dormancy support disabled");
+		return;
+	}
+
+	rd->wran_object =3D object;
+
+	DBG("PN_WRAN reachable, object=3D0x%04x", object);
+
+	update_fast_dormancy(rd);
+}
+
 static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
@@ -289,6 +375,7 @@ static int isi_radio_settings_probe(struct ofono_radio_=
settings *rs,
 	ofono_radio_settings_set_data(rs, rd);
 =

 	g_isi_verify(rd->client, reachable_cb, rs);
+	g_isi_verify_resource(rd->client, PN_WRAN, wran_reachable_cb, rd);
 =

 	return 0;
 }
@@ -310,7 +397,9 @@ static struct ofono_radio_settings_driver driver =3D {
 	.probe			=3D isi_radio_settings_probe,
 	.remove			=3D isi_radio_settings_remove,
 	.query_rat_mode		=3D isi_query_rat_mode,
-	.set_rat_mode		=3D isi_set_rat_mode
+	.set_rat_mode		=3D isi_set_rat_mode,
+	.query_fast_dormancy	=3D isi_query_fast_dormancy,
+	.set_fast_dormancy	=3D isi_set_fast_dormancy,
 };
 =

 void isi_radio_settings_init()
-- =

1.7.0.4


--===============7284930503247416637==--

