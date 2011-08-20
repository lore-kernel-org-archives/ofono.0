Content-Type: multipart/mixed; boundary="===============0993838913792471712=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [Clarification Request]HFP Modem:Notification of Multiparty Call
 Created Using AG
Date: Sat, 20 Aug 2011 00:39:47 -0500
Message-ID: <4E4F48A3.2030101@gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836215186E43FF@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0993838913792471712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On 08/22/2011 12:34 AM, milan.satpathy(a)accenture.com wrote:
> Hi,
> =

>  =

> =

> The following issue is being faced while establishing a multiparty call
> using AG directly.
> =

>  =

> =

> Precondition:
> =

> -------------------
> =

>    1. No SLC is established between AG & HF.
>    2. A multiparty call is established using the available features in
>       AG directly.
> =

>  =

> =

> Test Steps:
> =

> ----------------
> =

>       1. SLC is established while the conference call is in progress.
> =

>       2. The participant calls are still presented as =E2=80=9Cmultiparty=
 =3D false=E2=80=9D.
> =

>  =

> =

> Primary Analysis:
> =

> ------------------------
> =

> From primary code walk through it looks like, the multiparty property is
> set possibly as a result of callback to =E2=80=9Ccreatemultiparty=E2=80=
=9D call, made
> using Ofono.
> =

>  =

> =

> Query:
> =

> ---------
> =

> Is there a specific reason to limit the availability of multiparty call
> support initiated through Ofono only?
> =


This is an oversight for HFP.  oFono primarily deals with 'real' modems
and the implicit assumption is that no calls can exist since oFono is
responsible for powering up the modem.

We would need to introduce a new list_calls method to the voicecall
driver and execute it at atom initialization time.  We can then file
multiple held / active calls into the multiparty list.  Patches are
always welcome ;)

Regards,
-Denis

--===============0993838913792471712==--

