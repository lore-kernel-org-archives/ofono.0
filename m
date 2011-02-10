Content-Type: multipart/mixed; boundary="===============8464971713747951760=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH] Gprs context settings provisioning plugin
Date: Thu, 10 Feb 2011 14:54:50 +0200
Message-ID: <1297342490-8123-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1297342490-8123-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464971713747951760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                    |    3 +
 plugins/context-provisioning.c |  418 ++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 421 insertions(+), 0 deletions(-)
 create mode 100644 plugins/context-provisioning.c

diff --git a/Makefile.am b/Makefile.am
index 42ad86f..18938b6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -347,6 +347,9 @@ builtin_sources +=3D plugins/smart-messaging.c
 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

+builtin_modules +=3D context_provisioning
+builtin_sources +=3D plugins/context-provisioning.c
+
 sbin_PROGRAMS =3D src/ofonod
 =

 src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) src/ofono.ver \
diff --git a/plugins/context-provisioning.c b/plugins/context-provisioning.c
new file mode 100644
index 0000000..4dcb373
--- /dev/null
+++ b/plugins/context-provisioning.c
@@ -0,0 +1,418 @@
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
+#include <stdlib.h>
+#include <string.h>
+#include <glib.h>
+
+#include <errno.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include "ofono.h"
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+#include <ofono/types.h>
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+
+#define OPERATOR_SETTINGS_DIR "operator-settings"
+
+struct parser_data {
+	const gchar *mcc;
+	const gchar *mnc;
+	GSList *candidates;
+};
+
+struct candidate_data {
+	struct ofono_gprs_provision_data *entry;
+	gchar *spn;
+};
+
+static void candidate_data_free(struct candidate_data *cand)
+{
+	if (cand =3D=3D NULL)
+		return;
+
+	if (cand->entry)
+		__ofono_gprs_provision_free_settings(cand->entry, 1);
+
+	g_free(cand->spn);
+	g_free(cand);
+}
+
+static enum ofono_gprs_context_type string_to_gprs_context_type(const char=
 *str)
