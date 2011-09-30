Content-Type: multipart/mixed; boundary="===============2178482764769890179=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv8 4/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Fri, 30 Sep 2011 10:20:57 -0500
Message-ID: <4E85DE59.2090403@gmail.com>
In-Reply-To: <1317389474-16566-5-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2178482764769890179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/30/2011 08:31 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mbpi.c |  339 ++++++++++++++++++++++++++++++++++++--------------=
------
>  1 files changed, 221 insertions(+), 118 deletions(-)
> =

> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index 683ce03..0ae18d4 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -23,12 +23,12 @@
>  #include <config.h>
>  #endif
>  =

> -#include <string.h>
> -#include <fcntl.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> -#include <sys/types.h>
> +
> +#include <fcntl.h>
>  #include <errno.h>
> +#include <string.h>
>  #include <unistd.h>
>  =

>  #include <glib.h>
> @@ -44,8 +44,11 @@
>  =

>  #include "mbpi.h"
>  =

> +#define _(x) case x: return (#x)
> +
>  enum MBPI_ERROR {
>  	MBPI_ERROR_DUPLICATE,
> +	MBPI_ERROR_ENOMEM,

There's no point in introducing this one, just use
g_file_error_from_errno(ENOMEM)

>  };
>  =

>  struct gsm_data {
> @@ -56,21 +59,75 @@ struct gsm_data {
>  	gboolean allow_duplicates;
>  };
>  =

> +const char *mbpi_ap_type(enum ofono_gprs_context_type type)
> +{
> +	switch (type) {
> +		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
> +		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> +		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
> +		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
> +		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
> +	}
> +
> +	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
> +}
> +

As previously mentioned, this part belongs in a separate patch

>  static GQuark mbpi_error_quark(void)
>  {
>  	return g_quark_from_static_string("ofono-mbpi-error-quark");
>  }
>  =

> -void mbpi_provision_data_free(struct ofono_gprs_provision_data *data)
> +static void mbpi_g_set_error(GMarkupParseContext *context, GError **erro=
r,
> +				GQuark domain, gint code, const gchar *fmt, ...)
>  {
> -	g_free(data->name);
> -	g_free(data->apn);
> -	g_free(data->username);
> -	g_free(data->password);
> -	g_free(data->message_proxy);
> -	g_free(data->message_center);
> -
> -	g_free(data);
> +	va_list ap;
> +	gint line_number, char_number;
> +
> +	g_markup_parse_context_get_position(context, &line_number,
> +						&char_number);
> +	va_start(ap, fmt);
> +
> +	*error =3D g_error_new_valist(domain, code, fmt, ap);
> +
> +	va_end(ap);
> +
> +	g_prefix_error(error, "%s:%d ", MBPI_DATABASE, line_number);
> +}
> +
> +static struct ofono_gprs_provision_data *mbpi_ap_new(const char *apn)
> +{
> +	struct ofono_gprs_provision_data *ap;
> +	gsize len;
> +
> +	ap =3D g_try_new0(struct ofono_gprs_provision_data, 1);
> +	if (ap =3D=3D NULL)
> +		return NULL;
> +
> +	len =3D strlen(apn) + 1;
> +
> +	ap->apn =3D g_try_new(char, len);
> +	if (ap->apn =3D=3D NULL) {
> +		g_free(ap);
> +		return NULL;
> +	}
> +
> +	memcpy(ap->apn, apn, len);

g_strdup would be way cleaner here.

> +
> +	ap->proto =3D OFONO_GPRS_PROTO_IP;
> +
> +	return ap;
> +}
> +
> +void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
> +{
> +	g_free(ap->name);
> +	g_free(ap->apn);
> +	g_free(ap->username);
> +	g_free(ap->password);
> +	g_free(ap->message_proxy);
> +	g_free(ap->message_center);
> +
> +	g_free(ap);
>  }
>  =

>  static void text_handler(GMarkupParseContext *context,
> @@ -79,7 +136,27 @@ static void text_handler(GMarkupParseContext *context,
>  {
>  	char **string =3D userdata;
>  =

> -	*string =3D g_strndup(text, text_len);
> +	if (*string !=3D NULL) {
> +		/*
> +		 * For now, duplicate entries are just ignored. Since
> +		 * this parser is also used by lookup-apn tool, ofono_warn()
> +		 * can't be used here. As soon as the way is agreed,
> +		 * it might be good to report this.
> +		 */
> +		return;
> +	}

Are you sure you need this, under what circumstances would *string be
not NULL?

> +
> +	*string =3D g_try_new(char, text_len + 1);
> +	if (*string =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, mbpi_error_quark(),
> +				MBPI_ERROR_ENOMEM,
> +				"Can't allocate memory, memory exhausted");
> +		return;
> +	}
> +
> +	memcpy(*string, text, text_len);
> +
> +	(*string)[text_len] =3D '\0';

Why is g_strndup not good enough for you here?

>  }
>  =

>  static const GMarkupParser text_parser =3D {
> @@ -90,33 +167,34 @@ static const GMarkupParser text_parser =3D {
>  	NULL,
>  };
>  =

> -static void usage_handler(GMarkupParseContext *context,
> -				const gchar *text, gsize text_len,
> -				gpointer userdata, GError **error)
> +static void usage_start(GMarkupParseContext *context, const gchar *eleme=
nt_name,
> +			const gchar **attribute_names,
> +			const gchar **attribute_values,
> +			gpointer userdata, GError **error)
>  {
>  	enum ofono_gprs_context_type *type =3D userdata;
> +	const char *text =3D NULL;
> +	int i;
> +
> +	for (i =3D 0; attribute_names[i]; i++)
> +		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
> +			text =3D attribute_values[i];
>  =

> -	if (strncmp(text, "internet", text_len) =3D=3D 0)
> +	if (text =3D=3D NULL)
> +		return;
> +
> +	if (strcmp(text, "internet") =3D=3D 0)
>  		*type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
> -	else if (strncmp(text, "mms", text_len) =3D=3D 0)
> +	else if (strcmp(text, "mms") =3D=3D 0)
>  		*type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
> -	else if (strncmp(text, "wap", text_len) =3D=3D 0)
> +	else if (strcmp(text, "wap") =3D=3D 0)
>  		*type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
>  	else
> -		g_set_error(error, G_MARKUP_ERROR,
> -					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
> -					"Unknown usage attribute: %.*s",
> -					(int) text_len, text);
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
> +				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
> +				"Unknown usage attribute value: %s", text);
>  }
>  =

> -static const GMarkupParser usage_parser =3D {
> -	NULL,
> -	NULL,
> -	usage_handler,
> -	NULL,
> -	NULL,
> -};
> -
>  static void apn_start(GMarkupParseContext *context, const gchar *element=
_name,
>  			const gchar **attribute_names,
>  			const gchar **attribute_values,
> @@ -133,8 +211,8 @@ static void apn_start(GMarkupParseContext *context, c=
onst gchar *element_name,
>  		g_markup_parse_context_push(context, &text_parser,
>  						&apn->password);
>  	else if (g_str_equal(element_name, "usage"))
> -		g_markup_parse_context_push(context, &usage_parser,
> -						&apn->type);
> +		usage_start(context, element_name, attribute_names,
> +				attribute_values, &apn->type, error);
>  }
>  =

>  static void apn_end(GMarkupParseContext *context, const gchar *element_n=
ame,
> @@ -142,8 +220,7 @@ static void apn_end(GMarkupParseContext *context, con=
st gchar *element_name,
>  {
>  	if (g_str_equal(element_name, "name") ||
>  			g_str_equal(element_name, "username") ||
> -			g_str_equal(element_name, "password") ||
> -			g_str_equal(element_name, "usage"))
> +			g_str_equal(element_name, "password"))
>  		g_markup_parse_context_pop(context);
>  }
>  =

> @@ -155,7 +232,7 @@ static void apn_error(GMarkupParseContext *context, G=
Error *error,
>  	 * be called.  So we always perform cleanup of the allocated
>  	 * provision data
>  	 */
> -	mbpi_provision_data_free(userdata);
> +	mbpi_ap_free(userdata);
>  }
>  =

>  static const GMarkupParser apn_parser =3D {
> @@ -174,115 +251,138 @@ static const GMarkupParser skip_parser =3D {
>  	NULL,
>  };
>  =

> -static void gsm_start(GMarkupParseContext *context, const gchar *element=
_name,
> -			const gchar **attribute_names,
> -			const gchar **attribute_values,
> -			gpointer userdata, GError **error)
> +static void network_id_handler(GMarkupParseContext *context,
> +				struct gsm_data *gsm,
> +				const gchar **attribute_names,
> +				const gchar **attribute_values,
> +				GError **error)
>  {
> -	struct gsm_data *gsm =3D userdata;
> -
> -	if (g_str_equal(element_name, "network-id")) {
> -		const char *mcc =3D NULL, *mnc =3D NULL;
> -		int i;
> -
> -		/*
> -		 * For entries with multiple network-id elements, don't bother
> -		 * searching if we already have a match
> -		 */
> -		if (gsm->match_found =3D=3D TRUE)
> -			return;
> -
> -		for (i =3D 0; attribute_names[i]; i++) {
> -			if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
> -				mcc =3D attribute_values[i];
> -			if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
> -				mnc =3D attribute_values[i];
> -		}
> +	const char *mcc =3D NULL, *mnc =3D NULL;
> +	int i;
> +
> +	for (i =3D 0; attribute_names[i]; i++) {
> +		if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
> +			mcc =3D attribute_values[i];
> +		if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
> +			mnc =3D attribute_values[i];
> +	}
>  =

> -		if (mcc =3D=3D NULL) {
> -			g_set_error(error, G_MARKUP_ERROR,
> +	if (mcc =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
>  					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
>  					"Missing attribute: mcc");
> -			return;
> -		}
> +		return;
> +	}
>  =

> -		if (mnc =3D=3D NULL) {
> -			g_set_error(error, G_MARKUP_ERROR,
> +	if (mnc =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
>  					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
>  					"Missing attribute: mnc");
> -			return;
> -		}
> +		return;
> +	}
>  =

> -		if (g_str_equal(mcc, gsm->match_mcc) &&
> -				g_str_equal(mnc, gsm->match_mnc))
> -			gsm->match_found =3D TRUE;
> -	} else if (g_str_equal(element_name, "apn")) {
> -		int i;
> -		struct ofono_gprs_provision_data *pd;
> -		const char *apn;
> -
> -		if (gsm->match_found =3D=3D FALSE) {
> -			g_markup_parse_context_push(context,
> -							&skip_parser, NULL);
> -			return;
> -		}
> +	if (g_str_equal(mcc, gsm->match_mcc) &&
> +			g_str_equal(mnc, gsm->match_mnc))
> +		gsm->match_found =3D TRUE;
> +}
>  =

> -		for (i =3D 0, apn =3D NULL; attribute_names[i]; i++) {
> -			if (g_str_equal(attribute_names[i], "value") =3D=3D FALSE)
> -				continue;
> +static void apn_handler(GMarkupParseContext *context, struct gsm_data *g=
sm,
> +			const gchar **attribute_names,
> +			const gchar **attribute_values,
> +			GError **error)
> +{
> +	struct ofono_gprs_provision_data *ap;
> +	const char *apn;
> +	int i;
>  =

> -			apn =3D attribute_values[i];
> -			break;
> -		}
> +	if (gsm->match_found =3D=3D FALSE) {
> +		g_markup_parse_context_push(context, &skip_parser, NULL);
> +		return;
> +	}
> +
> +	for (i =3D 0, apn =3D NULL; attribute_names[i]; i++) {
> +		if (g_str_equal(attribute_names[i], "value") =3D=3D FALSE)
> +			continue;
> +
> +		apn =3D attribute_values[i];
> +		break;
> +	}
>  =

> -		if (apn =3D=3D NULL) {
> -			g_set_error(error, G_MARKUP_ERROR,
> +	if (apn =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
>  					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
>  					"APN attribute missing");
> -			return;
> -		}
> -
> -		pd =3D g_new0(struct ofono_gprs_provision_data, 1);
> -		pd->apn =3D g_strdup(apn);
> -		pd->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
> -		pd->proto =3D OFONO_GPRS_PROTO_IP;
> +		return;
> +	}
>  =

> -		g_markup_parse_context_push(context, &apn_parser, pd);
> +	ap =3D mbpi_ap_new(apn);
> +	if (ap =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, mbpi_error_quark(),
> +					MBPI_ERROR_ENOMEM,
> +					"Can't allocate memory for APN: '%s', "
> +					"memory exhausted", apn);
> +		return;
>  	}
> +
> +	g_markup_parse_context_push(context, &apn_parser, ap);
> +}
> +
> +static void gsm_start(GMarkupParseContext *context, const gchar *element=
_name,
> +			const gchar **attribute_names,
> +			const gchar **attribute_values,
> +			gpointer userdata, GError **error)
> +{
> +	if (g_str_equal(element_name, "network-id")) {
> +		struct gsm_data *gsm =3D userdata;
> +
> +		/*
> +		 * For entries with multiple network-id elements, don't bother
> +		 * searching if we already have a match
> +		 */
> +		if (gsm->match_found =3D=3D TRUE)
> +			return;
> +
> +		network_id_handler(context, userdata, attribute_names,
> +					attribute_values, error);
> +	} else if (g_str_equal(element_name, "apn"))
> +		apn_handler(context, userdata, attribute_names,
> +				attribute_values, error);
>  }

Separate patch please, something to the effect of mbpi: Split gsm_start
for readability

Add any new functionality after the refactoring patches.

>  =

>  static void gsm_end(GMarkupParseContext *context, const gchar *element_n=
ame,
>  			gpointer userdata, GError **error)
>  {
> -	struct gsm_data *gsm =3D userdata;
> +	struct gsm_data *gsm;
> +	struct ofono_gprs_provision_data *ap;
>  =

> -	if (g_str_equal(element_name, "apn")) {
> -		struct ofono_gprs_provision_data *apn =3D
> -					g_markup_parse_context_pop(context);
> +	if (!g_str_equal(element_name, "apn"))
> +		return;
>  =

> -		if (apn =3D=3D NULL)
> -			return;
> +	gsm =3D userdata;
>  =

> -		if (gsm->allow_duplicates =3D=3D FALSE) {
> -			GSList *l;
> +	ap =3D g_markup_parse_context_pop(context);
> +	if (ap =3D=3D NULL)
> +		return;
>  =

> -			for (l =3D gsm->apns; l; l =3D l->next) {
> -				struct ofono_gprs_provision_data *pd =3D l->data;
> +	if (gsm->allow_duplicates =3D=3D FALSE) {
> +		GSList *l;
>  =

> -				if (pd->type !=3D apn->type)
> -					continue;
> +		for (l =3D gsm->apns; l; l =3D l->next) {
> +			struct ofono_gprs_provision_data *pd =3D l->data;
> +
> +			if (pd->type !=3D ap->type)
> +				continue;
>  =

> -				g_set_error(error, mbpi_error_quark(),
> +			mbpi_g_set_error(context, error, mbpi_error_quark(),
>  						MBPI_ERROR_DUPLICATE,
>  						"Duplicate context detected");
>  =

> -				mbpi_provision_data_free(apn);
> -				return;
> -			}
> +			mbpi_ap_free(ap);
> +			return;
>  		}
> -
> -		gsm->apns =3D g_slist_append(gsm->apns, apn);
>  	}
> +
> +	gsm->apns =3D g_slist_append(gsm->apns, ap);
>  }

Fair enough, but separate patch please.  Something to the effect of:

mbpi: Reflow gsm_end()

>  =

>  static const GMarkupParser gsm_parser =3D {
> @@ -358,7 +458,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
>  	if (fd < 0) {
>  		g_set_error(error, G_FILE_ERROR,
>  				g_file_error_from_errno(errno),
> -				"open failed: %s", g_strerror(errno));
> +				"open(%s) failed: %s", MBPI_DATABASE,
> +				g_strerror(errno));

If you want to add filename information to the error, then please group
this as a separate patch.

>  		return NULL;
>  	}
>  =

> @@ -366,7 +467,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
>  		close(fd);
>  		g_set_error(error, G_FILE_ERROR,
>  				g_file_error_from_errno(errno),
> -				"fstat failed: %s", g_strerror(errno));
> +				"fstat(%s) failed: %s", MBPI_DATABASE,
> +				g_strerror(errno));

same comment as above

>  		return NULL;
>  	}
>  =

> @@ -375,7 +477,8 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
>  		close(fd);
>  		g_set_error(error, G_FILE_ERROR,
>  				g_file_error_from_errno(errno),
> -				"mmap failed: %s", g_strerror(errno));
> +				"mmap(%s) failed: %s", MBPI_DATABASE,
> +				g_strerror(errno));

same comment as above

>  		return NULL;
>  	}
>  =

> @@ -386,7 +489,7 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
>  =

>  	if (mbpi_parse(db, st.st_size, &gsm, error) =3D=3D FALSE) {
>  		for (l =3D gsm.apns; l; l =3D l->next)
> -			mbpi_provision_data_free(l->data);
> +			mbpi_ap_free(l->data);

See my comments to the previous patch, this should be in a separate patch.

>  =

>  		g_slist_free(gsm.apns);
>  		gsm.apns =3D NULL;

Please fix all the comments above, then I can have another look.  It is
too hard for me to tell what exactly you're changing when everything is
in one huge patch.

Regards,
-Denis

--===============2178482764769890179==--

