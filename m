Content-Type: multipart/mixed; boundary="===============3239884753387606681=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Tue, 01 Feb 2011 22:19:42 +0200
Message-ID: <1296591582.2619.54.camel@tucson>
In-Reply-To: <1296477735.1520.202.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3239884753387606681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-01-31 at 13:42 +0100, ext Marcel Holtmann wrote:
> > > How does a normal user actually know what this means for him and the
> > > network he is using? Is the network actually honoring these values at
> > > all these days?
> > =

> > These are not clear to me either, so I don't see the point in exposing
> > this setting over the D-Bus interface. I would, however, err on the
> > side of flexibility here, and make this a configuration option in
> > main.conf (once that support is available in oFono).
> =

> we did talk a bit about expected operator defaults especially in the
> context of default character set etc. I think Portugal is such an
> exception where you have to start out with a proper character set if
> your SIM card is originated from there.
> =

> Maybe this is another one case where just picking a proper operator
> default is better than actually providing any option to change it.

Yes, some of these language variants are mandated by certain regulators,
some by operators. So certainly the default SMS alphabet should be a
main.conf item.

Whether or not to provide a corresponding D-Bus property is then a
separate question. Neither the validity period nor the alphabet strike
me as ones desperately needing a property, but especially the alphabet
might actually need one since it has such nasty backwards compatibility
issues.

Cheers,
Aki


--===============3239884753387606681==--

