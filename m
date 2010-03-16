Content-Type: multipart/mixed; boundary="===============5897544542226568696=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Tue, 16 Mar 2010 16:52:19 -0700
Message-ID: <20100316165219.6eb66c0a@kcaccard-MOBL3>
In-Reply-To: <1268596972.3897.17.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5897544542226568696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Mar 2010 13:02:52 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> >  =

> > +static void print_ip_address(guint32 ip_addr)
> > +{
> > +	struct in_addr addr;
> > +	addr.s_addr =3D ip_addr;
> > +	g_print("%s\n", inet_ntoa(addr));
> =

> It is just fine to use printf() like everybody else. The g_print
> function is pretty much stupid idea from GLib. Same as gchar should not
> be used either.
> =

> The only case where g_print makes sense is in GLib based unit tests.

OK, but I think I should leave this the way it is just because it
is consistent with the rest of gsmdial.

--===============5897544542226568696==--

