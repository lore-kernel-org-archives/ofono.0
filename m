Content-Type: multipart/mixed; boundary="===============0205920122681088727=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Mon, 10 Jan 2011 15:11:12 +0200
Message-ID: <1294665072-13630-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294665072-13630-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0205920122681088727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 +
 examples/provision.c |  198 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 examples/provision.c

diff --git a/Makefile.am b/Makefile.am
index 0f330a7..d57509d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -305,6 +305,9 @@ builtin_sources +=3D examples/history.c
 =

 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
+
+builtin_modules +=3D example_gprs_provision
+builtin_sources +=3D examples/provision.c
 endif
 =

 builtin_modules +=3D smart_messaging
diff --git a/examples/provision.c b/examples/provision.c
new file mode 100644
index 0000000..f075734
--- /dev/null
+++ b/examples/provision.c
@@ -0,0 +1,198 @@
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
+	void *userdata;
+};
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct provisioning_request *req =3D userdata;
+	char *spn =3D NULL;
+
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim;
+	const char *imsi;
+
+	unsigned char mnc_length;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+
+	GSList *settings =3D NULL;
+	struct ofono_gprs_provisioning_data *entry;
+
+	sim_atom =3D __ofono_modem_find_atom(req->modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom =3D=3D NULL) {
+		ofono_debug("No SIM atom");
+		goto finish;
+	}
+
+	sim =3D __ofono_atom_get_data(sim_atom);
+	imsi =3D ofono_sim_get_imsi(sim);
+	if (imsi =3D=3D NULL) {
+		ofono_debug("No IMSI available");
+		goto finish;
+	}
+
+	mnc_length =3D ofono_sim_get_mnc_length(sim);
+	if (mnc_length =3D=3D 0) {
+		ofono_debug("No MNC length available");
+		goto finish;
+	}
+
+	strncpy(mcc, imsi, OFONO_MAX_MCC_LENGTH);
+	mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+	strncpy(mnc, imsi + OFONO_MAX_MCC_LENGTH, mnc_length);
+	mnc[mnc_length] =3D '\0';
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
+			mcc, mnc, spn);
+
+	if (spn =3D=3D NULL || strcmp(spn, "oFono") !=3D 0)
+		goto finish;
+
+	/* Example settings for Phonesim */
+	ofono_debug("Creating example settings for phonesim");
+
+	/* MMS context settings */
+	entry =3D g_try_new0(struct ofono_gprs_provisioning_data, 1);
+	if (entry =3D=3D NULL)
+		goto finish;
+
+	entry->proto =3D OFONO_GPRS_PROTO_IP;
+	entry->type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	entry->name =3D g_strdup("Phonesim MMS");
+	entry->apn =3D g_strdup("mmsapn");
+	entry->username =3D g_strdup("mmsuser");
+	entry->password =3D g_strdup("mmspass");
+	entry->message_proxy =3D g_strdup("10.11.12.13:8080");
+	entry->message_center =3D g_strdup("http://mms.example.com:8000");
+	settings =3D g_slist_prepend(settings, entry);
+
+	/* Internet context settings */
+	entry =3D g_try_new0(struct ofono_gprs_provisioning_data, 1);
+	if (entry =3D=3D NULL)
+		goto finish;
+
+	entry->proto =3D OFONO_GPRS_PROTO_IP;
+	entry->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	entry->name =3D g_strdup("Phonesim Internet");
+	entry->apn =3D g_strdup("internetapn");
+	settings =3D g_slist_prepend(settings, entry);
+
+finish:
+	g_free(spn);
+
+	if (req->cb !=3D NULL)
+		req->cb(settings, req->userdata);
+
+	g_free(req);
+}
+
+
+
+static void example_gprs_provision_get_settings(
+	struct ofono_modem *modem,
+	ofono_gprs_provision_cb_t cb,
+	void *userdata)
+{
+	struct provisioning_request *req;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	ofono_debug("Provisioning...");
+
+	req =3D g_try_new0(struct provisioning_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->modem =3D modem;
+	req->cb =3D cb;
+	req->userdata =3D userdata;
+
+	/* Start SPN query from SIM */
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
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
+	if (cb !=3D NULL)
+		cb(NULL, userdata);
+}
+
+
+static struct ofono_gprs_provision_driver example_driver =3D {
+	.name		=3D "Example GPRS context provisioning",
+	.priority       =3D OFONO_PLUGIN_PRIORITY_LOW,
+	.get_settings	=3D example_gprs_provision_get_settings,
+};
+
+static int example_gprs_provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&example_driver);
+}
+
+static void example_gprs_provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&example_driver);
+}
+
+OFONO_PLUGIN_DEFINE(example_gprs_provision, "Example Network Time Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			example_gprs_provision_init,
+			example_gprs_provision_exit)
-- =

1.7.1


--===============0205920122681088727==--

