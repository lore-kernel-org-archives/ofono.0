Content-Type: multipart/mixed; boundary="===============1857599360426318556=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 23 Oct 2013 19:48:52 -0500
Message-ID: <52686E74.8010808@gmail.com>
In-Reply-To: <CACM4vuAb9G-SgSuRo-xf_DjuQ6bse5vxGYTQmXNZyAX+L+GbqQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1857599360426318556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

 > After thinking about different options, my proposition is:
>
> * Write a new plugin called mnclenght that will find the length of the
> MNC code based on the IMSI. It will use a DB of MCC/MNC
> correspondences and check some special cases for some operators (this
> is the approach taken in Android, btw).

Sounds good to me.

>
> * This plugin will be called by the sim core after reading the IMSI in
> case the MNC length has not been set before. If a valid MNC length is
> found, the MNC will be read from the IMSI and MobileNetworkCode
> property will be updated in dBus.
>

We shall have to see.  The only reason for exposing MCC/MNC to external =

applications is to streamline the manual user provisioning a bit.  E.g. =

if this information is provided, then some UI steps can be skipped by =

the user.  However, this information is optional.

> Would this approach be okay for going upstream?
>

In general I'd rather keep the information coming from plugins to the =

core to a minimum.  We shall decide this second point once I see the =

code.  The MCC->MNC length database would be useful regardless however, =

and can be used by the existing provisioning infrastructure.  So this =

part would definitely be welcome.

Regards,
-Denis

--===============1857599360426318556==--

