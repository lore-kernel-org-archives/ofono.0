Content-Type: multipart/mixed; boundary="===============2285215873063747657=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 6/6] gprs-provision: add example context provisioning driver
Date: Thu, 20 Jan 2011 15:11:39 +0200
Message-ID: <1295529099-21082-7-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295529099-21082-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2285215873063747657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 +
 examples/provision.c |  221 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 examples/provision.c

diff --git a/Makefile.am b/Makefile.am
index 97480d5..7a87aee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -327,6 +327,9 @@ builtin_sources +=3D examples/history.c
 =

 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
+
+builtin_modules +=3D example_provision
+builtin_sources +=3D examples/provision.c
 endif
 =

 builtin_modules +=3D smart_messaging
diff --git a/examples/provision.c b/examples/provision.c
new file mode 100644
index 0000000..d84c4ba
--- /dev/null
+++ b/examples/provision.c
@@ -0,0 +1,221 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#include <string.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include <ofono/modem.h>
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/gprs-provision.h>
+#include <ofono/types.h>
+
+#include "ofono.h"
+#include "common.h"
+#include "sim.h"
+#include "simutil.h"
+#include "util.h"
+
+struct provisioning_request {
+	struct ofono_modem *modem;
+	ofono_gprs_provision_cb_t cb;
+	void *user_data;
+};
+
+static int example_provision_probe(struct ofono_gprs_provision_context *co=
ntext)
+{
+	ofono_debug("Example GPRS context provisioning Probe for modem: %p",
+			context->modem);
+	return 0;
+}
+
+static void example_provision_remove(
+		struct ofono_gprs_provision_context *context)
+{
+	ofono_debug("Example GPRS context provisioning Remove for modem: %p",
+			context->modem);
+}
+
+static void provision_settings_free(struct ofono_gprs_provision_data *sett=
ings,
+					int count)
+{
+	int i;
+
+	for (i =3D 0; i < count; i++) {
+		g_free(settings[i].name);
+		g_free(settings[i].apn);
+		g_free(settings[i].username);
+		g_free(settings[i].password);
+		g_free(settings[i].message_proxy);
+		g_free(settings[i].message_center);
+	}
+
+	g_free(settings);
+}
+
+/* Example settings for phonesim */
+static void example_settings(const char *mcc, const char *mnc, const char =
*spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	*count =3D 0;
+	*settings =3D NULL;
+
+	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
+			mcc, mnc, spn);
+
+	if (strcmp(mcc, "246") !=3D 0 || strcmp(mnc, "81") !=3D 0 ||
+			spn =3D=3D NULL || strcmp(spn, "oFono") !=3D 0)
+		return;
+
+	ofono_debug("Creating example settings for phonesim");
+
+	*settings =3D g_try_new0(struct ofono_gprs_provision_data, 2);
+	if (*settings =3D=3D NULL)
+		return;
+
+	*count =3D 2;
+
+	/* Internet context settings */
+	(*settings)[0].proto =3D OFONO_GPRS_PROTO_IP;
+	(*settings)[0].type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	(*settings)[0].name =3D g_strdup("Phonesim Internet");
+	(*settings)[0].apn =3D g_strdup("internetapn");
+
+	/* MMS context settings */
+	(*settings)[1].proto =3D OFONO_GPRS_PROTO_IP;
+	(*settings)[1].type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	(*settings)[1].name =3D g_strdup("Phonesim MMS");
+	(*settings)[1].apn =3D g_strdup("mmsapn");
+	(*settings)[1].username =3D g_strdup("mmsuser");
+	(*settings)[1].password =3D g_strdup("mmspass");
+	(*settings)[1].message_proxy =3D g_strdup("10.11.12.13:8080");
+	(*settings)[1].message_center =3D g_strdup("http://mms.example.com:8000");
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct provisioning_request *req =3D user_data;
+
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim;
+	const char *mcc;
+	const char *mnc;
+	char *spn =3D NULL;
+	struct ofono_gprs_provision_data *settings =3D NULL;
+	int count =3D 0;
+
+	sim_atom =3D __ofono_modem_find_atom(req->modem, OFONO_ATOM_TYPE_SIM);
+	if (sim_atom =3D=3D NULL) {
+		ofono_debug("No SIM atom");
+		goto finish;
+	}
+
+	sim =3D __ofono_atom_get_data(sim_atom);
+	mcc =3D ofono_sim_get_mcc(sim);
+	mnc =3D ofono_sim_get_mnc(sim);
+	if (mcc =3D=3D NULL || strlen(mcc) =3D=3D 0 ||
+			mnc =3D=3D NULL || strlen(mnc) =3D=3D 0) {
+		ofono_debug("No MCC/MNC available");
+		goto finish;
+	}
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	example_settings(mcc, mnc, spn, &settings, &count);
+
+finish:
+	g_free(spn);
+	req->cb(settings, count, req->user_data);
+	provision_settings_free(settings, count);
+	g_free(req);
+}
+
+static void example_provision_get_settings(
+		struct ofono_gprs_provision_context *driver_context,
+		ofono_gprs_provision_cb_t cb,
+		void *user_data)
+{
+	struct provisioning_request *req;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	if (cb =3D=3D NULL)
+		return;
+
+	ofono_debug("Provisioning...");
+
+	req =3D g_try_new0(struct provisioning_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->modem =3D driver_context->modem;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	/* Start SPN query from SIM */
+	sim_atom =3D __ofono_modem_find_atom(req->modem, OFONO_ATOM_TYPE_SIM);
+	if (sim_atom !=3D NULL)
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+	if (sim !=3D NULL) {
+		ofono_sim_read(sim, SIM_EFSPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_spn_read_cb, req);
+		return;
+	}
+
+error:
+	cb(NULL, 0, user_data);
+	g_free(req);
+}
+
+static struct ofono_gprs_provision_driver example_driver =3D {
+	.name		=3D "Example GPRS context provisioning",
+	.priority       =3D OFONO_PLUGIN_PRIORITY_LOW,
+	.probe		=3D example_provision_probe,
+	.remove		=3D example_provision_remove,
+	.get_settings	=3D example_provision_get_settings,
+};
+
+static int example_provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&example_driver);
+}
+
+static void example_provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&example_driver);
+}
+
+OFONO_PLUGIN_DEFINE(example_provision, "Example Provisioning Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			example_provision_init,
+			example_provision_exit)
-- =

1.7.1


--===============2285215873063747657==--

