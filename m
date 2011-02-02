Content-Type: multipart/mixed; boundary="===============1645328932135538457=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Wed, 02 Feb 2011 10:03:26 +0100
Message-ID: <4D491DDE.5000901@stericsson.com>
In-Reply-To: <1296588776.2619.30.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1645328932135538457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 2011-02-01 20:32, Aki Niemi wrote:
> Like I replied earlier, I don't see the need for this. Also, it will not
> work well with the isiusb plugin, which has the potential to work with
> any ISI modem. I'm not willing to break that potential until we just
> absolutely have to.

U8500 uses shrm driver and will not be recognized via isiusb.

> So, my stance holds: we quirk based on resource ID and based on the
> server's ISI version.

 From the information we have regarding ISI version from each server is =

that it is not consistent, meaning the value you get is not really the =

ISI version but the version of the server.

/Andreas

--===============1645328932135538457==--

