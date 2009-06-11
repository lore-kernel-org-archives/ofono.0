Content-Type: multipart/mixed; boundary="===============4113969489598753773=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 09:32:38 -0500
Message-ID: <200906110932.39143.denkenz@gmail.com>
In-Reply-To: <1244720815.27363.10.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4113969489598753773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I wasn't aware of this and so it might be better to just expose these as
> an operator id string. So we might not even split into MCC/MNC at all
> since it is meaning less anyway.

I'm tending to agree, which is why I wanted to start the conversation.  =


By the way, just so that we're all clear, here's the relevant quote from th=
e =

standard:

"
MCC, Mobile country code (octet 2 and 3) =

The MCC field is coded as in ITU-T Rec. E212, Annex A. =


MNC, Mobile network code (octet 3 bits 5 to 8, octet 4)  =

The coding of this field is the responsibility of each administration but B=
CD =

coding shall be used. The MNC shall consist of 2 or 3 digits. For PCS 1900 =
for =

NA, Federal regulation mandates that a 3-digit MNC shall be used. However a =

network operator may decide to use only two digits in the MNC in the LAI ov=
er =

the radio interface. In this case, bits 5 to 8 of octet 3 shall be coded as =

"1111". Mobile equipment shall accept LAI coded in such a way.
"

>
> That said, we do want some exposure of these values since it is an easy
> way to determine geo location help and switch timezones etc. However I
> am now thinking that me might just add a Country property and do the
> proper translation inside oFono. Since we mostly care about these ones
> most.
>

About the only thing that MCC/MNC is useful for is to display it during man=
ual =

operator selection.  MCC/MNC is not helpful at all for countries like U.S. =

with 4+ timezones and the same carrier id across all of them.  A country =

property would work just as well for this.  What standard do we want to use =

here? ITU 212? ISO 3166? or E164?

Any objections from actually removing the MCC/MNC Properties?

Regards,
-Denis

--===============4113969489598753773==--

