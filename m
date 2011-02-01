Content-Type: multipart/mixed; boundary="===============0274838282365721339=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Tue, 01 Feb 2011 21:32:56 +0200
Message-ID: <1296588776.2619.30.camel@tucson>
In-Reply-To: <1296574993.1520.272.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0274838282365721339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-02-01 at 16:43 +0100, ext Marcel Holtmann wrote:
> > +enum isi_version {
> > +	ISI_20 =3D 0,
> > +	ISI_25 =3D 1
> > +};
> =

> so what is the final decision here now. ISI doing auto-detection and
> this gets not exposed to the modem drivers or we do.

Like I replied earlier, I don't see the need for this. Also, it will not
work well with the isiusb plugin, which has the potential to work with
any ISI modem. I'm not willing to break that potential until we just
absolutely have to.

So, my stance holds: we quirk based on resource ID and based on the
server's ISI version.

I'm starting to think me just saying this out loud is not concrete
enough, so I guess one way forward here could be for me to go ahead and
adapt e.g. the netreg driver to work with N900 and later ISI modems. The
netreg driver would make a good example, as it is one of those where the
resource ID changes post N900, and the messages do vary based on it.

Cheers,
Aki


--===============0274838282365721339==--

