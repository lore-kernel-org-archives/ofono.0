Content-Type: multipart/mixed; boundary="===============5086419082222640357=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Wed, 02 Feb 2011 15:03:47 +0200
Message-ID: <1296651827.2619.119.camel@tucson>
In-Reply-To: <4D491DDE.5000901@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5086419082222640357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-02-02 at 10:03 +0100, ext Andreas WESTIN wrote:
> On 2011-02-01 20:32, Aki Niemi wrote:
> > Like I replied earlier, I don't see the need for this. Also, it will not
> > work well with the isiusb plugin, which has the potential to work with
> > any ISI modem. I'm not willing to break that potential until we just
> > absolutely have to.
> =

> U8500 uses shrm driver and will not be recognized via isiusb.

I don't see what that has to do with the device supporting the "PC
suite" USB profile, which allows modem access using cdc_phonet.

> > So, my stance holds: we quirk based on resource ID and based on the
> > server's ISI version.
> =

>  From the information we have regarding ISI version from each server is =

> that it is not consistent, meaning the value you get is not really the =

> ISI version but the version of the server.

That is exactly what I meant. This version allows building quirks inside
the drivers. An example in pseudo-code:

if GIsiVersion.major =3D=3D 15 and GIsiVersion.minor >=3D 3:
	send( { FOO, value, filler, filler}, callback1 )
else:
	send( { FOO, value }, callback2 )

Cheers,
Aki


--===============5086419082222640357==--

