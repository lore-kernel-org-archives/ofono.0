Content-Type: multipart/mixed; boundary="===============6039129673804853183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Fri, 15 Jul 2011 13:18:08 -0500
Message-ID: <4E208460.2010206@gmail.com>
In-Reply-To: <1310742737-5254-2-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6039129673804853183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 07/15/2011 10:12 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mobile-broadband-provider-info.c |  293 ++++++++++++++++++++++++=
++++++
>  1 files changed, 293 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/mobile-broadband-provider-info.c
> =

> diff --git a/plugins/mobile-broadband-provider-info.c b/plugins/mobile-br=
oadband-provider-info.c
> new file mode 100644
> index 0000000..770e4d8
> --- /dev/null
> +++ b/plugins/mobile-broadband-provider-info.c
> @@ -0,0 +1,293 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <glib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/types.h>
> +#include <ofono/log.h>
> +#include <ofono/plugin.h>
> +#include <ofono/modem.h>
> +#include <ofono/gprs-provision.h>
> +
> +#define MAX_SETTINGS 2
> +

Does mobile-broadband-provider actually have multiple settings yet? If
not, then this might need to be set to 1 until it does.

> +struct parser_data {
> +	struct ofono_gprs_provision_data **settings;
> +	struct ofono_gprs_provision_data *current;
> +	int count;
> +	const char *match_mcc;
> +	const char *match_mnc;
> +	const char *name;

Why is this const?  You're performing some nasty casting later because
it is.  If you're assigning the result of g_strdup to this variable,
then it shouldn't be const in the first place ;)

> +	const char *current_element;

My concern is that this is not valgrind safe, but more importantly, why
don't we use an enum here?  That would save us some string comparisons.

> +	gboolean match_found;
> +};
> +
> +static void parse_element_start(GMarkupParseContext *context,
> +				const gchar *element_name,
> +				const gchar **attribute_names,
> +				const gchar **attribute_values,
> +				gpointer user_data, GError **error)
> +{
> +	struct parser_data *data =3D user_data;
> +
> +	if (g_str_equal(element_name, "name") =3D=3D TRUE) {
> +		data->current_element =3D element_name;
> +		return;
> +	}
> +
> +	if (g_str_equal(element_name, "network-id") =3D=3D TRUE) {
> +		const char *mcc =3D NULL, *mnc =3D NULL;
> +		int i;
> +
> +		for (i =3D 0; attribute_names[i]; i++) {
> +			if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
> +				mcc =3D attribute_values[i];
> +			if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
> +				mnc =3D attribute_values[i];
> +		}
> +
> +		if (g_strcmp0(mcc, data->match_mcc) =3D=3D 0 &&
> +			g_strcmp0(mnc, data->match_mnc) =3D=3D 0)

Please see doc/coding-style.txt item M4, in particular bullet 2)

> +			data->match_found =3D TRUE;
> +	}
> +
> +	if (data->match_found =3D=3D FALSE)
> +		return;
> +
> +	data->current_element =3D element_name;
> +
> +	if (g_str_equal(element_name, "apn") =3D=3D TRUE) {
> +		const char *apn =3D NULL;
> +		int i;
> +
> +		for (i =3D 0; attribute_names[i]; i++) {
> +			if (g_str_equal(attribute_names[i], "value") =3D=3D TRUE)
> +				apn =3D attribute_values[i];
> +		}
> +
> +		if (data->count < MAX_SETTINGS) {
> +			data->current =3D *data->settings + data->count++;
> +		} else {
> +			data->match_found =3D FALSE;
> +			DBG("APN %s is ignored, max settings reached.", apn);
> +			return;
> +		}
> +
> +		if (data->current->apn =3D=3D NULL)
> +			data->current->apn =3D g_strdup(apn);
> +
> +		if (data->current->name =3D=3D NULL)
> +			data->current->name =3D g_strdup(data->name);
> +	}
> +}
> +
> +static void parse_element_end(GMarkupParseContext *context,
> +				const gchar *element_name,
> +				gpointer user_data, GError **error)
> +{
> +	struct parser_data *data =3D user_data;
> +
> +	if (g_str_equal(element_name, "gsm") =3D=3D TRUE ||
> +		g_str_equal(element_name, "cdma") =3D=3D TRUE) {

Same comment about doc/coding-style.txt M4 here

> +		data->match_found =3D FALSE;
> +		g_free((gpointer)data->name);

Here is that nasty cast ;)

> +		data->name =3D NULL;
> +	}
> +}
> +
> +static void parse_text(GMarkupParseContext *context,
> +			const gchar *text, gsize text_len,
> +			gpointer user_data, GError **error)
> +{
> +	struct parser_data *data =3D user_data;
> +
> +	if (g_strcmp0(data->current_element, "name") =3D=3D 0 &&
> +		data->name =3D=3D NULL) {

Another item M4 violation

> +		data->name =3D g_strndup(text, text_len);
> +		return;
> +	}
> +
> +	if (data->match_found =3D=3D FALSE || data->current =3D=3D NULL ||
> +		data->current->apn =3D=3D NULL)

Another item M4 violation

> +		return;
> +
> +	if (g_strcmp0(data->current_element, "username") =3D=3D 0)
> +		data->current->username =3D g_strndup(text, text_len);
> +	else if (g_strcmp0(data->current_element, "password") =3D=3D 0)
> +		data->current->password =3D g_strndup(text, text_len);
> +}
> +

