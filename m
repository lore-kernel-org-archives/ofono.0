Content-Type: multipart/mixed; boundary="===============0444837135153648850=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv2 2/4] operator-settings: Add GPRS context provisioning
 sources
Date: Mon, 03 Jan 2011 09:31:50 +0200
Message-ID: <1294039912-6008-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0444837135153648850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am             |    3 +-
 src/operator-settings.c |  314 +++++++++++++++++++++++++++++++++++++++++++=
++++
 src/operator-settings.h |   37 ++++++
 3 files changed, 353 insertions(+), 1 deletions(-)
 create mode 100644 src/operator-settings.c
 create mode 100644 src/operator-settings.h

diff --git a/Makefile.am b/Makefile.am
index 8a8555d..d0e47e5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -328,7 +328,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c \
+			src/operator-settings.c src/operator-settings.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/operator-settings.c b/src/operator-settings.c
new file mode 100644
index 0000000..4cc90d6
--- /dev/null
+++ b/src/operator-settings.c
@@ -0,0 +1,314 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies).
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <glib.h>
+
+#include "ofono.h"
+#include "operator-settings.h"
+
+#define MAX_PROXY_NAME_LENGTH 255
+
+struct parser_data {
+	const gchar *mcc;
+	const gchar *mnc;
+	GSList *candidates;
+};
+
+void gprs_access_settings_free(struct gprs_access_settings *settings)
+{
+	if (settings =3D=3D NULL)
+		return;
+
+	g_free(settings->name);
+	g_free(settings->apn);
+	g_free(settings->username);
+	g_free(settings->password);
+	g_free(settings->proxy);
+	g_free(settings->mms_server);
+	g_free(settings->spn);
+	g_free(settings);
+}
+
+static enum ofono_gprs_context_type string_to_gprs_context_type(const char=
 *str)
+{
+	if (str) {
+		if (strcasecmp(str, "INTERNET") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+		if (strcasecmp(str, "MMS") =3D=3D 0)
+			return OFONO_GPRS_CONTEXT_TYPE_MMS;
+	}
+
+	return OFONO_GPRS_CONTEXT_TYPE_ANY;
+}
+
+/*
+ * Parse <access> element.
+ * Mandatory attributes in <access>: mcc, mnc, type, name
+ * If MCC/MNC matches, add entry to candidate setting list.
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
+	struct gprs_access_settings *entry;
+	const char *mcc =3D NULL, *mnc =3D NULL;
+
+	if (strcasecmp(element_name, "access") !=3D 0)
+		return;
+
+	entry =3D g_try_malloc0(sizeof(*entry));
+	if (entry =3D=3D NULL)
+		return;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+
+		if (strcasecmp(attribute_names[i], "mcc") =3D=3D 0)
+			mcc =3D attribute_values[i];
+
+		if (strcasecmp(attribute_names[i], "mnc") =3D=3D 0)
+			mnc =3D attribute_values[i];
+
+		if (strcasecmp(attribute_names[i], "spn") =3D=3D 0)
+			entry->spn =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "type") =3D=3D 0)
+			entry->type =3D string_to_gprs_context_type(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "apn") =3D=3D 0)
+			entry->apn =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "name") =3D=3D 0)
+			entry->name =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "username") =3D=3D 0)
+			entry->username =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "password") =3D=3D 0)
+			entry->password =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "protocol") =3D=3D 0) {
+			if (strcasecmp(attribute_values[i], "ipv6") =3D=3D 0)
+				entry->proto =3D OFONO_GPRS_PROTO_IPV6;
+			else
+				entry->proto =3D OFONO_GPRS_PROTO_IP;
+		}
+
+		if (strcasecmp(attribute_names[i], "proxy") =3D=3D 0)
+			entry->proxy =3D g_strdup(attribute_values[i]);
+
+		if (strcasecmp(attribute_names[i], "mmsserver") =3D=3D 0)
+			entry->mms_server =3D g_strdup(attribute_values[i]);
+	}
+
+	/*
+	 * Match MNC as integers, since settings files often do not
+	 * always contain leading zeros in MNC values...
+	 */
+	if (mcc !=3D NULL && strcmp(mcc, parser->mcc) =3D=3D 0 &&
+		mnc !=3D NULL && atoi(mnc) =3D=3D atoi(parser->mnc) &&
+		entry->type !=3D 0 && entry->name !=3D NULL) {
+		DBG("Settings candidate: %s", entry->name);
+		parser->candidates =3D g_slist_append(parser->candidates, entry);
+	} else {
+		gprs_access_settings_free(entry);
+	}
+}
+
+/*
+ * Returns list of candidate settings matching mcc/mnc from operator
+ * settings file
+ */
+static GSList *read_settings_file(const char *filename,
+					const char *mcc, const char *mnc)
+{
+	gchar *contents =3D NULL;
+	gsize length;
+	GMarkupParseContext *context;
+
+	struct parser_data parser =3D {0};
+	GMarkupParser settings_parser =3D {
+		settings_start_element_handler,
+		NULL,
+		NULL,
+		NULL,
+		NULL
+	};
+
+	if (filename =3D=3D NULL || mcc =3D=3D NULL || mnc =3D=3D NULL)
+		return NULL;
+
+	if (g_file_get_contents(filename, &contents, &length, NULL) =3D=3D FALSE)=
 {
+		DBG("Error reading settings file %s", filename);
+		return NULL;
+	}
+
+	DBG("Reading settings file %s", filename);
+
+	parser.mcc =3D mcc;
+	parser.mnc =3D mnc;
+
+	context =3D g_markup_parse_context_new(&settings_parser, 0,
+						&parser, NULL);
+
+	if (g_markup_parse_context_parse(context, contents,
+						length, NULL) =3D=3D FALSE) {
+		DBG("Error parsing XML file %s", filename);
+	}
+
+	g_markup_parse_context_free(context);
+	g_free(contents);
+
+	return parser.candidates;
+}
+
+/* Case insensitive match of type and SPN (if provided) */
+static gboolean is_match(struct gprs_access_settings *entry,
+				enum ofono_gprs_context_type type,
+				gchar *spn_casefold)
+{
+	gboolean ret =3D FALSE;
+	gchar *entryspn_casefold =3D NULL;
+
+	if (entry->spn !=3D NULL && strlen(entry->spn) > 0)
+		entryspn_casefold =3D g_utf8_casefold(entry->spn, -1);
+
+	if (type =3D=3D entry->type) {
+		if (spn_casefold !=3D NULL) {
+			if (entryspn_casefold &&
+					strcmp(spn_casefold,
+						entryspn_casefold) =3D=3D 0) {
+				ret =3D TRUE;
+			}
+		} else {
+			ret =3D TRUE;
+		}
+	}
+
+	g_free(entryspn_casefold);
+	return ret;
+}
+
+/*
+ * Find best match from candidate settings based on type and SPN
+ * If there is no candidate matching SPN, take first one matching type.
+ */
+static GSList *match_entry(GSList * candidates,
+				enum ofono_gprs_context_type type,
+				const char *spn)
+{
+	GSList *ret =3D NULL;
+	GSList *lp =3D candidates;
+	gchar *spn_casefold =3D NULL;
+
+	if (spn !=3D NULL && strlen(spn) > 0)
+		spn_casefold =3D g_utf8_casefold(spn, -1);
+
+	while (lp) {
+		struct gprs_access_settings *entry =3D lp->data;
+		if (is_match(entry, type, spn_casefold)) {
+			ret =3D lp;
+			break;
+		}
+
+		lp =3D lp->next;
+		if (lp =3D=3D NULL && spn_casefold !=3D NULL) {
+			/* No SPN matches, retry with only type */
+			g_free(spn_casefold);
+			spn_casefold =3D NULL;
+			lp =3D candidates;
+		}
+	}
+
+	g_free(spn_casefold);
+	return ret;
+}
+
+/*
+ * Returns GPRS context settings (internet and mms types) based on
+ * SIM provided MCC,MNC and Service Provider Name values.
+ * Operator settings for Internet and MMS access points are stored
+ * in XML formatted files (*.xml) under $CONDIFDIR/operator-settings
+ */
+GSList *get_operator_settings(const char *mcc, const char *mnc, const char=
 *spn)
