Content-Type: multipart/mixed; boundary="===============2658789466567757106=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Thu, 11 Mar 2010 22:51:32 -0800
Message-ID: <1268376692.2906.0.camel@localhost.localdomain>
In-Reply-To: <201003112024.35262.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2658789466567757106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +struct ppp_link * g_at_ppp_new(GIOChannel *modem);
> > +void g_at_ppp_open(struct ppp_link *link);
> > +void g_at_ppp_set_connect_function(struct ppp_link *link,
> > +			       GAtPPPConnectFunc callback, gpointer user_data);
> > +void g_at_ppp_set_disconnect_function(struct ppp_link *link,
> > +				  GAtPPPDisconnectFunc callback,
> > +				  gpointer user_data);
> > +void g_at_ppp_shutdown(struct ppp_link *link);
> > +void g_at_ppp_ref(struct ppp_link *link);
> > +void g_at_ppp_unref(struct ppp_link *link);
> =

> Almost forgot, let us not use struct ppp_link here, but instead use GAtPp=
p =

> *ppp as the parameter.  Again, mostly for consistency with how glib / gat=
chat =

> does this.

I am actually okay with GAtPPP since it looks much nicer. True camel
case is making it harder to read.

Regards

Marcel



--===============2658789466567757106==--

