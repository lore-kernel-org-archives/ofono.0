Content-Type: multipart/mixed; boundary="===============7864125622058823296=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv7 3/3] plugins: Add provisioning plugin
Date: Fri, 23 Sep 2011 14:41:10 +0300
Message-ID: <1316778070-3862-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1316778070-3862-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7864125622058823296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/provision.c |  586 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 586 insertions(+), 0 deletions(-)
 create mode 100644 plugins/provision.c

diff --git a/plugins/provision.c b/plugins/provision.c
new file mode 100644
index 0000000..9c67186
--- /dev/null
+++ b/plugins/provision.c
@@ -0,0 +1,586 @@
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
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/types.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+
+#define _(x) case x: return (#x)
+
+enum PROVISION_ERROR {
+	PROVISION_ERROR_DUPLICATE,
+	PROVISION_ERROR_ENOMEM,
+};
+
+struct gsm_data {
+	const char *match_mcc;
+	const char *match_mnc;
+	GSList *apns;
+	gboolean match_found;
+	gboolean allow_duplicates;
+};
+
+static const char *ap_type_name(enum ofono_gprs_context_type type)
+{
+	switch (type) {
+		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
+		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
+		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
+		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
+	}
+
+	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
+}
+
+static struct ofono_gprs_provision_data *ap_new(const char *apn)
+{
+	struct ofono_gprs_provision_data *ap;
+	gsize len;
+
+	ap =3D g_try_new0(struct ofono_gprs_provision_data, 1);
+	if (ap =3D=3D NULL)
+		return NULL;
+
+	len =3D strlen(apn) + 1;
+
+	ap->apn =3D g_try_new(char, len);
+	if (ap->apn =3D=3D NULL) {
+		g_free(ap);
+		return NULL;
+	}
+
+	memcpy(ap->apn, apn, len);
+
+	DBG("%p, APN: '%s'", ap, ap->apn);
+
+	ap->proto =3D OFONO_GPRS_PROTO_IP;
+
+	return ap;
+}
+
+static void ap_free(struct ofono_gprs_provision_data *ap)
+{
+	DBG("%p", ap);
+
+	g_free(ap->name);
+	g_free(ap->apn);
+	g_free(ap->username);
+	g_free(ap->password);
+	g_free(ap->message_proxy);
+	g_free(ap->message_center);
+
+	g_free(ap);
+}
+
+static GQuark provision_error_quark(void)
+{
+	return g_quark_from_static_string("ofono-provision-error-quark");
+}
+
+static void provision_g_set_error(GMarkupParseContext *context, GError **e=
rr,
+				GQuark domain, gint code, const gchar *fmt, ...)
+{
+	va_list ap;
+	gint line_number, char_number;
+
+	g_markup_parse_context_get_position(context, &line_number,
+						&char_number);
+
+	va_start(ap, fmt);
+
+	*err =3D g_error_new_valist(domain, code, fmt, ap);
+
+	va_end(ap);
+
+	g_prefix_error(err, "%s:%d ", PROVIDER_DATABASE, line_number);
+}
+
+static void text_handler(GMarkupParseContext *context,
+				const gchar *text, gsize text_len,
+				gpointer userdata, GError **error)
+{
+	char **string =3D userdata;
+
+	if (*string !=3D NULL) {
+		gint line_number, char_number;
+
+		g_markup_parse_context_get_position(context, &line_number,
+							&char_number);
+
+		ofono_warn("%s:%d Ignored duplicate element %s",
+				PROVIDER_DATABASE, line_number,
+				g_markup_parse_context_get_element(context));
+		return;
+	}
+
+	DBG("%s: '%*s'", g_markup_parse_context_get_element(context),
+		(int)text_len, text);
+
+	*string =3D g_try_new(char, text_len + 1);
+	if (*string =3D=3D NULL) {
+		provision_g_set_error(context, error, provision_error_quark(),
+				PROVISION_ERROR_ENOMEM,
+				"Can't allocate memory, memory exhausted");
+		return;
+	}
+
+	memcpy(*string, text, text_len);
+
+	(*string)[text_len] =3D '\0';
+}
+
+static const GMarkupParser text_parser =3D {
+	NULL,
+	NULL,
+	text_handler,
+	NULL,
+	NULL,
+};
+
+static void usage_start(GMarkupParseContext *context, const gchar *element=
_name,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			gpointer userdata, GError **error)
+{
+	enum ofono_gprs_context_type *type =3D userdata;
+	const char *text =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			text =3D attribute_values[i];
+
+	if (text =3D=3D NULL)
+		return;
+
+	DBG("%s: '%s'", element_name, text);
+
+	if (strcmp(text, "internet") =3D=3D 0)
+		*type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	else if (strcmp(text, "mms") =3D=3D 0)
+		*type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	else if (strcmp(text, "wap") =3D=3D 0)
+		*type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
+	else
+		provision_g_set_error(context, error, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
+				"Unknown usage attribute value: %s", text);
+}
+
+static void apn_start(GMarkupParseContext *context, const gchar *element_n=
ame,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			gpointer userdata, GError **error)
+{
+	struct ofono_gprs_provision_data *apn =3D userdata;
+
+	if (g_str_equal(element_name, "name"))
+		g_markup_parse_context_push(context, &text_parser, &apn->name);
+	else if (g_str_equal(element_name, "username"))
+		g_markup_parse_context_push(context, &text_parser,
+						&apn->username);
+	else if (g_str_equal(element_name, "password"))
+		g_markup_parse_context_push(context, &text_parser,
+						&apn->password);
+	else if (g_str_equal(element_name, "usage"))
+		usage_start(context, element_name, attribute_names,
+				attribute_values, &apn->type, error);
+}
+
+static void apn_end(GMarkupParseContext *context, const gchar *element_nam=
e,
+			gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "name") ||
+			g_str_equal(element_name, "username") ||
+			g_str_equal(element_name, "password"))
+		g_markup_parse_context_pop(context);
+}
+
+static void apn_error(GMarkupParseContext *context, GError *error,
+			gpointer userdata)
+{
+	/*
+	 * Note that even if the error happened in a subparser, this will
+	 * be called.  So we always perform cleanup of the allocated
+	 * provision data
+	 */
+	ap_free(userdata);
+}
+
+static const GMarkupParser apn_parser =3D {
+	apn_start,
+	apn_end,
+	NULL,
+	NULL,
+	apn_error,
+};
+
+static const GMarkupParser skip_parser =3D {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void network_id_handler(GMarkupParseContext *context,
+				struct gsm_data *gsm,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				GError **error)
+{
+	const char *mcc =3D NULL, *mnc =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
+			mcc =3D attribute_values[i];
+		if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
+			mnc =3D attribute_values[i];
+	}
+
+	if (mcc =3D=3D NULL) {
+		provision_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: mcc");
+		return;
+	}
+
+	if (mnc =3D=3D NULL) {
+		provision_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: mnc");
+		return;
+	}
+
+	if (g_str_equal(mcc, gsm->match_mcc) &&
+			g_str_equal(mnc, gsm->match_mnc))
+		gsm->match_found =3D TRUE;
+}
+
+static void apn_handler(GMarkupParseContext *context, struct gsm_data *gsm,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			GError **error)
+{
+	struct ofono_gprs_provision_data *ap;
+	const char *apn;
+	int i;
+
+	if (gsm->match_found =3D=3D FALSE) {
+		g_markup_parse_context_push(context, &skip_parser, NULL);
+		return;
+	}
+
+	for (i =3D 0, apn =3D NULL; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "value") =3D=3D FALSE)
+			continue;
+
+		apn =3D attribute_values[i];
+		break;
+	}
+
+	if (apn =3D=3D NULL) {
+		provision_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"APN attribute missing");
+		return;
+	}
+
+	ap =3D ap_new(apn);
+	if (ap =3D=3D NULL) {
+		provision_g_set_error(context, error, provision_error_quark(),
+					PROVISION_ERROR_ENOMEM,
+					"Can't allocate memory for APN: '%s', "
+					"memory exhausted", apn);
+		return;
+	}
+
+	g_markup_parse_context_push(context, &apn_parser, ap);
+}
+
+static void gsm_start(GMarkupParseContext *context, const gchar *element_n=
ame,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "network-id")) {
+		struct gsm_data *gsm =3D userdata;
+
+		/*
+		 * For entries with multiple network-id elements, don't bother
+		 * searching if we already have a match
+		 */
+		if (gsm->match_found =3D=3D TRUE)
+			return;
+
+		network_id_handler(context, userdata, attribute_names,
+					attribute_values, error);
+	} else if (g_str_equal(element_name, "apn"))
+		apn_handler(context, userdata, attribute_names,
+				attribute_values, error);
+}
+
+static void gsm_end(GMarkupParseContext *context, const gchar *element_nam=
e,
+			gpointer userdata, GError **error)
+{
+	struct gsm_data *gsm;
+	struct ofono_gprs_provision_data *ap;
+
+	if (!g_str_equal(element_name, "apn"))
+		return;
+
+	gsm =3D userdata;
+
+	ap =3D g_markup_parse_context_pop(context);
+	if (ap =3D=3D NULL)
+		return;
+
+	if (gsm->allow_duplicates =3D=3D FALSE) {
+		GSList *l;
+
+		for (l =3D gsm->apns; l; l =3D l->next) {
+			struct ofono_gprs_provision_data *pd =3D l->data;
+
+			if (pd->type !=3D ap->type)
+				continue;
+
+			provision_g_set_error(context, error,
+						provision_error_quark(),
+						PROVISION_ERROR_DUPLICATE,
+						"Duplicate context detected");
+
+			ap_free(ap);
+			return;
+		}
+	}
+
+	gsm->apns =3D g_slist_append(gsm->apns, ap);
+}
+
+static const GMarkupParser gsm_parser =3D {
+	gsm_start,
+	gsm_end,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void toplevel_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **atribute_names,
+					const gchar **attribute_values,
+					gpointer userdata, GError **error)
+{
+	struct gsm_data *gsm =3D userdata;
+
+	if (g_str_equal(element_name, "gsm")) {
+		gsm->match_found =3D FALSE;
+		g_markup_parse_context_push(context, &gsm_parser, gsm);
+	} else if (g_str_equal(element_name, "cdma"))
+		g_markup_parse_context_push(context, &skip_parser, NULL);
+}
+
+static void toplevel_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "gsm") ||
+			g_str_equal(element_name, "cdma"))
+		g_markup_parse_context_pop(context);
+}
+
+static const GMarkupParser toplevel_parser =3D {
+	toplevel_start,
+	toplevel_end,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static gboolean provision_parse(const char *data, ssize_t size,
+				struct gsm_data *gsm, GError **error)
+{
+	GMarkupParseContext *context;
+	gboolean ret;
+
+	context =3D g_markup_parse_context_new(&toplevel_parser,
+						G_MARKUP_TREAT_CDATA_AS_TEXT,
+						gsm, NULL);
+
+	ret =3D g_markup_parse_context_parse(context, data, size, error);
+
+	if (ret =3D=3D TRUE)
+		g_markup_parse_context_end_parse(context, error);
+
+	g_markup_parse_context_free(context);
+
+	return ret;
+}
+
+static GSList *provision_lookup(const char *mcc, const char *mnc,
+				gboolean allow_duplicates, GError **error)
+{
+	struct stat st;
+	char *db;
+	int fd;
+	struct gsm_data gsm;
+	GSList *l;
+
+	fd =3D open(PROVIDER_DATABASE, O_RDONLY);
+	if (fd < 0) {
+		g_set_error(error, G_FILE_ERROR,
+				g_file_error_from_errno(errno),
+				"open failed: %s", g_strerror(errno));
+		return NULL;
+	}
+
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		g_set_error(error, G_FILE_ERROR,
+				g_file_error_from_errno(errno),
+				"fstat failed: %s", g_strerror(errno));
+		return NULL;
+	}
+
+	db =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (db =3D=3D MAP_FAILED) {
+		close(fd);
+		g_set_error(error, G_FILE_ERROR,
+				g_file_error_from_errno(errno),
+				"mmap failed: %s", g_strerror(errno));
+		return NULL;
+	}
+
+	memset(&gsm, 0, sizeof(gsm));
+	gsm.match_mcc =3D mcc;
+	gsm.match_mnc =3D mnc;
+	gsm.allow_duplicates =3D allow_duplicates;
+
+	if (provision_parse(db, st.st_size, &gsm, error) =3D=3D FALSE) {
+		for (l =3D gsm.apns; l; l =3D l->next)
+			ap_free(l->data);
+
+		g_slist_free(gsm.apns);
+		gsm.apns =3D NULL;
+	}
+
+	munmap(db, st.st_size);
+	close(fd);
+
+	return gsm.apns;
+}
+
+static int provision_get_settings(const char *mcc, const char *mnc,
+				const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	GSList *l;
+	GSList *apns;
+	GError *error =3D NULL;
+	int ap_count;
+	int i;
+
+	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	apns =3D provision_lookup(mcc, mnc, FALSE, &error);
+	if (apns =3D=3D NULL) {
+		ofono_error("%s", error->message);
+		return -ENOENT;
+	}
+
+	ap_count =3D g_slist_length(apns);
+
+	DBG("Found %d APs", ap_count);
+
+	*settings =3D g_try_malloc_n(ap_count,
+				sizeof(struct ofono_gprs_provision_data));
+	if (*settings =3D=3D NULL) {
+		ofono_error("Provisioning failed: %s", g_strerror(errno));
+
+		for (l =3D apns; l; l =3D l->next)
+			ap_free(l->data);
+
+		g_slist_free(apns);
+
+		return -ENOMEM;
+	}
+
+	*count =3D ap_count;
+
+	for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
+		struct ofono_gprs_provision_data *ap =3D l->data;
+
+		DBG("Name: '%s'", ap->name);
+		DBG("APN: '%s'", ap->apn);
+		DBG("Type: %s", ap_type_name(ap->type));
+		DBG("Username: '%s'", ap->username);
+		DBG("Password: '%s'", ap->password);
+
+		*(*settings + i) =3D *ap;
+
+		memset(*settings + i, 0,
+			sizeof(struct ofono_gprs_provision_data));
+		ap_free(ap);
+	}
+
+	g_slist_free(apns);
+
+	return 0;
+}
+
+static struct ofono_gprs_provision_driver provision_driver =3D {
+	.name		=3D "Provisioning",
+	.get_settings	=3D provision_get_settings
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
+OFONO_PLUGIN_DEFINE(provision, "Provisioning Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			provision_init, provision_exit)
-- =

1.7.4.1


--===============7864125622058823296==--