I'm a little unclear on how we handle multiple matches of the same
mcc/mnc.  To my understanding these are different plans within the same
provider and some user intervention is required to select the right
plan.  Or it could be that the operator is actually an MVNO, which is
why the SPN provided by oFono in order to to distinguish between them.

So it sounds like that if we encounter entries where multiple matches
are possible, we should not actually provision the context.

> +static void parser_error(GMarkupParseContext *context,
> +				GError *error, gpointer user_data)
> +{
> +	ofono_error("Error parsing %s: %s", PROVIDER_DATABASE, error->message);
> +}
> +
> +static const GMarkupParser parser =3D {
> +	parse_element_start,
> +	parse_element_end,
> +	parse_text,
> +	NULL,
> +	parser_error,
> +};
> +
> +static void parse_database(const char *data, ssize_t size,
> +	struct parser_data *parser_data)
> +{
> +	GMarkupParseContext *context;
> +	gboolean result;
> +
> +	parser_data->match_found =3D FALSE;
> +
> +	context =3D g_markup_parse_context_new(&parser,
> +						G_MARKUP_TREAT_CDATA_AS_TEXT,
> +						parser_data, NULL);
> +
> +	result =3D g_markup_parse_context_parse(context, data, size, NULL);
> +	if (result =3D=3D TRUE)
> +		result =3D g_markup_parse_context_end_parse(context, NULL);
> +
> +	g_markup_parse_context_free(context);
> +}
> +
> +static int lookup_apn(const char *mcc, const char *mnc, const char *spn,
> +			struct parser_data *data)
> +{
> +	struct stat st;
> +	char *map;
> +	int fd;
> +
> +	if (mcc =3D=3D NULL || mnc =3D=3D NULL)
> +		return -1;
> +
> +	fd =3D open(PROVIDER_DATABASE, O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (fstat(fd, &st) < 0) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	map =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> +	if (map =3D=3D NULL || map =3D=3D MAP_FAILED) {
> +		close(fd);
> +		return -1;
> +	}
> +
> +	data->match_mcc =3D mcc;
> +	data->match_mnc =3D mnc;
> +
> +	parse_database(map, st.st_size, data);
> +
> +	munmap(map, st.st_size);
> +
> +	close(fd);
> +
> +	return data->count;
> +}
> +
> +static int mobile_broadband_provider_info_get(const char *mcc,
> +				const char *mnc, const char *spn,
> +				struct ofono_gprs_provision_data **settings,
> +				int *count)
> +{
> +	struct parser_data *data;
> +	int i;
> +
> +	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
> +
> +	*settings =3D NULL;
> +	*count =3D 0;
> +
> +	data =3D g_try_new0(struct parser_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	data->settings =3D settings;
> +
> +	*data->settings =3D g_try_new0(struct ofono_gprs_provision_data,
> +					MAX_SETTINGS);
> +	if (*data->settings =3D=3D NULL) {
> +		g_free(data);
> +		return -ENOMEM;
> +	}
> +
> +	*count =3D lookup_apn(mcc, mnc, NULL, data);
> +	if (*count <=3D 0) {
> +		g_free(*data->settings);
> +		g_free(data);
> +		return -ENOENT;
> +	}
> +
> +	DBG("settings: %p, count: %d", *settings, *count);
> +
> +	for (i =3D 0; i < *count; i++) {
> +		struct ofono_gprs_provision_data *pd =3D *settings + i;
> +
> +		pd->proto =3D OFONO_GPRS_PROTO_IP;
> +		pd->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
> +
> +		DBG("Name: %s", pd->name);
> +		DBG("APN: %s", pd->apn);
> +		DBG("Username: %s", pd->username);
> +		DBG("Password: %s", pd->password);
> +	}
> +
> +	g_free(data);
> +
> +	return 0;
> +}
> +
> +static struct ofono_gprs_provision_driver provider_info =3D {
> +	.name		=3D "Mobile Broadband Provider Info",
> +	.get_settings	=3D mobile_broadband_provider_info_get
> +};
> +
> +static int mobile_broadband_provider_info_init(void)
> +{
> +	return ofono_gprs_provision_driver_register(&provider_info);
> +}
> +
> +static void mobile_broadband_provider_info_exit(void)
> +{
> +	ofono_gprs_provision_driver_unregister(&provider_info);
> +}
> +
> +OFONO_PLUGIN_DEFINE(mobile_broadband_provider_info,
> +			"Mobile Broadband Provider Info Plugin",
> +			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
> +			mobile_broadband_provider_info_init,
> +			mobile_broadband_provider_info_exit)

Regards,
-Denis

--===============6039129673804853183==--

