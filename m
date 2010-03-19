Content-Type: multipart/mixed; boundary="===============0111979665325271044=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 5/6] IP support for PPP
Date: Fri, 19 Mar 2010 10:58:42 -0700
Message-ID: <20100319105842.0864fa55@kcaccard-MOBL3>
In-Reply-To: <1268911575.2700.134.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0111979665325271044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Mar 2010 12:26:15 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> > > > +static guint32 bytes_to_32(guint8 *bytes)
> > > > +{
> > > > +	union addr {
> > > > +		guint8 bytes[4];
> > > > +		guint32 word;
> > > > +	} a;
> > > > +
> > > > +	memcpy(a.bytes, bytes, 4);
> > > > +	return(ntohl(a.word));
> > > > +}
> > > =

> > > This works, but is pretty ugly.
> > > =

> > > Doesn't GLib has functions to ensure retrieve unaligned data? BlueZ h=
as
> > > the GCC magic that is required to do this right.
> > >
> > =

> > I have looked everywhere for something nice from glib, but I'm not
> > seeing it.  As far as I can tell, most people just do the bit shifting
> > manually -- but that's what I had originally and you didn't like it.
> > So I'm only seeing 2 options here, this way or the original way.  If
> > you know of the glib function to use, please let me know what it is.
> =

> I don't see how bit shifting is gonna help you against the unaligned
> access of your buffer.
> =

> Regards
> =

> Marcel
> =

> =


I wound up implementing both the packed data structures to represent
PPP packets (etc) as well as get_unaligned() to handle cases like this.
It does still seem hard to believe that glib doesn't already have a
way to access unaligned data, but I got tired of looking for it.

--===============0111979665325271044==--

