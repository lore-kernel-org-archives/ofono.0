Content-Type: multipart/mixed; boundary="===============3381478076253915884=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 5/6] IP support for PPP
Date: Wed, 17 Mar 2010 17:12:00 -0700
Message-ID: <20100317171200.5a7f1719@kcaccard-MOBL3>
In-Reply-To: <1268807913.2700.80.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3381478076253915884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Mar 2010 23:38:33 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:
> > +static guint32 bytes_to_32(guint8 *bytes)
> > +{
> > +	union addr {
> > +		guint8 bytes[4];
> > +		guint32 word;
> > +	} a;
> > +
> > +	memcpy(a.bytes, bytes, 4);
> > +	return(ntohl(a.word));
> > +}
> =

> This works, but is pretty ugly.
> =

> Doesn't GLib has functions to ensure retrieve unaligned data? BlueZ has
> the GCC magic that is required to do this right.
>

I have looked everywhere for something nice from glib, but I'm not
seeing it.  As far as I can tell, most people just do the bit shifting
manually -- but that's what I had originally and you didn't like it.
So I'm only seeing 2 options here, this way or the original way.  If
you know of the glib function to use, please let me know what it is.

--===============3381478076253915884==--

