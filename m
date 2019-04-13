Content-Type: multipart/mixed; boundary="===============3056975868840973368=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Ofono for ublox LARA-R211
Date: Sat, 13 Apr 2019 07:18:08 +0200
Message-ID: <b1704e97-d41f-0538-4d9b-7764fc7eb3d1@norrbonn.se>
In-Reply-To: <00bd01d4f05c$69debed0$3d9c3c70$@iwavesystems.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3056975868840973368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On 11/04/2019 13:47, Krishna wrote:
> Hi All,
> =

> Whether anyone tried ofono framework with u-blox LARA-R211 or LARA-202?

ofono currently does not support these modems, but looking quickly at =

the documentation I don't see any difficulty at all in getting this to =

work.  You just need to add the USB model ID ('110a') to =

plugins/udevng.c and the modem identifiers to plugins/ublox.c (the model =

ID strings).

/Jonas

> =

> Regards,
> =

> Krishna
> =

> *From:*Krishna [mailto:krishnaks(a)iwavesystems.com]
> *Sent:* Friday, March 22, 2019 08:09 PM
> *To:* 'ofono(a)ofono.org' <ofono@ofono.org>
> *Subject:* Ofono for ublox LARA-R211
> =

> Hi All,
> =

> Whether I can use ofono for LARA-R211 or LARA-202?
> =

> I have added ofono package to the yocto and enabled required =

> configurations in Linux kernel.
> =

> I have referred below link for the configuration.
> =

> https://embexus.com/2017/06/04/add-a-mobile-broadband-connectivity-to-emb=
edded-linux/
> =

> However ./list-modem is not returning anything.
> =

> Let me know if I am missing any configuration.
> =

> Regards,
> =

> Krishna
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============3056975868840973368==--

