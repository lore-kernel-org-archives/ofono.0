Content-Type: multipart/mixed; boundary="===============0130707871002423713=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: oFono release plan?
Date: Thu, 23 Dec 2010 12:56:36 +0200
Message-ID: <1293101796.3120.1547.camel@tucson>
In-Reply-To: <AANLkTimrHDROFp-0yhNDRurF8AO+sn9DYOoVGbYLaAz3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0130707871002423713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

On Thu, 2010-12-23 at 15:16 +0530, ext Sankar wrote:

> Can you please add more light on what all is planned under the CDMA
> support.

See under doc the cdma-* files. However, these are proposals still, and
code is just being submitted for implementing these. That is not yet 1.0
material, IMHO.
 =

>         - the SMS (history) agent API
>         - SIM authentication API (EAP-SIM, EAP-AKA, IMS and GBA)
> Can you please add more light on what is supported. I could not find
> this info in the todo list. =


In short, we need to expose certain security services offered by the SIM
card that utilize the crypto algorithms on the card. This is used for
instance in voice over LTE authentication procedures. Probably needs to
be added to the TODO.

Cheers,
Aki



--===============0130707871002423713==--