+{
+	if (str !=3D NULL) {
+		if (strcasecmp(str, "internet") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+		if (strcasecmp(str, "mms") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_MMS;
+		if (strcasecmp(str, "wap") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_WAP;
+		if (strcasecmp(str, "ims") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_IMS;
+	}
+
+	return OFONO_GPRS_CONTEXT_TYPE_ANY;
+}
+
+static enum ofono_gprs_proto string_to_gprs_proto(const char *str)
+{
+	if (str !=3D NULL) {
+		if (strcasecmp(str, "ipv6") =3D=3D 0)
+			return OFONO_GPRS_PROTO_IPV6;
+		if (strcasecmp(str, "ipv4v6") =3D=3D 0)
+			return OFONO_GPRS_PROTO_IPV6; // FIXME when possible
+	}
+
+	return OFONO_GPRS_PROTO_IP;
+}
+
+static struct candidate_data *candidate_data_new(const char *spn,
+				const struct ofono_gprs_provision_data *data)
+{
+	struct candidate_data *cand;
+	cand =3D g_try_malloc0(sizeof(*cand));
+	if (cand =3D=3D NULL)
+		return NULL;
+
+	cand->entry =3D g_try_malloc0(sizeof(*cand->entry));
+	if (cand->entry =3D=3D NULL) {
+		g_free(cand);
+		return NULL;
+	}
+
+	cand->spn =3D g_strdup(spn);
+	cand->entry->type =3D data->type;
+	cand->entry->apn =3D g_strdup(data->apn);
+	cand->entry->name =3D g_strdup(data->name);
+	cand->entry->username =3D g_strdup(data->username);
+	cand->entry->password =3D g_strdup(data->password);
+	cand->entry->proto =3D data->proto;
+	cand->entry->message_proxy =3D g_strdup(data->message_proxy);
+	cand->entry->message_center =3D g_strdup(data->message_center);
+
+	return cand;
+}
+
+/*
+ * Parse <access> element.
+ * Mandatory attributes in <access>: mcc, mnc, type, name
+ * If MCC/MNC matches, add entry to candidate entry list.
+ */
+static void settings_start_element_handler (GMarkupParseContext *context,
+						const gchar *element_name,
+						const gchar **attribute_names,
+						const gchar **attribute_values,
+						gpointer user_data,
+						GError **error)
+{
+	int i;
+	struct parser_data *parser =3D user_data;
+	const char *mcc =3D NULL, *mnc =3D NULL, *spn =3D NULL;
+	struct ofono_gprs_provision_data entry =3D {0};
+
+	if (strcasecmp(element_name, "access") !=3D 0)
+		return;
+
+	for (i =3D 0; attribute_names[i] !=3D NULL; i++) {
+		const char *name =3D attribute_names[i];
+		const char *value =3D attribute_values[i];
+
+		if (strcasecmp(name, "mcc") =3D=3D 0) {
+			if (strcmp(value, parser->mcc) !=3D 0)
+				break;
+
+			mcc =3D value;
+		}
+
+		if (strcasecmp(name, "mnc") =3D=3D 0) {
+			/*
+			 * Match MNC as integers, since settings files
+			 * do not always contain leading zeros in MNC values...
+			 */
+			if (atoi(value) !=3D atoi(parser->mnc))
+				break;
+
+			mnc =3D value;
+		}
+
+		if (strcasecmp(name, "spn") =3D=3D 0)
+			spn =3D value;
+
+		if (strcasecmp(name, "type") =3D=3D 0)
+			entry.type =3D string_to_gprs_context_type(value);
+
+		if (strcasecmp(name, "apn") =3D=3D 0)
+			entry.apn =3D (char *) value;
+
+		if (strcasecmp(name, "name") =3D=3D 0)
+			entry.name =3D (char *) value;
+
+		if (strcasecmp(name, "username") =3D=3D 0)
+			entry.username =3D (char *) value;
+
+		if (strcasecmp(name, "password") =3D=3D 0)
+			entry.password =3D (char *) value;
+
+		if (strcasecmp(name, "protocol") =3D=3D 0)
+			entry.proto =3D string_to_gprs_proto(value);
+
+		if (strcasecmp(name, "proxy") =3D=3D 0)
+			entry.message_proxy =3D (char *) value;
+
+		if (strcasecmp(name, "mmsc") =3D=3D 0)
+			entry.message_center =3D (char *) value;
+	}
+
+	if (mcc !=3D NULL && mnc !=3D NULL && entry.type !=3D 0 &&
+				entry.name !=3D NULL && entry.apn !=3D NULL) {
+		struct candidate_data *cand =3D candidate_data_new(spn, &entry);
+		if (cand =3D=3D NULL)
+			return;
+
+		parser->candidates =3D g_slist_append(parser->candidates, cand);
+	}
+}
+
+/*
+ * Returns list of candidate settings matching mcc/mnc from operator
+ * access settings file
+ */
+static GSList *read_access_settings_file(const char *filename,
+					const char *mcc, const char *mnc)
+{
+	gchar *contents;
+	gsize length;
+	GMarkupParseContext *context;
+
+	struct parser_data parser =3D {0};
+	GMarkupParser settings_parser =3D { settings_start_element_handler,
+					  NULL, NULL, NULL, NULL };
+
+	if (filename =3D=3D NULL || mcc =3D=3D NULL || mnc =3D=3D NULL)
+		return NULL;
+
+	if (g_file_get_contents(filename, &contents, &length,
+				NULL) =3D=3D FALSE) {
+		ofono_warn("Error reading access settings file %s", filename);
+		return NULL;
+	}
+
+	DBG("Reading access settings file %s", filename);
+
+	parser.mcc =3D mcc;
+	parser.mnc =3D mnc;
+
+	context =3D g_markup_parse_context_new(&settings_parser, 0, &parser,
+						NULL);
+
+	if (g_markup_parse_context_parse(context, contents, length,
+						NULL) =3D=3D FALSE) {
+		ofono_warn("Error parsing XML file %s", filename);
+	}
+
+	g_markup_parse_context_free(context);
+	g_free(contents);
+
+	return parser.candidates;
+}
+
+static void append_to_settings(struct ofono_gprs_provision_data **settings,
+				int *count,
+				struct ofono_gprs_provision_data **data)
+{
+	*settings =3D g_try_renew(struct ofono_gprs_provision_data, *settings,
+					*count + 1);
+	if (*settings =3D=3D NULL) {
+		*count =3D 0;
+		return;
+	}
+
+	memcpy(*settings + *count, *data, sizeof(**data));
+	*count =3D *count + 1;
+
+	g_free(*data);
+	*data =3D NULL;
+
+	return;
+}
+
+/* Compare type and spn (case-insensitively) to a candidate entry */
+static gboolean is_spn_match(struct candidate_data *cand,
+				enum ofono_gprs_context_type type,
+				gchar *spn_casefold)
+{
+	gboolean ret =3D FALSE;
+	gchar *candspn_casefold =3D NULL;
+
+	if (spn_casefold =3D=3D NULL || cand->spn =3D=3D NULL)
+		return FALSE;
+
+	candspn_casefold =3D g_utf8_casefold(cand->spn, -1);
+	if (type =3D=3D cand->entry->type && strcmp(spn_casefold,
+						candspn_casefold) =3D=3D 0)
+		ret =3D TRUE;
+
+	g_free(candspn_casefold);
+	return ret;
+}
+
+/* Find an entry from candidates matching type and optionally spn */
+static gboolean get_entry(GSList * candidates,
+			enum ofono_gprs_context_type type,
+			const char *spn,
+			struct ofono_gprs_provision_data **settings,
+			int *count)
+{
+	GSList *lp;
+	gchar *spn_casefold =3D NULL;
+	gboolean success =3D FALSE;
+
+	if (spn !=3D NULL)
+		spn_casefold =3D g_utf8_casefold(spn, -1);
+
+	for (lp =3D candidates; lp !=3D NULL; lp =3D lp->next) {
+		struct candidate_data *cand =3D lp->data;
+
+		if (cand->entry =3D=3D NULL)
+			continue;
+
+		if ((spn_casefold =3D=3D NULL && cand->entry->type =3D=3D type) ||
+				is_spn_match(cand, type, spn_casefold)) {
+			DBG("Found: %s", cand->entry->name);
+
+			append_to_settings(settings, count, &cand->entry);
+			success =3D TRUE;
+			break;
+		}
+	}
+
+	g_free(spn_casefold);
+
+	/* If match with using spn failed, retry without */
+	if (success =3D=3D FALSE && spn !=3D NULL)
+		return get_entry(candidates, type, NULL, settings, count);
+
+	return success;
+}
+
+
+static void read_operator_settings(const char *filename, const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	GSList *candidates;
+	candidates =3D read_access_settings_file(filename, mcc, mnc);
+
+	/* Get settings for internet and mms contexts */
+	get_entry(candidates, OFONO_GPRS_CONTEXT_TYPE_INTERNET, spn,
+			settings, count);
+	get_entry(candidates, OFONO_GPRS_CONTEXT_TYPE_MMS, spn,
+			settings, count);
+	/* TODO: add wap and ims types */
+
+	g_slist_foreach(candidates, (GFunc) candidate_data_free, NULL);
+	g_slist_free(candidates);
+}
+
+/*
+ * Returns GPRS context settings (internet and mms types) based on
+ * SIM provided MCC,MNC and Service Provider Name (SPN) values.
+ * Operator settings for Internet and MMS access points are stored
+ * in XML formatted files (*.xml) under $CONFIGDIR/operator-settings
+ */
+static int get_settings(const char *mcc, const char *mnc, const char *spn,
+			struct ofono_gprs_provision_data **settings,
+			int *count)
+{
+	GDir *dir;
+	GSList *files =3D NULL, *lp;
+	const gchar *filename;
+
+	*count =3D 0;
+	*settings =3D NULL;
+
+	ofono_debug("Provisioning settings for MCC %s, MNC %s SPN '%s'",
+			mcc, mnc, spn);
+
+	/* Find all .xml-files from settings directory */
+	dir =3D g_dir_open(CONFIGDIR "/" OPERATOR_SETTINGS_DIR, 0, NULL);
+	if (dir =3D=3D NULL) {
+		ofono_warn("Error opening settings directory");
+		return -ENOENT;
+	}
+
+	while ((filename =3D g_dir_read_name(dir)) !=3D NULL) {
+		if (g_str_has_suffix(filename, ".xml")) {
+			gchar *fn =3D g_build_filename(CONFIGDIR,
+							OPERATOR_SETTINGS_DIR,
+							filename, NULL);
+			files =3D g_slist_append(files, fn);
+		}
+	}
+
+	/* Process files in sorted order */
+	files =3D g_slist_sort(files, (GCompareFunc) g_strcmp0);
+
+	for (lp =3D files; lp !=3D NULL; lp =3D lp->next) {
+		gchar *fn =3D lp->data;
+		read_operator_settings(fn, mcc, mnc, spn, settings, count);
+
+		if (*count > 0)
+			break;
+	}
+
+	g_slist_foreach(files, (GFunc) g_free, NULL);
+	g_slist_free(files);
+	g_dir_close(dir);
+
+	return *count > 0 ? 0 : -ENOENT;
+}
+
+static struct ofono_gprs_provision_driver provision_driver =3D {
+	.name		=3D "Connection Context Provisioning Plugin",
+	.priority       =3D OFONO_PLUGIN_PRIORITY_DEFAULT,
+	.get_settings	=3D get_settings,
+};
+
+static int provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&provision_driver);
+}
+
+static void provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(context_provisioning,
+			"Connection Context Provisioning Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			provision_init,
+			provision_exit)
+
-- =

1.7.1


--===============8464971713747951760==--

