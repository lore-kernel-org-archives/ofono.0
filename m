Content-Type: multipart/mixed; boundary="===============5407500658909529683=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RAT , signal Strength indication ofono 0.23
Date: Tue, 17 Aug 2010 11:13:54 -0500
Message-ID: <4C6AB542.3060106@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D401870321E1DD5@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5407500658909529683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alain,

On 08/17/2010 11:05 AM, Kouassu, AlainX wrote:
> All,
> =

>  =

> =

> Is the =E2=80=9CStrength=E2=80=9D property and the =E2=80=9CTechnology=E2=
=80=9D fully implemented in
> org.ofono.NetworkRegistration  on Ofono 0.23 ?
> =

> Is org.ofono.NetworkRegistration is  fully integrated on Ofono 0.23 ?
> =

>  =


If the modem driver provides it, then sure.  Please do keep in mind that
oFono 0.23 is pretty ancient now, our development moves pretty quickly.

> =

> I am testing Ofono 0.23 on top of Medfield platform with a Agilent 8960
> (Network simulator)
> =

> I have noticed  that at ofono level  RAT indication and signal strength
> are not updated when the RAT change or when the signal level change.
> =

>  =


What modem are you using?  Is the driver for this modem upstream?

Regards,
-Denis

--===============5407500658909529683==--