+{
+	GSList *ret =3D NULL;
+	GSList *candidates =3D NULL;
+	GSList *match;
+	GDir *dir;
+	GSList *files =3D NULL, *lp;
+	const gchar *filename;
+
+	dir =3D g_dir_open(CONFIGDIR "/" SETTING_FILE_DIR, 0, NULL);
+	if (dir =3D=3D NULL) {
+		DBG("Error opening settings directory");
+		return NULL;
+	}
+
+	while ((filename =3D g_dir_read_name(dir)) !=3D NULL) {
+		if (g_str_has_suffix(filename, ".xml")) {
+			gchar *fn =3D g_build_filename(CONFIGDIR,
+							SETTING_FILE_DIR,
+							filename, NULL);
+			files =3D g_slist_append(files, fn);
+		}
+	}
+
+	/* Read files in consistent order */
+	files =3D g_slist_sort(files, (GCompareFunc) g_strcmp0);
+	for (lp =3D files; lp !=3D NULL; lp =3D lp->next) {
+		GSList *entries;
+		gchar *fn =3D lp->data;
+		entries =3D read_settings_file(fn, mcc, mnc);
+		candidates =3D g_slist_concat(candidates, entries);
+		g_free(fn);
+	}
+
+	g_slist_free(files);
+	g_dir_close(dir);
+
+	match =3D match_entry(candidates, OFONO_GPRS_CONTEXT_TYPE_INTERNET, spn);
+	if (match !=3D NULL) {
+		candidates =3D g_slist_remove_link(candidates, match);
+		ret =3D g_slist_concat(ret, match);
+	}
+
+	match =3D match_entry(candidates, OFONO_GPRS_CONTEXT_TYPE_MMS, spn);
+	if (match !=3D NULL) {
+		candidates =3D g_slist_remove_link(candidates, match);
+		ret =3D g_slist_concat(ret, match);
+	}
+
+	g_slist_foreach(candidates, (GFunc) gprs_access_settings_free, NULL);
+	g_slist_free(candidates);
+
+	return ret;
+}
diff --git a/src/operator-settings.h b/src/operator-settings.h
new file mode 100644
index 0000000..9725eb6
--- /dev/null
+++ b/src/operator-settings.h
@@ -0,0 +1,37 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies).
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
+#define SETTING_FILE_DIR "operator-settings"
+
+struct gprs_access_settings {
+	enum ofono_gprs_context_type type;
+	gchar *name;
+	gchar *apn;
+	gchar *username;
+	gchar *password;
+	enum ofono_gprs_proto proto;
+	gchar *proxy;
+	gchar *mms_server;
+	gchar *spn;
+};
+
+GSList *get_operator_settings(const char *mcc, const char *mnc,
+				const char *spn);
+void gprs_access_settings_free(struct gprs_access_settings *settings);
-- =

1.7.1


--===============0444837135153648850==--

