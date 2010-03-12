Content-Type: multipart/mixed; boundary="===============6756162173383008173=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Thu, 11 Mar 2010 20:24:35 -0600
Message-ID: <201003112024.35262.denkenz@gmail.com>
In-Reply-To: <20100311140030.0ce0b25f@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6756162173383008173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +struct ppp_link * g_at_ppp_new(GIOChannel *modem);
> +void g_at_ppp_open(struct ppp_link *link);
> +void g_at_ppp_set_connect_function(struct ppp_link *link,
> +			       GAtPPPConnectFunc callback, gpointer user_data);
> +void g_at_ppp_set_disconnect_function(struct ppp_link *link,
> +				  GAtPPPDisconnectFunc callback,
> +				  gpointer user_data);
> +void g_at_ppp_shutdown(struct ppp_link *link);
> +void g_at_ppp_ref(struct ppp_link *link);
> +void g_at_ppp_unref(struct ppp_link *link);

Almost forgot, let us not use struct ppp_link here, but instead use GAtPpp =

*ppp as the parameter.  Again, mostly for consistency with how glib / gatch=
at =

does this.

Regards,
-Denis

--===============6756162173383008173==--

