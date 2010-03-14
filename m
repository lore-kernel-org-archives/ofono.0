Content-Type: multipart/mixed; boundary="===============5978748873825360335=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Sun, 14 Mar 2010 13:02:52 -0700
Message-ID: <1268596972.3897.17.camel@localhost.localdomain>
In-Reply-To: <20100311140050.41e3e763@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5978748873825360335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Add option to use PPP to gsmdial.
> =

> Index: ofono/gatchat/gsmdial.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/gatchat/gsmdial.c	2010-03-10 16:58:09.773080389 -0800
> +++ ofono/gatchat/gsmdial.c	2010-03-10 17:06:45.071975512 -0800
> @@ -33,6 +33,9 @@
>  #include <glib.h>
>  #include <gatchat.h>
>  #include <gattty.h>
> +#include <arpa/inet.h>
> +#include <net/if.h>
> +#include <gatppp.h>

please put system includes before glib or internal includes.
 =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
> @@ -45,10 +48,14 @@
>  static gchar *option_apn =3D NULL;
>  static gint option_offmode =3D 0;
>  static gboolean option_legacy =3D FALSE;
> +static gboolean option_ppp =3D FALSE;
> +static gchar *option_username =3D NULL;
> +static gchar *option_passwd =3D NULL;

Just use option_password here. Shortening is not really useful in this
case.
 =

>  static GAtChat *control;
>  static GAtChat *modem;
>  static GMainLoop *event_loop;
> +static struct ppp_link *ppp;
>  =

>  enum state {
>  	STATE_NONE =3D 0,
> @@ -220,6 +227,70 @@
>  	g_at_chat_send(modem, buf, none_prefix, NULL, NULL, NULL);
>  }
>  =

> +static void print_ip_address(guint32 ip_addr)
> +{
> +	struct in_addr addr;
> +	addr.s_addr =3D ip_addr;
> +	g_print("%s\n", inet_ntoa(addr));

It is just fine to use printf() like everybody else. The g_print
function is pretty much stupid idea from GLib. Same as gchar should not
be used either.

The only case where g_print makes sense is in GLib based unit tests.

And personally I would do

static void print_ip_address(const char *label, guint32 addr)
{
}

That way you can later on just call one function and don't have to
manually print the label first.

> +static void ppp_connect(struct ppp_link *link, gint success, guint32 ip_=
addr,
> +		 guint32 dns1, guint32 dns2, gpointer user_data)
> +{
> +	if (success =3D=3D PPP_CONNECT_SUCCESS) {
> +		/* print out the negotiated address and dns server */
> +		g_print("Negotiated IP Address: ");
> +		print_ip_address(ip_addr);
> +
> +		g_print("Primary DNS Server: ");
> +		print_ip_address(dns1);
> +
> +		g_print("Secondary DNS Server: ");
> +		print_ip_address(dns2);
> +	} else {
> +		g_print("Failed to create PPP interface!\n");
> +	}
> +}

So personally I prefer the style more like this:

	if (success !=3D PPP_CONNECT_SUCCESS) {
		printf(... err msg ...);
		return;
	}

	printf(... success ...)

It is a lot better to get the error cases out of your way first and then
just focus on the success case. Instead of handling success and then
btw. we have to take of the error case.

> +static void connect_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	GIOChannel *channel;
> +
> +	if (!ok) {
> +		g_print("Unable to define context\n");
> +		exit(1);
> +	}
> +
> +	/* get the data IO channel */
> +	channel =3D g_at_chat_get_channel(modem);
> +	channel =3D g_io_channel_ref(channel);

What is this reference for? The g_at_ppp_new() should take a reference
on that channel anyway.

> +	/* shutdown gatchat */
> +	g_at_chat_unref(control);
> +	g_at_chat_unref(modem);

If you try to protect these, then I prefer that you call
g_at_chat_shutdown() here first and not directly unref them.

We should be able to keep the chat object around even if PPP is running
now.

> +	/* open ppp */
> +	ppp =3D g_at_ppp_new(channel);
> +	if (ppp) {
> +		g_print("Setting PPP Credentials to %s, %s\n", option_username,
> +				option_passwd);
> +		g_at_ppp_set_credentials(ppp, option_username,
> +					option_passwd);
> +
> +		/* set connect and disconnect callbacks */
> +		g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
> +		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
> +
> +		/* open the ppp connection */
> +		g_at_ppp_open(ppp);
> +	}
> +}

This should be again done like this:

	if (!ppp) {
		printf(... err msg ..)
		return;
	}

	g_at_ppp_set_credentials ....

>  static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>  {
>  	char buf[64];
> @@ -231,8 +302,14 @@
>  =

>  	if (option_legacy =3D=3D TRUE) {
>  			sprintf(buf, "ATD*99***%u#", option_cid);
> -			g_at_chat_send(modem, buf, none_prefix,
> -					NULL, NULL, NULL);
> +			if (option_ppp =3D=3D TRUE) {
> +				g_print("Option PPP enabled\n");
> +				g_at_chat_send(modem, buf, none_prefix,
> +						connect_cb, NULL, NULL);
> +			}
> +			else
> +				g_at_chat_send(modem, buf, none_prefix,
> +						NULL, NULL, NULL);

I don't like this at all. Lets move the option_ppp check into the
connect_cb function. Check for option_ppp in the callback and if not
set, then leave the callback.

>  	} else {
>  		sprintf(buf, "AT+CGACT=3D1,%u", option_cid);
>  		g_at_chat_send(control, buf, none_prefix,
> @@ -406,6 +483,12 @@
>  				"Specify CFUN offmode" },
>  	{ "legacy", 'l', 0, G_OPTION_ARG_NONE, &option_legacy,
>  				"Use ATD*99***<cid>#" },
> +	{ "ppp", 'P', 0, G_OPTION_ARG_NONE, &option_ppp,
> +				"Connect using PPP" },
> +	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
> +				"Specify PPP Username" },
> +	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_passwd,
> +				"Specifiy PPP Password" },

Small nitpick. Username and Password should be both lowercase.

Regards

Marcel



--===============5978748873825360335==--

