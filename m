Content-Type: multipart/mixed; boundary="===============8395972225561196206=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 1/4] operator-settings: Add GPRS context provisioning
 sources
Date: Tue, 21 Dec 2010 11:01:16 +0200
Message-ID: <1292922079-24711-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1292922079-24711-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8395972225561196206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am             |    3 +-
 src/operator-settings.c |  292 +++++++++++++++++++++++++++++++++++++++++++=
++++
 src/operator-settings.h |   37 ++++++
 3 files changed, 331 insertions(+), 1 deletions(-)
 create mode 100644 src/operator-settings.c
 create mode 100644 src/operator-settings.h

diff --git a/Makefile.am b/Makefile.am
index 12b3c33..93e4d28 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c
+			src/smsagent.c src/smsagent.h src/ctm.c \
+			src/operator-settings.c src/operator-settings.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/operator-settings.c b/src/operator-settings.c
new file mode 100644
index 0000000..7b63d94
--- /dev/null
+++ b/src/operator-settings.c
@@ -0,0 +1,292 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+static gchar *cleanstr(const char *str)
+{
+	return g_strstrip(g_strdup(str));
+}
+
+/*
+ * Parse settings csv-file line. If MCC/MNC matches, return settings
+ *
+ * Settings file format: Comma separated fields (that cannot contain comma=
s) of:
+ *     MCC,MNC,SPN,type,UI name, APN, username, password, protocol,\
+ *     proxy IP address, proxy port, MMS server URL
+ * where type=3DINTERNET|MMS, protocol=3Dipv4|ipv6
+ */
+static struct gprs_access_settings *parse_setting_line(const char *line,
+							const char *mcc,
+							const char *mnc)
+{
+	gchar **columns;
+	int count;
+	struct gprs_access_settings *entry =3D NULL;
+
+	columns =3D g_strsplit(line, ",", 0);
+	count =3D g_strv_length(columns);
+
+	/* mandatory values: mcc, mnc, spn, type, name, apn */
+	if (count < 6)
+		goto finish;
+
+	if (strcmp(mcc, columns[0]) !=3D 0 || strcmp(mnc, columns[1]) !=3D 0)
+		goto finish;
+
+	entry =3D g_try_malloc0(sizeof(*entry));
+	if (entry =3D=3D NULL)
+		goto finish;
+
+	entry->spn =3D cleanstr(columns[2]);
+	entry->type =3D string_to_gprs_context_type(columns[3]);
+	entry->name =3D cleanstr(columns[4]);
+	entry->apn =3D cleanstr(columns[5]);
+
+	if (count > 6)
+		entry->username =3D cleanstr(columns[6]);
+	else
+		entry->username =3D g_strdup("");
+
+	if (count > 7)
+		entry->password =3D cleanstr(columns[7]);
+	else
+		entry->password =3D g_strdup("");
+
+	if (count > 8 && strcmp(columns[8], "ipv6") =3D=3D 0)
+		entry->proto =3D OFONO_GPRS_PROTO_IPV6;
+	else
+		entry->proto =3D OFONO_GPRS_PROTO_IP;
+
+	if (count > 9) {
+		gchar proxy[MAX_PROXY_NAME_LENGTH + 1];
+		g_strlcpy(proxy, columns[9], MAX_PROXY_NAME_LENGTH);
+
+		if (count > 10 && strlen(columns[10]) > 0) {
+			g_strlcat(proxy, ":", MAX_PROXY_NAME_LENGTH);
+			g_strlcat(proxy, columns[10], MAX_PROXY_NAME_LENGTH);
+		}
+
+		entry->proxy =3D cleanstr(proxy);
+	}
+
+	if (count > 11)
+		entry->mms_server =3D cleanstr(columns[11]);
+
+finish:
+	g_strfreev(columns);
+	return entry;
+}
+
+/*
+ * Returns list of candidate settings matching mcc/mnc from operator
+ * settings file
+ */
+static GSList *read_settings_file(const char *filename,
+					const char *mcc, const char *mnc)
+{
+	GSList *entries =3D NULL;
+	FILE *f;
+	char *line =3D NULL;
+	size_t len =3D 0;
+	ssize_t read;
+
+	if (filename =3D=3D NULL || mcc =3D=3D NULL || mnc =3D=3D NULL)
+		return NULL;
+
+	f =3D fopen(filename, "r");
+	if (f =3D=3D NULL) {
+		DBG("Error opening settings file %s", filename);
+		return NULL;
+	}
+
+	while ((read =3D getline(&line, &len, f)) !=3D -1) {
+		struct gprs_access_settings *entry;
+		entry =3D parse_setting_line(line, mcc, mnc);
+		if (entry !=3D NULL)
+			entries =3D g_slist_append(entries, entry);
+	}
+
+	free(line);
+	fclose(f);
+
+	return entries;
+}
+
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
+ * in CSV formatted files (*.csv) under $CONDIFDIR/operator-settings
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
+		if (g_str_has_suffix(filename, ".csv")) {
+			gchar *fn =3D g_strjoin("/", CONFIGDIR, SETTING_FILE_DIR,
+						filename, NULL);
+			files =3D g_slist_append(files, fn);
+		}
+	}
+
+	files =3D g_slist_sort(files, (GCompareFunc) g_strcmp0);
+
+	for (lp =3D files; lp !=3D NULL; lp =3D lp->next) {
+		GSList *entries;
+		gchar *fn;
+		fn =3D lp->data;
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
index 0000000..95f3785
--- /dev/null
+++ b/src/operator-settings.h
@@ -0,0 +1,37 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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


--===============8395972225561196206==--

