Content-Type: multipart/mixed; boundary="===============2735991380908424405=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 6/6] Add PPP option to gsmdial
Date: Tue, 23 Mar 2010 02:30:34 -0300
Message-ID: <20100323053034.GA17646@vigoh>
In-Reply-To: <1269302761-20125-7-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2735991380908424405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Kristen Carlson Accardi <kristen@linux.intel.com> [2010-03-22 17:06:01 =
-0700]:

> Implement new options for gsmdial to use PPP and set the user name and
> password for authentication if needed.
> ---
>  gatchat/gsmdial.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 84 insertions(+), 3 deletions(-)
> =

> diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
> index 2087e70..aee9eea 100644
> --- a/gatchat/gsmdial.c
> +++ b/gatchat/gsmdial.c
> @@ -36,6 +36,7 @@
>  #include <glib.h>
>  #include <gatchat.h>
>  #include <gattty.h>
> +#include <gatppp.h>
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
> @@ -48,7 +49,11 @@ static gint option_cid =3D 0;
>  static gchar *option_apn =3D NULL;
>  static gint option_offmode =3D 0;
>  static gboolean option_legacy =3D FALSE;
> +static gboolean option_ppp =3D FALSE;
> +static gchar *option_username =3D NULL;
> +static gchar *option_password =3D NULL;
>  =

> +static GAtPPP *ppp;
>  static GAtChat *control;
>  static GAtChat *modem;
>  static GMainLoop *event_loop;
> @@ -223,6 +228,76 @@ static void at_cgact_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	g_at_chat_send(modem, buf, none_prefix, NULL, NULL, NULL);
>  }
>  =

> +static void print_ip_address(const char *label, guint32 ip_addr)
> +{
> +	struct in_addr addr;
> +	char buf[INET_ADDRSTRLEN];
> +
> +	addr.s_addr =3D ip_addr;
> +
> +	if (inet_ntop(AF_INET, &addr, buf, INET_ADDRSTRLEN))
> +		g_print("%s: %s\n", label, buf);
> +}
> +
> +static void ppp_connect(GAtPPP *ppp, GAtPPPConnectStatus success,
> +			guint32 ip_addr, guint32 dns1, guint32 dns2,
> +			gpointer user_data)
> +{
> +	if (success !=3D G_AT_PPP_CONNECT_SUCCESS) {
> +		g_print("Failed to create PPP interface!\n");
> +		return;
> +	}
> +
> +	/* print out the negotiated address and dns server */
> +	print_ip_address("IP Address", ip_addr);
> +	print_ip_address("Primary DNS Server", dns1);
> +	print_ip_address("Secondary DNS Server", dns2);
> +}
> +
> +static void ppp_disconnect(GAtPPP *ppp, gpointer user_data)
> +{
> +	g_print("PPP Link down\n");
> +}
> +
> +static void connect_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	GIOChannel *channel;
> +
> +	if (!ok) {
> +		g_print("Unable to define context\n");
> +		exit(1);

I guess we should not call exit here. Just return.

> +	}
> +
> +	if (option_ppp =3D=3D FALSE)
> +		return;
> +
> +	/* get the data IO channel */
> +	channel =3D g_at_chat_get_channel(modem);
> +
> +	/*
> +	 * shutdown gatchat or else it tries to take all the input
> +	 * from the modem and does not let PPP get it.
> +	 */
> +	g_at_chat_shutdown(control);
> +	g_at_chat_shutdown(modem);
> +
> +	/* open ppp */
> +	ppp =3D g_at_ppp_new(channel);
> +	if (!ppp) {
> +		g_print("Unable to create PPP object\n");
> +		return;
> +	}
> +	g_at_ppp_set_credentials(ppp, option_username,
> +				option_password);
> +
> +	/* set connect and disconnect callbacks */
> +	g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
> +	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
> +
> +	/* open the ppp connection */
> +	g_at_ppp_open(ppp);
> +}
> +
>  static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>  {
>  	char buf[64];
> @@ -233,9 +308,9 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  	}
>  =

>  	if (option_legacy =3D=3D TRUE) {
> -			sprintf(buf, "ATD*99***%u#", option_cid);
> -			g_at_chat_send(modem, buf, none_prefix,
> -					NULL, NULL, NULL);
> +		sprintf(buf, "ATD*99***%u#", option_cid);
> +		g_at_chat_send(modem, buf, none_prefix,
> +				connect_cb, NULL, NULL);
>  	} else {
>  		sprintf(buf, "AT+CGACT=3D1,%u", option_cid);
>  		g_at_chat_send(control, buf, none_prefix,
> @@ -452,6 +527,12 @@ static GOptionEntry options[] =3D {
>  				"Specify CFUN offmode" },
>  	{ "legacy", 'l', 0, G_OPTION_ARG_NONE, &option_legacy,
>  				"Use ATD*99***<cid>#" },
> +	{ "ppp", 'P', 0, G_OPTION_ARG_NONE, &option_ppp,
> +				"Connect using PPP" },
> +	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
> +				"Specify PPP username" },
> +	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
> +				"Specifiy PPP password" },
>  	{ NULL },
>  };
>  =

> -- =

> 1.6.6.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

-- =

Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

--===============2735991380908424405==--

