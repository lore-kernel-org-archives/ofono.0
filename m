Content-Type: multipart/mixed; boundary="===============8581908204107837696=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv6 3/3] Mobile broadband provider info plugin
Date: Wed, 14 Sep 2011 16:16:44 +0300
Message-ID: <1316006204-11390-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1316006204-11390-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8581908204107837696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mobile-broadband-provider-info.c |  804 ++++++++++++++++++++++++++=
++++
 1 files changed, 804 insertions(+), 0 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

diff --git a/plugins/mobile-broadband-provider-info.c b/plugins/mobile-broa=
dband-provider-info.c
new file mode 100644
index 0000000..57a888f
--- /dev/null
+++ b/plugins/mobile-broadband-provider-info.c
@@ -0,0 +1,804 @@
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
+#include <stdlib.h>
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
+#define MAX_APS	4
+
+#define _(x) case x: return (#x)
+
+enum provider_info_flags {
+	PROVIDER_INFO_FLAG_MATCH_FOUND	=3D 0x01,
+	PROVIDER_INFO_FLAG_AP_COMMIT	=3D 0x02,
+	PROVIDER_INFO_FLAG_INTERNET	=3D 0x04,
+	PROVIDER_INFO_FLAG_MMS		=3D 0x08,
+	PROVIDER_INFO_FLAG_WAP		=3D 0x10,
+};
+
+enum element_type {
+	ELEMENT_NONE,
+	ELEMENT_PROVIDER_NAME,
+	ELEMENT_SPN,
+	ELEMENT_GSM,
+	ELEMENT_NETWORK_ID,
+	ELEMENT_APN,
+	ELEMENT_USAGE,
+	ELEMENT_PLAN,
+	ELEMENT_NAME,
+	ELEMENT_USERNAME,
+	ELEMENT_PASSWORD,
+	ELEMENT_MAX,
+};
+
+enum parser_return_code {
+	PARSER_OK,
+	PARSER_ERROR,
+};
+
+enum parser_match_type {
+	PARSER_MATCH_ALL,
+	PARSER_MATCH_ONLY,
+};
+
+struct element_parser {
+	enum element_type type;
+	enum parser_match_type match_type;
+	GMarkupParser parser;
+};
+
+struct provider_info {
+	struct ofono_gprs_provision_data settings[MAX_APS];
+	struct ofono_gprs_provision_data *ap;
+	int ap_count;
+	char *spn;
+	const char *match_mcc;
+	const char *match_mnc;
+	const char *match_spn;
+	enum element_type element;
+	GQuark g_error_domain;
+	const struct element_parser *subparser;
+	guint8 flags;
+};
+
+static struct provider_info provider_info;
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
+static enum element_type element_type(const gchar *element,
+					GMarkupParseContext *context)
+{
+	switch (element[0]) {
+	case 'a':
+		if (g_str_equal(element, "apn") =3D=3D TRUE)
+			return ELEMENT_APN;
+		break;
+	case 'g':
+		if (g_str_equal(element, "gsm") =3D=3D TRUE)
+			return ELEMENT_GSM;
+		break;
+	case 'n':
+		if (g_str_equal(element, "name") =3D=3D TRUE) {
+			GSList *l =3D (GSList *)
+					g_markup_parse_context_get_element_stack
+					(context);
+
+			if (!g_slist_length(l))
+				break;
+
+			if (g_str_equal(g_slist_nth_data(l, 1),
+					"provider") =3D=3D TRUE)
+				return ELEMENT_PROVIDER_NAME;
+			if (g_str_equal(g_slist_nth_data(l, 1),
+					"apn") =3D=3D TRUE)
+				return ELEMENT_NAME;
+			break;
+		}
+		if (g_str_equal(element, "network-id") =3D=3D TRUE)
+			return ELEMENT_NETWORK_ID;
+		break;
+	case 'p':
+		if (g_str_equal(element, "plan") =3D=3D TRUE)
+			return ELEMENT_PLAN;
+		if (g_str_equal(element, "password") =3D=3D TRUE)
+			return ELEMENT_PASSWORD;
+		break;
+	case 'u':
+		if (g_str_equal(element, "usage") =3D=3D TRUE)
+			return ELEMENT_USAGE;
+		if (g_str_equal(element, "username") =3D=3D TRUE)
+			return ELEMENT_USERNAME;
+	}
+
+	return ELEMENT_NONE;
+}
+
+static struct ofono_gprs_provision_data *ap_new(struct provider_info *data)
+{
+	if (data->ap_count < MAX_APS) {
+		struct ofono_gprs_provision_data *ap =3D
+			data->settings + data->ap_count++;
+
+		data->flags &=3D ~PROVIDER_INFO_FLAG_AP_COMMIT;
+
+		DBG("%p", ap);
+
+		return ap;
+
+	}
+
+	return NULL;
+}
+
+static void ap_value_free(char **value)
+{
+	g_free(*value);
+
+	*value =3D NULL;
+}
+
+static void ap_delete(struct provider_info *data)
+{
+	struct ofono_gprs_provision_data *ap =3D data->ap;
+
+	DBG("%p", ap);
+
+	ap_value_free(&ap->name);
+
+	ap_value_free(&ap->apn);
+
+	ap_value_free(&ap->username);
+
+	ap_value_free(&ap->password);
+
+	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_ANY;
+
+	data->ap_count--;
+
+	data->ap--;
+}
+
+static void provider_info_free(struct provider_info *data)
+{
+	while (data->ap_count)
+		ap_delete(data);
+
+	g_free(data->spn);
+
+	data->spn =3D NULL;
+}
+
+static int ap_type_valid(struct ofono_gprs_provision_data *ap)
+{
+	switch (ap->type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ap_type_is_configured(struct provider_info *data,
+					enum ofono_gprs_context_type type)
+{
+	switch (type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+		return data->flags & PROVIDER_INFO_FLAG_INTERNET;
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+		return data->flags & PROVIDER_INFO_FLAG_MMS;
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		return data->flags & PROVIDER_INFO_FLAG_WAP;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void ap_type_mark_configured(struct provider_info *data,
+					enum ofono_gprs_context_type type)
+{
+	switch (type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+		data->flags |=3D PROVIDER_INFO_FLAG_INTERNET;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+		data->flags |=3D PROVIDER_INFO_FLAG_MMS;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		data->flags |=3D PROVIDER_INFO_FLAG_WAP;
+		break;
+	default:
+		break;
+	}
+}
+
+static inline int body_isprint(const gchar *text, gsize text_len)
+{
+	int print =3D 0;
+	int i;
+
+	for (i =3D 0; i < (int)text_len; i++) {
+		if (g_ascii_isprint(text[i])) {
+			print =3D 1;
+			break;
+		}
+	}
+
+	return print;
+}
+
+static inline int subparser_push(enum element_type from,
+					GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	enum element_type type;
+
+	type =3D element_type(element_name, context);
+
+	if (type =3D=3D from)
+		return 0;
+
+	if (!data->subparser[type].type ||
+			(data->subparser[type].match_type =3D=3D PARSER_MATCH_ONLY
+			&& !(data->flags & PROVIDER_INFO_FLAG_MATCH_FOUND)))
+		return 1;
+
+	DBG("%s", element_name);
+
+	if (data->subparser[type].parser.start_element)
+		data->subparser[type].parser.start_element(context,
+							element_name,
+							attribute_names,
+							attribute_values,
+							user_data, error);
+
+	g_markup_parse_context_push(context, &data->subparser[type].parser,
+					user_data);
+	return 1;
+}
+
+static inline int subparser_pop(enum element_type from,
+				GMarkupParseContext *context,
+				const gchar *element_name,
+				gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	enum element_type type;
+
+	type =3D element_type(element_name, context);
+
+	if (type =3D=3D from)
+		return 0;
+
+	if (!data->subparser[type].type ||
+			(data->subparser[type].match_type =3D=3D PARSER_MATCH_ONLY
+			&& !(data->flags & PROVIDER_INFO_FLAG_MATCH_FOUND)))
+		return 1;
+
+	if (data->subparser[type].parser.end_element)
+		data->subparser[type].parser.end_element(context, element_name,
+							user_data, error);
+
+	DBG("%s", element_name);
+
+	g_markup_parse_context_pop(context);
+
+	return 1;
+}
+
+static void network_id_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	const char *mcc =3D NULL, *mnc =3D NULL;
+	int i;
+
+	DBG("%s", element_name);
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
+			mcc =3D attribute_values[i];
+		if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
+			mnc =3D attribute_values[i];
+	}
+
+	if (g_strcmp0(mcc, data->match_mcc) =3D=3D 0 &&
+			g_strcmp0(mnc, data->match_mnc) =3D=3D 0)
+		data->flags |=3D PROVIDER_INFO_FLAG_MATCH_FOUND;
+}
+
+static void gsm_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	if (subparser_push(ELEMENT_GSM, context, element_name,
+				attribute_names, attribute_values,
+				user_data, error))
+		return;
+
+	DBG("%s", element_name);
+}
+
+static void gsm_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data;
+
+	if (subparser_pop(ELEMENT_GSM, context, element_name, user_data,
+				error))
+		return;
+
+	DBG("%s", element_name);
+
+	data =3D user_data;
+
+	if (data->flags & PROVIDER_INFO_FLAG_MATCH_FOUND)
+		g_set_error(error, data->g_error_domain, PARSER_OK,
+				"end parsing");
+}
+
+static void apn_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data;
+	int i;
+
+	if (subparser_push(ELEMENT_APN, context, element_name,
+				attribute_names, attribute_values,
+				user_data, error))
+		return;
+
+	DBG("%s", element_name);
+
+	data =3D user_data;
+
+	data->ap =3D ap_new(data);
+	if (data->ap =3D=3D NULL) {
+		g_set_error(error, data->g_error_domain, PARSER_ERROR,
+				"MAX_APS %d reached, end parsing", MAX_APS);
+		return;
+	}
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "value") =3D=3D TRUE) {
+			data->ap->apn =3D g_strdup(attribute_values[i]);
+			break;
+		}
+}
+
+static void apn_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data;
+
+	if (subparser_pop(ELEMENT_APN, context, element_name, user_data,
+				error))
+		return;
+
+	DBG("%s", element_name);
+
+	data =3D user_data;
+
+	if (!(data->flags & PROVIDER_INFO_FLAG_AP_COMMIT)) {
+		ap_delete(data);
+		return;
+	}
+
+	if (!ap_type_valid(data->ap)) {
+		DBG("AP '%s', type %s not present, AP ignored",
+			data->ap->apn, ap_type_name(data->ap->type));
+		ap_delete(data);
+		return;
+	}
+
+	ap_type_mark_configured(data, data->ap->type);
+}
+
+static void plan_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	int i;
+
+	DBG("%s", element_name);
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE) {
+			if (attribute_values[i] =3D=3D NULL) {
+				DBG("AP '%s', plan is not present, AP ignored",
+					data->ap->apn);
+				break;
+			}
+
+			if (g_str_equal(attribute_values[i],
+					"postpaid") =3D=3D TRUE ||
+					g_str_equal(attribute_values[i],
+						"prepaid") =3D=3D TRUE) {
+				data->flags |=3D PROVIDER_INFO_FLAG_AP_COMMIT;
+				return;
+			}
+
+			DBG("AP '%s', plan '%s' is not supported, AP ignored",
+				data->ap->apn, attribute_values[i]);
+			break;
+		}
+}
+
+static void usage_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **attribute_names,
+					const gchar **attribute_values,
+					gpointer user_data, GError **error)
+{
+	const char *usage =3D NULL;
+	struct provider_info *data;
+	struct ofono_gprs_provision_data *ap;
+	enum ofono_gprs_context_type type;
+	int i;
+
+	DBG("%s", element_name);
+
+	data =3D user_data;
+	ap =3D data->ap;
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			usage =3D attribute_values[i];
+
+	if (usage =3D=3D NULL)
+		return;
+
+	if (g_str_equal(usage, "internet") =3D=3D TRUE)
+		type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	else if (g_str_equal(usage, "mms") =3D=3D TRUE)
+		type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	else if (g_str_equal(usage, "wap") =3D=3D TRUE)
+		type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
+
+	if (ap_type_is_configured(data, type)) {
+		g_set_error(error, data->g_error_domain, PARSER_ERROR,
+				"AP '%s', multiple settings "
+				"for type '%s' found, fail provisioning",
+				ap->apn, ap_type_name(type));
+		ap_delete(data);
+		return;
+	}
+
+	ap->type =3D type;
+}
+
+static void element_text_set(GMarkupParseContext *context, const gchar *te=
xt,
+				gsize text_len, char **s)
+{
+	if (!body_isprint(text, text_len))
+		return;
+
+	DBG("%s '%*s'", g_markup_parse_context_get_element(context),
+		(int)text_len, text);
+
+	*s =3D g_strndup(text, text_len);
+}
+
+static void name_text(GMarkupParseContext *context, const gchar *text,
+			gsize text_len, gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+
+	element_text_set(context, text, text_len, &data->ap->name);
+}
+
+static void username_text(GMarkupParseContext *context,
+					const gchar *text, gsize text_len,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+
+	element_text_set(context, text, text_len, &data->ap->username);
+}
+
+static void password_text(GMarkupParseContext *context,
+					const gchar *text, gsize text_len,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+
+	element_text_set(context, text, text_len, &data->ap->password);
+}
+
+static void element_start(GMarkupParseContext *context,
+				const gchar *element_name,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+
+	if (subparser_push(ELEMENT_NONE, context, element_name, attribute_names,
+			attribute_values, user_data, error))
+		return;
+
+	if (data->flags & PROVIDER_INFO_FLAG_MATCH_FOUND)
+		DBG("%s", element_name);
+}
+
+static void element_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+
+	if (subparser_pop(ELEMENT_NONE, context, element_name, user_data,
+			error))
+		return;
+
+	if (data->flags & PROVIDER_INFO_FLAG_MATCH_FOUND)
+		DBG("%s", element_name);
+}
+
+static void parser_error(GMarkupParseContext *context,
+				GError *error, gpointer user_data)
+{
+	struct provider_info *data =3D user_data;
+	gint line_number;
+	gint char_number;
+
+	g_markup_parse_context_get_position(context, &line_number,
+						&char_number);
+
+	if (error->domain !=3D data->g_error_domain) {
+		ofono_error("Error parsing %s, line %d, char %d: %s",
+				PROVIDER_DATABASE, line_number,
+				char_number, error->message);
+		return;
+	}
+
+	if (error->code =3D=3D PARSER_OK)
+		return;
+
+	ofono_warn("%s, line %d, char %d: %s", PROVIDER_DATABASE, line_number,
+			char_number, error->message);
+
+	provider_info_free(data);
+}
+
+#define _SP(_type, _match, _start, _end, _text) {	\
+	ELEMENT_ ## _type,				\
+	_match,						\
+	{						\
+		_start,					\
+		_end,					\
+		_text,					\
+		NULL,					\
+		NULL,					\
+	}						\
+},
+
+static const struct element_parser subparser[ELEMENT_MAX] =3D {
+	_SP(NONE, PARSER_MATCH_ALL, NULL, NULL, NULL)
+	_SP(PROVIDER_NAME, PARSER_MATCH_ALL, NULL, NULL, NULL)
+	_SP(SPN, PARSER_MATCH_ALL, NULL, NULL, NULL)
+	_SP(GSM, PARSER_MATCH_ALL, gsm_start, gsm_end, NULL)
+	_SP(NETWORK_ID, PARSER_MATCH_ALL, network_id_start, NULL, NULL)
+	_SP(APN, PARSER_MATCH_ONLY, apn_start, apn_end, NULL)
+	_SP(USAGE, PARSER_MATCH_ONLY, usage_start, NULL, NULL)
+	_SP(PLAN, PARSER_MATCH_ONLY, plan_start, NULL, NULL)
+	_SP(NAME, PARSER_MATCH_ONLY, NULL, NULL, name_text)
+	_SP(USERNAME, PARSER_MATCH_ONLY, NULL, NULL, username_text)
+	_SP(PASSWORD, PARSER_MATCH_ONLY, NULL, NULL, password_text)
+};
+
+static const GMarkupParser parser =3D {
+	element_start,
+	element_end,
+	NULL,
+	NULL,
+	parser_error,
+};
+
+static void parse_database(const char *data, ssize_t size,
+				struct provider_info *provider_info)
+{
+	GMarkupParseContext *context;
+	gboolean result;
+
+	provider_info->flags =3D 0;
+
+	context =3D g_markup_parse_context_new(&parser,
+						G_MARKUP_TREAT_CDATA_AS_TEXT,
+						provider_info, NULL);
+
+	result =3D g_markup_parse_context_parse(context, data, size, NULL);
+	if (result =3D=3D TRUE)
+		result =3D g_markup_parse_context_end_parse(context, NULL);
+
+	g_markup_parse_context_free(context);
+}
+
+static int provider_info_lookup(struct provider_info *data, const char *mc=
c,
+				const char *mnc, const char *spn)
+{
+	struct stat st;
+	char *map;
+	int fd;
+
+	fd =3D open(PROVIDER_DATABASE, O_RDONLY);
+	if (fd < 0) {
+		ofono_error("Error: open(%s): %s", PROVIDER_DATABASE,
+				strerror(errno));
+		return -errno;
+	}
+
+	if (fstat(fd, &st) < 0) {
+		ofono_error("Error: fstat(%s): %s", PROVIDER_DATABASE,
+				strerror(errno));
+		close(fd);
+		return -errno;
+	}
+
+	map =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (map =3D=3D MAP_FAILED) {
+		ofono_error("Error: mmap(%s): %s", PROVIDER_DATABASE,
+				strerror(errno));
+		close(fd);
+		return -errno;
+	}
+
+	memset(data, 0, sizeof(struct provider_info));
+
+	data->subparser =3D subparser;
+
+	data->match_mcc =3D mcc;
+	data->match_mnc =3D mnc;
+	data->match_spn =3D spn;
+
+	parse_database(map, st.st_size, data);
+
+	munmap(map, st.st_size);
+
+	close(fd);
+
+	return data->ap_count;
+}
+
+static int mobile_broadband_provider_info_get(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	struct ofono_gprs_provision_data *aps;
+	int ap_count;
+	int i;
+
+	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	ap_count =3D provider_info_lookup(&provider_info, mcc, mnc, spn);
+	if (ap_count <=3D 0) {
+		provider_info_free(&provider_info);
+		return -ENOENT;
+	}
+
+	DBG("Found %d APs", ap_count);
+
+	aps =3D g_try_malloc_n(ap_count,
+				sizeof(struct ofono_gprs_provision_data));
+	if (aps =3D=3D NULL) {
+		ofono_error("Error provisioning APNs: memory exhausted");
+		provider_info_free(&provider_info);
+		return -ENOMEM;
+	}
+
+	memcpy(aps, provider_info.settings,
+		sizeof(struct ofono_gprs_provision_data) * ap_count);
+
+	memset(provider_info.settings, 0,
+		sizeof(struct ofono_gprs_provision_data) * ap_count);
+
+	*settings =3D aps;
+	*count =3D ap_count;
+
+	for (i =3D 0; i < ap_count; aps++, i++) {
+		DBG("Name: '%s'", aps->name);
+		DBG("APN: '%s'", aps->apn);
+		DBG("Type: %s", ap_type_name(aps->type));
+		DBG("Username: '%s'", aps->username);
+		DBG("Password: '%s'", aps->password);
+	}
+
+	provider_info_free(&provider_info);
+
+	return 0;
+}
+
+static struct ofono_gprs_provision_driver provision_driver =3D {
+	.name		=3D "Mobile Broadband Provider Info",
+	.get_settings	=3D mobile_broadband_provider_info_get
+};
+
+static int mobile_broadband_provider_info_init(void)
+{
+	provider_info.g_error_domain =3D g_quark_from_string(
+		provision_driver.name);
+
+	return ofono_gprs_provision_driver_register(&provision_driver);
+}
+
+static void mobile_broadband_provider_info_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(mobile_broadband_provider_info,
+			"Mobile Broadband Provider Info Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			mobile_broadband_provider_info_init,
+			mobile_broadband_provider_info_exit)
-- =

1.7.4.1


--===============8581908204107837696==--

