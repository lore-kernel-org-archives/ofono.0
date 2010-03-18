Content-Type: multipart/mixed; boundary="===============6833641783266734150=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 5/6] IP support for PPP
Date: Thu, 18 Mar 2010 12:26:15 +0100
Message-ID: <1268911575.2700.134.camel@localhost.localdomain>
In-Reply-To: <20100317171200.5a7f1719@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6833641783266734150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > +static guint32 bytes_to_32(guint8 *bytes)
> > > +{
> > > +	union addr {
> > > +		guint8 bytes[4];
> > > +		guint32 word;
> > > +	} a;
> > > +
> > > +	memcpy(a.bytes, bytes, 4);
> > > +	return(ntohl(a.word));
> > > +}
> > =

> > This works, but is pretty ugly.
> > =

> > Doesn't GLib has functions to ensure retrieve unaligned data? BlueZ has
> > the GCC magic that is required to do this right.
> >
> =

> I have looked everywhere for something nice from glib, but I'm not
> seeing it.  As far as I can tell, most people just do the bit shifting
> manually -- but that's what I had originally and you didn't like it.
> So I'm only seeing 2 options here, this way or the original way.  If
> you know of the glib function to use, please let me know what it is.

I don't see how bit shifting is gonna help you against the unaligned
access of your buffer.

Regards

Marcel



--===============6833641783266734150==--

