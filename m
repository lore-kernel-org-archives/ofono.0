Content-Type: multipart/mixed; boundary="===============9100431827575115429=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 3/3] Mobile broadband provider info plugin
Date: Thu, 25 Aug 2011 14:23:06 +0300
Message-ID: <1314271386-23201-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1314271386-23201-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9100431827575115429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mobile-broadband-provider-info.c |  604 ++++++++++++++++++++++++++=
++++
 1 files changed, 604 insertions(+), 0 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

diff --git a/plugins/mobile-broadband-provider-info.c b/plugins/mobile-broa=
dband-provider-info.c
new file mode 100644
index 0000000..dbe2962
--- /dev/null
+++ b/plugins/mobile-broadband-provider-info.c
@@ -0,0 +1,604 @@
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
+#define MAX_APS	3
+
+#define _(x) case x: return (#x)
+
+enum element_type {
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
+	const char *match_mcc;
+	const char *match_mnc;
+	const char *match_spn;
+	enum element_type element;
+	gboolean match_found;
+	gboolean ap_ignore;
+	gboolean ap_internet_configured;
+	gboolean ap_mms_configured;
+	gboolean ap_wap_configured;
+};
+
+static struct provider_info provider_info;
+
+static const char *element_type_name(enum element_type element)
+{
+	switch (element) {
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
+			g_strcmp0(mnc, data->match_mnc) =3D=3D 0)
+		data->match_found =3D TRUE;
+}
+
+static struct ofono_gprs_provision_data *ap_new(struct provider_info *data)
+{
+	if (data->ap_count < MAX_APS)
+		return data->settings + data->ap_count++;
+
+	return NULL;
+}
+
+static void ap_value_free(char **value)
+{
+	if (*value =3D=3D NULL)
+		return;
+
+	g_free(*value);
+
+	*value =3D NULL;
+}
+
+static void ap_delete(struct provider_info *data)
+{
+	struct ofono_gprs_provision_data *ap =3D data->ap;
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
+	const char *apn =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "value") =3D=3D TRUE)
+			apn =3D attribute_values[i];
+	}
+
+	data->ap =3D ap_new(data);
+	if (data->ap =3D=3D NULL) {
+		DBG("AP '%s', MAX_APS %d reached, AP ignored", apn, MAX_APS);
+		data->match_found =3D FALSE;
+		return;
+	}
+
+	data->ap->apn =3D g_strdup(apn);
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
+	const char *plan =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			plan =3D attribute_values[i];
+	}
+
+	if (plan !=3D NULL && g_str_equal(plan, "postpaid") =3D=3D TRUE)
+		return;
+
+	DBG("AP '%s', plan '%s', plan is not postpaid, AP ignored",
+		data->ap->apn, plan);
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
+
+	data->element =3D element_type(element_name);
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
+	if (body)
+		g_free(body);
+
+	return print;
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
+	if (body =3D=3D NULL)
+		return;
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
+		if (g_strcmp0(body, data->match_spn) =3D=3D 0) {
+			ap->name =3D g_strdup(body);
+			break;
+		}
+
+		DBG("AP '%s', SPN '%s', is not our SPN, AP ignored", ap->apn,
+			body);
+		data->ap_ignore =3D TRUE;
+		break;
+	default:
+		break;
+	}
+
+	g_free(body);
+}
+
+static gboolean *ap_type_configured_flag_get(struct provider_info *data,
+					struct ofono_gprs_provision_data *ap)
+{
+	gboolean *flag =3D NULL;
+
+	switch (ap->type) {
+	case OFONO_GPRS_CONTEXT_TYPE_INTERNET:
+		flag =3D &data->ap_internet_configured;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_MMS:
+		flag =3D &data->ap_mms_configured;
+		break;
+	case OFONO_GPRS_CONTEXT_TYPE_WAP:
+		flag =3D &data->ap_wap_configured;
+		break;
+	default:
+		break;
+	}
+
+	return flag;
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
+static gboolean ap_type_configured(struct provider_info *data,
+					struct ofono_gprs_provision_data *ap)
+{
+	gboolean *flag =3D ap_type_configured_flag_get(data, ap);
+
+	if (flag =3D=3D NULL)
+		return FALSE;
+
+	return *flag;
+}
+
+static void ap_type_mark_configured(struct provider_info *data,
+					struct ofono_gprs_provision_data *ap)
+{
+	gboolean *flag =3D ap_type_configured_flag_get(data, ap);
+
+	if (flag !=3D NULL)
+		*flag =3D TRUE;
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
+	if (ap_type_configured(data, ap) =3D=3D TRUE) {
+		DBG("AP '%s', type %s is already configured, AP ignored",
+			ap->apn, ap_type_name(ap->type));
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
+		if (ap_ignore(data, ap))
+			ap_delete(data);
+		else
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
+	if (ap_count <=3D 0)
+		return -ENOENT;
+
+	DBG("Found %d APs", ap_count);
+
+	aps =3D g_try_malloc_n(ap_count,
+				sizeof(struct ofono_gprs_provision_data));
+	if (aps =3D=3D NULL) {
+		ofono_error("Error provisioning APNs: memory exhausted");
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


--===============9100431827575115429==--

