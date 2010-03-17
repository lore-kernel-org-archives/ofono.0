Content-Type: multipart/mixed; boundary="===============2933024202385975939=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Tue, 16 Mar 2010 23:42:35 -0700
Message-ID: <1268808155.2700.84.camel@localhost.localdomain>
In-Reply-To: <20100316171330.5fea7878@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2933024202385975939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,
 =

>  static GAtChat *control;
>  static GAtChat *modem;
>  static GMainLoop *event_loop;
> +static GAtPPP *ppp;

I hate myself for this nitpick, but please group GAtPPP *ppp with the
others before the mainloop variable.
 =

> +static void print_ip_address(guint32 ip_addr)
> +{
> +	struct in_addr addr;
> +	addr.s_addr =3D ip_addr;
> +	g_print("%s\n", inet_ntoa(addr));
> +}

Please use print_ip_address(const char *label, guint32 ip_addr) as
mentioned in the previous review.

> +	/* open ppp */
> +	ppp =3D g_at_ppp_new(channel);
> +	if (!ppp) {
> +		g_print("Unable to obtain PPP object\n");
> +		return;
> +	}

I would call it "Unable to create PPP object", because you are creating.
My understanding is the obtaining means that it would be there in the
first place. It is a nitpick.

Regards

Marcel



--===============2933024202385975939==--

