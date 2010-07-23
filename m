Content-Type: multipart/mixed; boundary="===============5495818677623986781=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] stkutil: convert img to xpm
Date: Thu, 22 Jul 2010 19:55:16 -0700
Message-ID: <1279853716.2621.17.camel@localhost.localdomain>
In-Reply-To: <4C48A472.7040605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5495818677623986781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> >> Also, XPM is pretty flexible here, there's no need to use 0-9 digits
> >> only.  For instance, you can do two look up tables, one for images with
> >> LUTs up to 64 entries and another for LUTs with more.  E.g.
> >>
> >> A-Za-z0-9@$ and 'aa ab ac .. pp' or something like that.
> > =

> > I realize this - this was an implementation choice to keep the code
> > less complex, thinking that it would be better to favor that vs.
> > saving some bytes on the xpm.
> =

> The wording on my part was poor.  Of course you knew this.  My intent
> was to encourage the optimization of the xpm format.  Remember these
> images are up to 64k in size, so a difference between transferring /
> using up 128k and 192k respectively is quite significant.  The added
> (minor) code complexity is definitely worth it.

we need such optimization in this case. We are already accepting a
penalty hit by having to transfer the images over D-Bus. So every single
byte we can save here is a win.

Regards

Marcel



--===============5495818677623986781==--

