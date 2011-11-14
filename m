Content-Type: multipart/mixed; boundary="===============5738295473786829582=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] mbpi: Add mbpi_lookup_cdma_provider_name API
Date: Mon, 14 Nov 2011 14:42:09 -0600
Message-ID: <4EC17D21.4000901@gmail.com>
In-Reply-To: <1321362255-11262-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5738295473786829582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 11/15/2011 07:04 AM, Philippe Nunes wrote:
> ---
>  plugins/mbpi.c |  151 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/mbpi.h |    2 +
>  2 files changed, 153 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index 1e41ecb..14aa339 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -58,6 +58,12 @@ struct gsm_data {
>  	gboolean allow_duplicates;
>  };
>  =

> +struct cdma_data {
> +	const char *match_sid;
> +	char *provider_name;
> +	gboolean match_found;
> +};
> +
>  const char *mbpi_ap_type(enum ofono_gprs_context_type type)
>  {
>  	switch (type) {
> @@ -281,6 +287,34 @@ static void apn_handler(GMarkupParseContext *context=
, struct gsm_data *gsm,
>  	g_markup_parse_context_push(context, &apn_parser, ap);
>  }
>  =

> +static void sid_handler(GMarkupParseContext *context,
> +				struct cdma_data *cdma,
> +				const gchar **attribute_names,
> +				const gchar **attribute_values,
> +				GError **error)
> +{
> +	const char *sid =3D NULL;
> +	int i;
> +
> +	if (cdma->match_found =3D=3D TRUE)
> +		return;

Why do you check this here, but also make the same exact check in
cdma_start?

> +
> +	for (i =3D 0; attribute_names[i]; i++) {
> +		if (g_str_equal(attribute_names[i], "value") =3D=3D TRUE)
> +			sid =3D attribute_values[i];

Just a small nitpick, but you probably want to break from the loop once
you find the value attribute.  Also, the braces around the outer for
loop are not really necessary in this case and the style preference is
not to include them.

> +	}
> +
> +	if (sid =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
> +					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
> +					"Missing attribute: sid");
> +		return;
> +	}
> +
> +	if (g_str_equal(sid, cdma->match_sid))
> +		cdma->match_found =3D TRUE;
> +}
> +
>  static void gsm_start(GMarkupParseContext *context, const gchar *element=
_name,
>  			const gchar **attribute_names,
>  			const gchar **attribute_values,
> @@ -347,6 +381,74 @@ static const GMarkupParser gsm_parser =3D {
>  	NULL,
>  };
>  =

> +static void cdma_start(GMarkupParseContext *context, const gchar *elemen=
t_name,
> +			const gchar **attribute_names,
> +			const gchar **attribute_values,
> +			gpointer userdata, GError **error)
> +{
> +	if (g_str_equal(element_name, "sid")) {
> +		struct cdma_data *cdma =3D userdata;
> +		/*
> +		 * For entries with multiple sid elements, don't bother
> +		 * searching if we already have a match
> +		 */
> +		if (cdma->match_found =3D=3D TRUE)
> +			return;
> +
> +		sid_handler(context, cdma, attribute_names, attribute_values,
> +				error);
> +	}
> +}
> +
> +static const GMarkupParser cdma_parser =3D {
> +	cdma_start,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +};
> +
> +static void provider_start(GMarkupParseContext *context,
> +				const gchar *element_name,
> +				const gchar **attribute_names,
> +				const gchar **attribute_values,
> +				gpointer userdata, GError **error)
> +{
> +	struct cdma_data *cdma =3D userdata;
> +
> +	if (g_str_equal(element_name, "name")) {
> +		if ((cdma->match_found =3D=3D FALSE) && (cdma->provider_name)) {

This is against our style guidelines, please get rid of the parens.

Also, do you ever expect this function to be called when match_found is
not FALSE?  The DTD is funny here, it says that several name tags can be
provided.  Not sure why anyone would do that or how we want to handle
this.  However, all name elements must be before any cdma or gsm tags.

> +			g_free(cdma->provider_name);
> +			cdma->provider_name =3D NULL;
> +		}
> +
> +		g_markup_parse_context_push(context, &text_parser,
> +						&cdma->provider_name);
> +	} else if (g_str_equal(element_name, "gsm"))
> +		g_markup_parse_context_push(context, &skip_parser, NULL);
> +	else if (g_str_equal(element_name, "cdma"))
> +		g_markup_parse_context_push(context, &cdma_parser, userdata);
> +}
> +
> +static void provider_end(GMarkupParseContext *context,
> +					const gchar *element_name,
> +					gpointer userdata, GError **error)
> +{
> +	if (g_str_equal(element_name, "name") ||
> +				g_str_equal(element_name, "gsm") ||
> +				g_str_equal(element_name, "cdma"))
> +		g_markup_parse_context_pop(context);
> +
> +}
> +
> +static const GMarkupParser provider_parser =3D {
> +	provider_start,
> +	provider_end,
> +	NULL,
> +	NULL,
> +	NULL,
> +};
> +
>  static void toplevel_gsm_start(GMarkupParseContext *context,
>  					const gchar *element_name,
>  					const gchar **atribute_names,
> @@ -379,6 +481,40 @@ static const GMarkupParser toplevel_gsm_parser =3D {
>  	NULL,
>  };
>  =

> +static void toplevel_cdma_start(GMarkupParseContext *context,
> +					const gchar *element_name,
> +					const gchar **atribute_names,
> +					const gchar **attribute_values,
> +					gpointer userdata, GError **error)
> +{
> +	struct cdma_data *cdma =3D userdata;
> +
> +	if (g_str_equal(element_name, "provider")) {
> +		if (cdma->match_found =3D=3D TRUE)
> +			g_markup_parse_context_push(context, &skip_parser,
> +								NULL);
> +		else
> +			g_markup_parse_context_push(context, &provider_parser,
> +								userdata);
> +	}
> +}
> +
> +static void toplevel_cdma_end(GMarkupParseContext *context,
> +					const gchar *element_name,
> +					gpointer userdata, GError **error)
> +{
> +	if (g_str_equal(element_name, "provider"))
> +		g_markup_parse_context_pop(context);
> +}
> +
> +static const GMarkupParser toplevel_cdma_parser =3D {
> +	toplevel_cdma_start,
> +	toplevel_cdma_end,
> +	NULL,
> +	NULL,
> +	NULL,
> +};
> +
>  static gboolean mbpi_parse(const GMarkupParser *parser, gpointer userdat=
a,
>  				GError **error)
>  {
> @@ -453,3 +589,18 @@ GSList *mbpi_lookup_apn(const char *mcc, const char =
*mnc,
>  =

>  	return gsm.apns;
>  }
> +
> +char *mbpi_lookup_cdma_provider_name(const char *sid, GError **error)
> +{
> +	struct cdma_data cdma;
> +
> +	memset(&cdma, 0, sizeof(cdma));
> +	cdma.match_sid =3D sid;
> +
> +	if (mbpi_parse(&toplevel_cdma_parser, &cdma, error) =3D=3D FALSE) {
> +		g_free(cdma.provider_name);
> +		cdma.provider_name =3D NULL;
> +	}
> +
> +	return cdma.provider_name;
> +}
> diff --git a/plugins/mbpi.h b/plugins/mbpi.h
> index 6d34358..64b7ea5 100644
> --- a/plugins/mbpi.h
> +++ b/plugins/mbpi.h
> @@ -25,3 +25,5 @@ void mbpi_ap_free(struct ofono_gprs_provision_data *dat=
a);
>  =

>  GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
>  			gboolean allow_duplicates, GError **error);
> +
> +char *mbpi_lookup_cdma_provider_name(const char *sid, GError **error);

Regards,
-Denis

--===============5738295473786829582==--

