Content-Type: multipart/mixed; boundary="===============8619237916857852416=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/3] tools: Add utility for looking CDMA network name from
 database
Date: Tue, 15 Nov 2011 14:04:15 +0100
Message-ID: <1321362255-11262-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1321362255-11262-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8619237916857852416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    7 ++-
 tools/lookup-provider-name.c |  104 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 110 insertions(+), 1 deletions(-)
 create mode 100644 tools/lookup-provider-name.c

diff --git a/Makefile.am b/Makefile.am
index a28f790..337aeb7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -627,7 +627,8 @@ TESTS =3D $(unit_tests)
 =

 if TOOLS
 noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable \
-			tools/get-location tools/lookup-apn
+			tools/get-location tools/lookup-apn \
+			tools/lookup-provider-name
 =

 tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/huawei-audio.c
 tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
@@ -640,6 +641,10 @@ tools_get_location_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_lookup_apn_SOURCES =3D plugins/mbpi.c plugins/mbpi.h tools/lookup-ap=
n.c
 tools_lookup_apn_LDADD =3D @GLIB_LIBS@
+
+tools_lookup_provider_name_SOURCES =3D plugins/mbpi.c plugins/mbpi.h \
+				tools/lookup-provider-name.c
+tools_lookup_provider_name_LDADD =3D @GLIB_LIBS@
 endif
 =

 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
diff --git a/tools/lookup-provider-name.c b/tools/lookup-provider-name.c
new file mode 100644
index 0000000..dc91ae5
--- /dev/null
+++ b/tools/lookup-provider-name.c
@@ -0,0 +1,104 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+
+#include "plugins/mbpi.h"
+
+static void lookup_cdma_provider_name(const char *match_sid)
+{
+	GError *error =3D NULL;
+	char *name;
+
+	g_print("Searching for serving network name with SID: %s\n", match_sid);
+
+	name =3D mbpi_lookup_cdma_provider_name(match_sid, &error);
+
+	if (name =3D=3D NULL) {
+		if (error !=3D NULL) {
+			g_printerr("Lookup failed: %s\n", error->message);
+			g_error_free(error);
+		}
+		else
+			g_printerr("Not found\n");
+
+		return;
+	}
+
+	g_print("CDMA provider name: %s\n", name);
+
+	g_free(name);
+}
+
+static gboolean option_version =3D FALSE;
+static gboolean option_duplicates =3D FALSE;
+
+static GOptionEntry options[] =3D {
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit" },
+	{ "allow-duplicates", 0, 0, G_OPTION_ARG_NONE, &option_duplicates,
+				"Allow duplicate access point types" },
+	{ NULL },
+};
+
+int main(int argc, char **argv)
+{
+	GOptionContext *context;
+	GError *error =3D NULL;
+
+	context =3D g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &error) =3D=3D FALSE) {
+		if (error !=3D NULL) {
+			g_printerr("%s\n", error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+		exit(1);
+	}
+
+	g_option_context_free(context);
+
+	if (option_version =3D=3D TRUE) {
+		g_print("%s\n", VERSION);
+		exit(0);
+	}
+
+	if (argc < 1) {
+		g_printerr("Missing parameters\n");
+		exit(1);
+	}
+
+	lookup_cdma_provider_name(argv[1]);
+
+	return 0;
+}
-- =

1.7.1


--===============8619237916857852416==--

