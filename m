Content-Type: multipart/mixed; boundary="===============8951903593729074287=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 5/6] IP support for PPP
Date: Sun, 14 Mar 2010 13:22:37 -0700
Message-ID: <1268598157.3897.34.camel@localhost.localdomain>
In-Reply-To: <20100311140045.288e0b24@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8951903593729074287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Implement IPCP support.  Creates a tun interface to pass IP traffic.

this is not a proper review of the patch, just some general comments I
found by looking through the whole series.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/gatchat/gatppp_internal.h	2010-03-10 17:03:01.697955395 -0=
800
> +++ ofono/gatchat/gatppp_internal.h	2010-03-10 17:04:30.034088637 -0800
> @@ -66,6 +66,13 @@
>  	gpointer priv;
>  };
>  =

> +struct net_data {
> +	struct ppp_link *link;
> +	char *if_name;
> +	GIOChannel *channel;
> +	struct pppcp_data *ipcp;
> +};
> +
>  struct auth_data {
>  	guint16 proto;
>  	gpointer proto_data;
> @@ -111,6 +118,10 @@
>  void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method=
);
>  struct auth_data *auth_new(struct ppp_link *link);
>  void auth_free(struct auth_data *auth);
> +struct net_data *net_new(struct ppp_link *link);
> +void net_open(struct net_data *data);
> +void net_free(struct net_data *data);
> +void net_close(struct net_data *data);
>  #ifdef __cplusplus
>  }
>  #endif

If these are not public exported header files, then I don't want the
cplusplus or or circular inclusion protection ifdefs. I want developers
fall flat on their face if they try to do something stupid.

So first we will never compiler internal header files with C++ so that
is just pointless. They are internal and we will compile them with C
compiler.

For the circular inclusion protection, I want the compiler to complain.
Quite frankly if you need that for internal header files to make your
code work. You code is way too complex. I want the compiler to tell us.

> +static void ip_process_packet(gpointer priv, guint8 *packet)
> +{
> +	struct net_data *data =3D (struct net_data *)priv;

This assignment should not be needed. It is a void pointer and can be
assigned without casting.

As a general rule. Avoid casting as much as possible. Especially for
void pointer and function pointers. I want the compiler to do sanity
checks for us. Once you cast, all this extra protection is gone.

There is a reason for using -Wall -Wextra and -Werror and being pretty
much pedantic about it. Developers should use ./bootstrap-configure
since it enables all of these and more.

> +	GError *error =3D NULL;
> +        GIOStatus status;
> +        gsize bytes_written;
> +	guint16 len;

Please use an editor that can visualize whitespaces vs tabs.

> +struct net_data *net_new(struct ppp_link *link)
> +{
> +	struct net_data *data;
> +
> +	data =3D g_malloc0(sizeof(*data));
> +	if (data) {
> +		data->link =3D link;
> +		data->ipcp =3D ipcp_new(link);

So here is the tricky part with GLib memory allocations. The default
function will abort when OOM case happens. What you really wanted here
is actually g_try_malloc0.

And then again, please do it like this:

	data =3D g_try_malloc0(...)
	if (!data)
		return NULL;

	data->link =3D ...

> +/****** IPCP support ****************/
> +enum {
> +	/* supported codes */
> +	IPCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
> +				  (1 << CONFIGURE_ACK) |
> +				  (1 << CONFIGURE_NAK) |
> +				  (1 << CONFIGURE_REJECT) |
> +				  (1 << TERMINATE_REQUEST) |
> +				  (1 << TERMINATE_ACK) |
> +				  (1 << CODE_REJECT),
> +
> +	IPCP_PROTO		=3D 0x8021,
> +
> +	/* option types */
> +	IP_ADDRESSES		=3D 1,
> +	IP_COMPRESSION_PROTO	=3D 2,
> +	IP_ADDRESS		=3D 3,
> +	PRIMARY_DNS_SERVER	=3D 129,
> +	SECONDARY_DNS_SERVER	=3D 131,
> +};

I don't think enum is the right way for this. I can see it for the
option types, but for IPCP_PROTO and IPCP_SUPPORTED_CODES. I would say
just using simple defines is way better.

Feel free to convince me other way or show me what I have missed here.

> +static guint32 bytes_to_32(guint8 *bytes)
> +{
> +	return (bytes[0] | (bytes[1] << 8) | (bytes[2] << 16) |
> +			(bytes[3] << 24));
> +}

Shouldn't this be done by an endian aware function that can also handle
the unaligned case. I mentioned this before, on a non-x86 platform we
need to worry about the alignment if you just access the memory location
directly.

GLib should have proper functions for this. Just install the GLib
documentation package and devhelp program. That way can easily search
through it. Even when you are offline.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/gatchat/gatppp.h	2010-03-10 17:03:01.696955547 -0800
> +++ ofono/gatchat/gatppp.h	2010-03-10 17:04:30.035099659 -0800
> @@ -28,6 +28,7 @@
>  =

>  struct ppp_link;
>  struct auth_data;
> +struct net_data;

Denis and I mentioned it already, please keep proper namespacing for
public functions or structures in mind. It is really important.

Also here it might be not needed to expose them at all.

Regards

Marcel



--===============8951903593729074287==--

