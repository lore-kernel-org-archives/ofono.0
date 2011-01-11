Content-Type: multipart/mixed; boundary="===============0629417128945487748=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 6/9] plugins: add gps atom to mbm
Date: Tue, 11 Jan 2011 00:23:55 -0300
Message-ID: <1294716238-21218-7-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0629417128945487748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index dca9bd8..7ab3406 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -45,6 +45,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
+#include <ofono/gps.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -66,6 +67,7 @@ struct mbm_data {
 	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct ofono_gps *gps;
 	guint reopen_source;
 	enum mbm_variant variant;
 };
@@ -502,9 +504,15 @@ static void mbm_post_online(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs_context *gc;
+	const char *gps_dev;
 =

 	DBG("%p", modem);
 =

+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	if (gps_dev)
+		data->gps =3D ofono_gps_create(modem, 0,
+					"mbmmodem", data->modem_port);
+
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->modem_port);
 =

-- =

1.7.2.3


--===============0629417128945487748==--

