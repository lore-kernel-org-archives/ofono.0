Content-Type: multipart/mixed; boundary="===============2727531203522431388=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 3/3] Mobile broadband provider info plugin
Date: Tue, 30 Aug 2011 15:56:10 +0300
Message-ID: <1314708970-6521-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1314708970-6521-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2727531203522431388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mobile-broadband-provider-info.c |  695 ++++++++++++++++++++++++++=
++++
 1 files changed, 695 insertions(+), 0 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

diff --git a/plugins/mobile-broadband-provider-info.c b/plugins/mobile-broa=
dband-provider-info.c
new file mode 100644
index 0000000..f8c898e
--- /dev/null
+++ b/plugins/mobile-broadband-provider-info.c
@@ -0,0 +1,695 @@
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
+enum ap_type_configured_flags {
+	AP_TYPE_CONFIGURED_FLAG_INTERNET	=3D 0x1,
+	AP_TYPE_CONFIGURED_FLAG_MMS		=3D 0x2,
+	AP_TYPE_CONFIGURED_FLAG_WAP		=3D 0x4,
+};
+
+enum element_type {
+	ELEMENT_PROVIDER,
+	ELEMENT_SPN,
+	ELEMENT_NETWORK_ID,
+	ELEMENT_GSM,
+	ELEMENT_APN,
+	ELEMENT_USAGE,
+	ELEMENT_PLAN,
+	ELEMENT_NAME,
+	ELEMENT_USERNAME,
+	ELEMENT_PASSWORD,
+	ELEMENT_NONE,
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
+	gboolean match_found;
+	gboolean ap_ignore;
+	gboolean provisioning_fail;
+	guint8 ap_type_configured;
+};
+
+static struct provider_info provider_info;
+
+static const char *element_type_name(enum element_type element)
+{
+	switch (element) {
+		_(ELEMENT_PROVIDER);
+		_(ELEMENT_SPN);
+		_(ELEMENT_NETWORK_ID);
+		_(ELEMENT_GSM);
+		_(ELEMENT_APN);
+		_(ELEMENT_USAGE);
+		_(ELEMENT_PLAN);
+		_(ELEMENT_NAME);
+		_(ELEMENT_USERNAME);
+		_(ELEMENT_PASSWORD);
+		_(ELEMENT_NONE);
+	}
+
+	return "ELEMENT_<UNKNOWN>";
+}
+
+static const char *ap_type_name(enum ofono_gprs_context_type ap_type)
+{
+	switch (ap_type) {
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
+static enum element_type element_type(const gchar *element)
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
+		if (g_str_equal(element, "name") =3D=3D TRUE)
+			return ELEMENT_NAME;
+		if (g_str_equal(element, "network-id") =3D=3D TRUE)
+			return ELEMENT_NETWORK_ID;
+		break;
+	case 'p':
+		if (g_str_equal(element, "provider") =3D=3D TRUE)
+			return ELEMENT_PROVIDER;
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
+static void element_network_id_parse(struct provider_info *data,
+					const gchar **attribute_names,
+					const gchar **attribute_values)
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
+	if (g_strcmp0(mcc, data->match_mcc) =3D=3D 0 &&
+			g_strcmp0(mnc, data->match_mnc) =3D=3D 0) {
+		if (data->match_spn =3D=3D NULL) {
+			data->match_found =3D TRUE;
+			return;
+		}
+
+		if (g_strcmp0(data->spn, data->match_spn) =3D=3D 0)
+			data->match_found =3D TRUE;
+	}
+}
+
+static struct ofono_gprs_provision_data *ap_new(struct provider_info *data)
+{
+	if (data->ap_count < MAX_APS) {
+		struct ofono_gprs_provision_data *ap =3D
+			data->settings + data->ap_count++;
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
+static void element_apn_parse(struct provider_info *data,
+				const gchar **attribute_names,
+				const gchar **attribute_values)
+{
+	int i;
+
+	data->ap =3D ap_new(data);
+	if (data->ap =3D=3D NULL) {
+		DBG("MAX_APS %d reached, end parsing", MAX_APS);
+		data->match_found =3D FALSE;
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
+static void element_usage_parse(struct provider_info *data,
+				const gchar **attribute_names,
+				const gchar **attribute_values)
+{
+	struct ofono_gprs_provision_data *ap =3D data->ap;
+	const char *usage =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			usage =3D attribute_values[i];
+	}
+
+	if (usage =3D=3D NULL) {
+		DBG("AP '%s', no type, AP ignored", ap->apn);
+		data->ap_ignore =3D TRUE;
+		return;
+	}
+
+	if (g_str_equal(usage, "internet") =3D=3D TRUE)
+		ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	else if (g_str_equal(usage, "mms") =3D=3D TRUE)
+		ap->type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	else if (g_str_equal(usage, "wap") =3D=3D TRUE)
+		ap->type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
+}
+
+static void element_plan_parse(struct provider_info *data,
+				const gchar **attribute_names,
+				const gchar **attribute_values)
+{
+	int i;
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
+						"prepaid") =3D=3D TRUE)
+				return;
+
+			DBG("AP '%s', plan '%s' is not supported, AP ignored",
+				data->ap->apn, attribute_values[i]);
+			break;
+		}
+
+	data->ap_ignore =3D TRUE;
+}
+
+static void element_start_parse(GMarkupParseContext *context,
+				const gchar *element_name,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	enum element_type prev =3D data->element;
+
+	data->element =3D element_type(element_name);
+
+	if (prev =3D=3D ELEMENT_PROVIDER && data->element =3D=3D ELEMENT_NAME) {
+		data->element =3D ELEMENT_SPN;
+		g_free(data->spn);
+		data->spn =3D NULL;
+		data->match_found =3D TRUE;
+		return;
+	}
+
+	if (data->element =3D=3D ELEMENT_NETWORK_ID)
+		element_network_id_parse(data, attribute_names,
+						attribute_values);
+
+	if (data->match_found =3D=3D FALSE || data->ap_ignore =3D=3D TRUE)
+		return;
+
+	DBG("%s: '%s'", element_type_name(data->element), element_name);
+
+	switch (data->element) {
+	case ELEMENT_APN:
+		element_apn_parse(data, attribute_names, attribute_values);
+		break;
+	case ELEMENT_USAGE:
+		element_usage_parse(data, attribute_names, attribute_values);
+		break;
+	case ELEMENT_PLAN:
+		element_plan_parse(data, attribute_names, attribute_values);
+		break;
+	default:
+		break;
+	}
+}
+
+static gchar *body_text_parse(const gchar *text, gsize text_len)
+{
+	gchar *body =3D g_strndup(text, text_len);
+	gchar *print =3D NULL;
+	int i;
+
+	for (i =3D 0; body && body[i]; i++) {
+		if (g_ascii_isprint(body[i])) {
+			print =3D g_strescape(body, NULL);
+			break;
+		}
+	}
+
+	g_free(body);
+
+	return print;
+}
+
+static char *body_to_hex(const gchar *text, gsize text_len)
+{
+	char *hex;
+	guint i, j;
+
+	hex =3D g_try_malloc(text_len * 2 + 1);
+	if (hex =3D=3D NULL)
+		return NULL;
+
+	for (i =3D 0, j =3D 0; i < text_len; i++, j+=3D2)
+		g_snprintf(hex + j, 3, "%02x", (unsigned char)text[i]);
+
+	hex[j] =3D 0;
+
+	return hex;
+}
+
+static void element_body_parse(GMarkupParseContext *context,
+				const gchar *text, gsize text_len,
+				gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	struct ofono_gprs_provision_data *ap =3D data->ap;
+	gchar *body;
+
+	if (data->match_found =3D=3D FALSE || text_len =3D=3D 0 ||
+			data->ap_ignore =3D=3D TRUE)
+		return;
+
+	body =3D body_text_parse(text, text_len);
+	if (body =3D=3D NULL) {
+		if (data->element =3D=3D ELEMENT_SPN) {
+			char *hex =3D body_to_hex(text, text_len);
+			ofono_warn("Can't parse SPN body, len: %lu hex: %s",
+					text_len, hex);
+			g_free(hex);
+			data->match_found =3D FALSE;
+		}
+		return;
+	}
+
+	if (data->element =3D=3D ELEMENT_SPN) {
+		data->spn =3D g_strdup(body);
+		data->match_found =3D FALSE;
+		g_free(body);
+		return;
+	}
+
+	DBG("%s: '%s'", element_type_name(data->element), body);
+
+	switch (data->element) {
+	case ELEMENT_USERNAME:
+		ap->username =3D g_strdup(body);
+		break;
+	case ELEMENT_PASSWORD:
+		ap->password =3D g_strdup(body);
+		break;
+	case ELEMENT_NAME:
+		ap->name =3D g_strdup(body);
+		break;
+	default:
+		break;
+	}
+
+	g_free(body);
+}
+
+static gboolean ap_type_is_configured(struct provider_info *data,
+					struct ofono_gprs_provision_data *ap)
+{
+	switch (ap->type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+		if (data->ap_type_configured &
+			AP_TYPE_CONFIGURED_FLAG_INTERNET)
+			return TRUE;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+		if (data->ap_type_configured & AP_TYPE_CONFIGURED_FLAG_MMS)
+			return TRUE;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		if (data->ap_type_configured & AP_TYPE_CONFIGURED_FLAG_WAP)
+			return TRUE;
+		break;
+	default:
+		break;
+	}
+
+	return FALSE;
+}
+
+static gboolean ap_type_valid(struct ofono_gprs_provision_data *ap)
+{
+	switch (ap->type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		return TRUE;
+	default:
+		break;
+	}
+
+	return FALSE;
+}
+
+static void ap_type_mark_configured(struct provider_info *data,
+					struct ofono_gprs_provision_data *ap)
+{
+	switch (ap->type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+		data->ap_type_configured |=3D AP_TYPE_CONFIGURED_FLAG_INTERNET;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+		data->ap_type_configured |=3D AP_TYPE_CONFIGURED_FLAG_MMS;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		data->ap_type_configured |=3D AP_TYPE_CONFIGURED_FLAG_WAP;
+		break;
+	default:
+		break;
+	}
+}
+
+static gboolean ap_ignore(struct provider_info *data,
+				struct ofono_gprs_provision_data *ap)
+{
+	if (data->ap_ignore =3D=3D TRUE)
+		return TRUE;
+
+	if (ap_type_valid(ap) =3D=3D FALSE) {
+		DBG("AP '%s', type isn't supported or present, AP ignored",
+			ap->apn);
+		return TRUE;
+	}
+
+	if (ap_type_is_configured(data, ap) =3D=3D TRUE) {
+		DBG("AP '%s', multiple settings for type '%s' found, "
+			"fail provisioning",
+			ap->apn, ap_type_name(ap->type));
+		data->provisioning_fail =3D TRUE;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void element_end_parse(GMarkupParseContext *context,
+				const gchar *element_name,
+				gpointer user_data, GError **error)
+{
+	struct provider_info *data =3D user_data;
+	struct ofono_gprs_provision_data *ap =3D data->ap;
+	enum element_type element;
+
+	if (data->match_found =3D=3D FALSE)
+		return;
+
+	element =3D element_type(element_name);
+
+	if (data->ap_ignore =3D=3D FALSE)
+		DBG("%s: '%s'", element_type_name(element), element_name);
+
+	switch (element) {
+	case ELEMENT_APN:
+		if (ap_ignore(data, ap)) {
+			ap_delete(data);
+			if (data->provisioning_fail =3D=3D TRUE)
+				data->match_found =3D FALSE;
+		} else
+			ap_type_mark_configured(data, ap);
+
+		data->ap_ignore =3D FALSE;
+		break;
+	case ELEMENT_GSM:
+		data->match_found =3D FALSE;
+		break;
+	default:
+		break;
+	}
+}
+
+static void parser_error(GMarkupParseContext *context,
+				GError *error, gpointer user_data)
+{
+	ofono_error("Error parsing %s: %s", PROVIDER_DATABASE, error->message);
+}
+
+static const GMarkupParser parser =3D {
+	element_start_parse,
+	element_end_parse,
+	element_body_parse,
+	NULL,
+	parser_error,
+};
+
+static void parse_database(const char *data, ssize_t size,
+	struct provider_info *provider_info)
+{
+	GMarkupParseContext *context;
+	gboolean result;
+
+	provider_info->match_found =3D FALSE;
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
+static void provider_info_aps_free(struct provider_info *data)
+{
+	while (data->ap_count)
+		ap_delete(data);
+}
+
+static void provider_info_free(struct provider_info *data)
+{
+	g_free(data->spn);
+
+	data->spn =3D NULL;
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
+	if (ap_count <=3D 0 || provider_info.provisioning_fail =3D=3D TRUE) {
+		provider_info_aps_free(&provider_info);
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
+		provider_info_aps_free(&provider_info);
+		provider_info_free(&provider_info);
+		return -ENOMEM;
+	}
+
+	memcpy(aps, provider_info.settings,
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


--===============2727531203522431388==--

