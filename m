Content-Type: multipart/mixed; boundary="===============6407681850748916888=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 17:12:09 +0200
Message-ID: <1244733129.27363.24.camel@violet>
In-Reply-To: <200906110932.39143.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6407681850748916888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > I wasn't aware of this and so it might be better to just expose these as
> > an operator id string. So we might not even split into MCC/MNC at all
> > since it is meaning less anyway.
> =

> I'm tending to agree, which is why I wanted to start the conversation.  =

> =

> By the way, just so that we're all clear, here's the relevant quote from =
the =

> standard:
> =

> "
> MCC, Mobile country code (octet 2 and 3) =

> The MCC field is coded as in ITU-T Rec. E212, Annex A. =

> =

> MNC, Mobile network code (octet 3 bits 5 to 8, octet 4)  =

> The coding of this field is the responsibility of each administration but=
 BCD =

> coding shall be used. The MNC shall consist of 2 or 3 digits. For PCS 190=
0 for =

> NA, Federal regulation mandates that a 3-digit MNC shall be used. However=
 a =

> network operator may decide to use only two digits in the MNC in the LAI =
over =

> the radio interface. In this case, bits 5 to 8 of octet 3 shall be coded =
as =

> "1111". Mobile equipment shall accept LAI coded in such a way.
> "
> =

> >
> > That said, we do want some exposure of these values since it is an easy
> > way to determine geo location help and switch timezones etc. However I
> > am now thinking that me might just add a Country property and do the
> > proper translation inside oFono. Since we mostly care about these ones
> > most.
> >
> =

> About the only thing that MCC/MNC is useful for is to display it during m=
anual =

> operator selection.  MCC/MNC is not helpful at all for countries like U.S=
. =

> with 4+ timezones and the same carrier id across all of them.  A country =

> property would work just as well for this.  What standard do we want to u=
se =

> here? ITU 212? ISO 3166? or E164?
> =

> Any objections from actually removing the MCC/MNC Properties?

you know what. Lets remove them now. If we figure out on how to make
better use of them, we can add them later. Adding properties is way
simpler than deprecating/removing or changing them.

For the country, I would prefer simple alpha2 encoding. That way this
becomes similar to what WiFi uses for their regulatory enforcement.

Regards

Marcel



--===============6407681850748916888==--

