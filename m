Content-Type: multipart/mixed; boundary="===============0419814147839507386=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 4/6] mbm: add location-reporting atom
Date: Tue, 22 Feb 2011 15:35:13 -0300
Message-ID: <1298399715-9617-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0419814147839507386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>

---
 plugins/mbm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 2ab80b4..105843f 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -46,6 +46,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/log.h>
+#include <ofono/location-reporting.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -67,6 +68,7 @@ struct mbm_data {
 	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct ofono_location_reporting *lr;
 	guint reopen_source;
 	enum mbm_variant variant;
 };
@@ -510,9 +512,15 @@ static void mbm_post_online(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs_context *gc;
+	const char *gps_dev;
 =

 	DBG("%p", modem);
 =

+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+	if (gps_dev)
+		data->lr =3D ofono_location_reporting_create(modem, 0,
+					"mbmmodem", data->modem_port);
+
 	ofono_netreg_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->modem_port);
 =

-- =

1.7.4.1


--===============0419814147839507386==--

