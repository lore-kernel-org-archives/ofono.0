Content-Type: multipart/mixed; boundary="===============4618590491329295173=="
MIME-Version: 1.0
From: Kouassu, AlainX <alainx.kouassu@intel.com>
Subject: RE: RAT , signal Strength indication ofono 0.23
Date: Wed, 18 Aug 2010 09:09:42 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D401870321E1E0E@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4C6AB542.3060106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4618590491329295173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Denis,

In fact the property like CellId or LocationAreaCode are sometimes updated =
but the property Technology (RAT) is never indicated, in the other hand the=
 property Strength is not updated when the signal strength of the cell chan=
ge. Is sound like networkregistration API is not fully working or implement=
ed ?

Thanks,
Alain Kouassu

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Tuesday, August 17, 2010 6:14 PM
To: ofono(a)ofono.org
Cc: Kouassu, AlainX
Subject: Re: RAT , signal Strength indication ofono 0.23

Hi Alain,

On 08/17/2010 11:05 AM, Kouassu, AlainX wrote:
> All,
> =

>  =

> =

> Is the "Strength" property and the "Technology" fully implemented in
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
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4618590491329295173==--

