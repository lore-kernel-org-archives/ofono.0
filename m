Content-Type: multipart/mixed; boundary="===============3251912853542978613=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/3] doc: addidng documentation for basic assisted gps
Date: Fri, 05 Nov 2010 21:21:23 +0100
Message-ID: <AANLkTi=eOBp64sTe0en_0G2VXGQ9mFppFd54W1KiY6oe@mail.gmail.com>
In-Reply-To: <1288986432.9615.132.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3251912853542978613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
>> So in general I'm currently against introducing this API as oFono
>> official API. =C2=A0I suggest prefixing this with an IFX specific identi=
fier.
>> =C2=A0Maybe modem.ifx.AgpsManager.
>
> I would actually go one step further and call this com.infineon.Agps or
> something like that.
>
> As I stated this many times, before we make this a generic oFono API, we
> need at least three types of modems that support this kind of feature
> and find the common API.
>
> For me this is clearly IFX and ISI right now. And it looks to me that
> Sjur has also shown interested, so the third one might be STE/MBM.

Yes, I can confirm that we are looking into this and are planning to
support AGPS for
oFono. Would you be interested if we proposed an API whith transparent tran=
sport
of the XML specified by 3GPP? Such an API should be possible to
implement with the
3GPP standardized AGPS commands, so that a generic driver could be implemen=
ted
(atmodem/agps.c).

Regards,
Sjur

--===============3251912853542978613==--

