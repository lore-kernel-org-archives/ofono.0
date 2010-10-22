Content-Type: multipart/mixed; boundary="===============2051645910526493438=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: Re: [PATCH] common : bring back some details about technology
Date: Fri, 22 Oct 2010 16:01:08 +0200
Message-ID: <20101022142530.178840@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2051645910526493438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> De : Aki Niemi
> =

> Hi,
> =

> 2010/10/21 "Beno=C3=AEt Monin" <benoit.monin@gmx.fr>:
> > diff --git a/src/common.c b/src/common.c
> > index b5b9a6f..d571d81 100644
> > --- a/src/common.c
> > +++ b/src/common.c
> > @@ -655,15 +655,15 @@ const char *registration_tech_to_string(int tech)
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM:
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "gs=
m";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_COMPACT:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gsm";
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gprs";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN:
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "um=
ts";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_EGPRS:
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "ed=
ge";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsdpa";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsupa";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSU=
PA:
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "hs=
pa";
> > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_EUTRAN:
> =

> Do you need to know if the cell supports high speed uplink, downlink
> or both; or in fact, when uplink or downlink is active (i.e., channel
> allocated)? Currently the API is telling you the former, and
> supporting the latter would require changes not only in the D-Bus API,
> but also in the driver API.
> =

The API is fine as-is, we just need a bit more details about the
technology in use. It will be purely informative in our application
anyway.

> As a side note, I think I was originally proposing using the
> generation tags, but either way works for me. That is, I consider it
> 3.5G when at least HSDPA is available.
> =

I was just thinking out loud about a "generation" field, I don't have
any need for it. And it can be obtained from the technology (correct
me if I'm wrong) :

gsm -> 2G
gprs, edge -> 2.5G
umts -> 3G
hsdpa, hsupa, hspa -> 3.5G
lte -> 4G

--
Beno=C3=AEt.

--===============2051645910526493438==--

