Content-Type: multipart/mixed; boundary="===============2396065209005646127=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 1/5] Mobile broadband provider info plugin
Date: Fri, 05 Aug 2011 15:25:58 +0300
Message-ID: <1312547162-26420-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1312547162-26420-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2396065209005646127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mobile-broadband-provider-info.c |  470 ++++++++++++++++++++++++++=
++++
 1 files changed, 470 insertions(+), 0 deletions(-)
 create mode 100644 plugins/mobile-broadband-provider-info.c

diff --git a/plugins/mobile-broadband-provider-info.c b/plugins/mobile-broa=
dband-provider-info.c
new file mode 100644
index 0000000..005c526
--- /dev/null
+++ b/plugins/mobile-broadband-provider-info.c
@@ -0,0 +1,470 @@
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
+#define _(x) case x: return (#x)
+
+enum element_type {
+	ELEMENT_APN,
+	ELEMENT_USAGE,
+	ELEMENT_PLAN,
+	ELEMENT_NAME,
+	ELEMENT_NETWORK_ID,
+	ELEMENT_USERNAME,
+	ELEMENT_PASSWORD,
+	ELEMENT_NONE,
+};
+
+struct parser_data {
+	struct ofono_gprs_provision_data **settings;
+	struct ofono_gprs_provision_data *context;
+	int count;
+	const char *match_mcc;
+	const char *match_mnc;
+	enum element_type element;
+	gboolean match_found;
+};
+
+static const char *element_type_name(enum element_type element)
+{
+        switch (element) {
+                _(ELEMENT_APN);
+                _(ELEMENT_USAGE);
+                _(ELEMENT_PLAN);
+                _(ELEMENT_NAME);
+                _(ELEMENT_NETWORK_ID);
+                _(ELEMENT_USERNAME);
+                _(ELEMENT_PASSWORD);
+                _(ELEMENT_NONE);
+        }
+	return "ELEMENT_<UNKNOWN>";
+}
+
+static const char *context_type_name(enum ofono_gprs_context_type context)
+{
+        switch (context) {
+		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
+		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
+		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
+		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
+        }
+	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
+}
+
+static const char *context_plan_name(enum ofono_gprs_context_plan plan)
+{
+        switch (plan) {
+		_(OFONO_GPRS_CONTEXT_PLAN_PREPAID);
+		_(OFONO_GPRS_CONTEXT_PLAN_POSTPAID);
+        }
+	return "OFONO_GPRS_CONTEXT_PLAN_<UNKNOWN>";
+}
+
+static enum element_type element_type(const gchar *element)
+{
+	switch (element[0]) {
+	case 'a':
+		if (g_str_equal(element, "apn") =3D=3D TRUE)
+			return ELEMENT_APN;
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
+static void element_network_id_parse(struct parser_data *data,
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
+static struct ofono_gprs_provision_data *apn_try_new(struct parser_data *d=
ata)
+{
+	void *p;
+
+	p =3D g_try_realloc(*data->settings,
+				sizeof(struct ofono_gprs_provision_data) *
+				(data->count + 1));
+	if (p =3D=3D NULL)
+		return NULL;
+
+	*data->settings =3D p;
+
+	data->context =3D *data->settings + data->count++;
+
+	memset(data->context, 0, sizeof(struct ofono_gprs_provision_data));
+
+	return data->context;
+}
+
+static void element_apn_parse(struct parser_data *data,
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
+	if (apn_try_new(data) =3D=3D NULL) {
+		data->match_found =3D FALSE;
+		ofono_error("APN '%s' is ignored, memory exhausted", apn);
+		return;
+	}
+
+	data->context->apn =3D g_strdup(apn);
+}
+
+static void element_usage_parse(struct ofono_gprs_provision_data *context,
+				const gchar **attribute_names,
+				const gchar **attribute_values)
+{
+	const char *usage =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			usage =3D attribute_values[i];
+	}
+
+	if (usage =3D=3D NULL)
+		return;
+
+	if (g_str_equal(usage, "internet") =3D=3D TRUE)
+		context->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	else if (g_str_equal(usage, "mms") =3D=3D TRUE)
+		context->type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	else if (g_str_equal(usage, "wap") =3D=3D TRUE)
+		context->type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
+}
+
+static void element_plan_parse(struct ofono_gprs_provision_data *context,
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
+	if (plan =3D=3D NULL)
+		return;
+
+	if (g_str_equal(plan, "postpaid") =3D=3D TRUE)
+		context->plan =3D OFONO_GPRS_CONTEXT_PLAN_POSTPAID;
+	else if (g_str_equal(plan, "prepaid") =3D=3D TRUE)
+		context->plan =3D OFONO_GPRS_CONTEXT_PLAN_PREPAID;
+}
+
+static void element_start_parse(GMarkupParseContext *context,
+				const gchar *element_name,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				gpointer user_data, GError **error)
+{
+	struct parser_data *data =3D user_data;
+
+	data->element =3D element_type(element_name);
+
+	if (data->match_found =3D=3D TRUE)
+		DBG("%s: '%s'", element_type_name(data->element), element_name);
+
+	if (data->element =3D=3D ELEMENT_NETWORK_ID)
+		element_network_id_parse(data, attribute_names,
+						attribute_values);
+	if (data->match_found =3D=3D FALSE)
+		return;
+
+	switch (data->element) {
+	case ELEMENT_APN:
+		element_apn_parse(data, attribute_names, attribute_values);
+		break;
+	case ELEMENT_USAGE:
+		element_usage_parse(data->context, attribute_names,
+					attribute_values);
+		break;
+	case ELEMENT_PLAN:
+		element_plan_parse(data->context, attribute_names,
+					attribute_values);
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
+	struct parser_data *data =3D user_data;
+	gchar *body;
+
+	if (data->match_found =3D=3D FALSE || text_len =3D=3D 0)
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
+		data->context->username =3D g_strdup(body);
+		break;
+	case ELEMENT_PASSWORD:
+		data->context->password =3D g_strdup(body);
+		break;
+	case ELEMENT_NAME:
+		data->context->name =3D g_strdup(body);
+		break;
+	default:
+		break;
+	}
+
+	g_free(body);
+}
+
+static void element_end_parse(GMarkupParseContext *context,
+				const gchar *element_name,
+				gpointer user_data, GError **error)
+{
+	struct parser_data *data =3D user_data;
+
+	if (data->match_found =3D=3D FALSE)
+		return;
+
+	DBG("%s: '%s'", element_type_name(data->element), element_name);
+
+	if (g_str_equal(element_name, "gsm") =3D=3D TRUE)
+		data->match_found =3D FALSE;
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
+	struct parser_data *parser_data)
+{
+	GMarkupParseContext *context;
+	gboolean result;
+
+	parser_data->match_found =3D FALSE;
+
+	context =3D g_markup_parse_context_new(&parser,
+						G_MARKUP_TREAT_CDATA_AS_TEXT,
+						parser_data, NULL);
+
+	result =3D g_markup_parse_context_parse(context, data, size, NULL);
+	if (result =3D=3D TRUE)
+		result =3D g_markup_parse_context_end_parse(context, NULL);
+
+	g_markup_parse_context_free(context);
+}
+
+static int lookup_apn(const char *mcc, const char *mnc, const char *spn,
+			struct parser_data *data)
+{
+	struct stat st;
+	char *map;
+	int fd;
+
+	if (mcc =3D=3D NULL || mnc =3D=3D NULL)
+		return -1;
+
+	fd =3D open(PROVIDER_DATABASE, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	map =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (map =3D=3D NULL || map =3D=3D MAP_FAILED) {
+		close(fd);
+		return -1;
+	}
+
+	data->match_mcc =3D mcc;
+	data->match_mnc =3D mnc;
+
+	parse_database(map, st.st_size, data);
+
+	munmap(map, st.st_size);
+
+	close(fd);
+
+	return data->count;
+}
+
+static int mobile_broadband_provider_info_get(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	struct parser_data *data;
+	int i;
+
+	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	*settings =3D NULL;
+	*count =3D 0;
+
+	data =3D g_try_new0(struct parser_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	data->settings =3D settings;
+
+	*count =3D lookup_apn(mcc, mnc, NULL, data);
+	if (*count <=3D 0) {
+		g_free(data);
+		*settings =3D NULL;
+		return -ENOENT;
+	}
+
+	DBG("settings: %p, count: %d", *settings, *count);
+
+	for (i =3D 0; i < *count; i++) {
+		struct ofono_gprs_provision_data *context =3D *settings + i;
+		DBG("Name: '%s'", context->name);
+		DBG("APN: '%s'", context->apn);
+		DBG("Type: %s", context_type_name(context->type));
+		DBG("Plan: %s", context_plan_name(context->plan));
+		DBG("Username: '%s'", context->username);
+		DBG("Password: '%s'", context->password);
+	}
+
+	g_free(data);
+
+	return 0;
+}
+
+static struct ofono_gprs_provision_driver provider_info =3D {
+	.name		=3D "Mobile Broadband Provider Info",
+	.get_settings	=3D mobile_broadband_provider_info_get
+};
+
+static int mobile_broadband_provider_info_init(void)
+{
+	return ofono_gprs_provision_driver_register(&provider_info);
+}
+
+static void mobile_broadband_provider_info_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&provider_info);
+}
+
+OFONO_PLUGIN_DEFINE(mobile_broadband_provider_info,
+			"Mobile Broadband Provider Info Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			mobile_broadband_provider_info_init,
+			mobile_broadband_provider_info_exit)
-- =

1.7.1


--===============2396065209005646127==--

