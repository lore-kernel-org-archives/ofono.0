Content-Type: multipart/mixed; boundary="===============3720520640477475431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 17:57:55 -0500
Message-ID: <554161F3.40104@gmail.com>
In-Reply-To: <55413AFD.40703@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3720520640477475431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 >
> It looks as though the issue is that the Cinterion parts don't support
> signal strength via +CIND ?

Yes, we look for "signal" indicator inside cind_support_cb.  If it isn't =

found, then we raise an error.  This tells the hw integrator to address =

the issue.  CIND logic is provided as a fallback / default since many =

manufacturers support this indicator for HFP.

>
> Yet in at_signal_strength() it looks to me as though if this is the case
> the code will fall back happily to using +CSQ

signal_strength (and hence +CSQ) is used to bootstrap the signal =

strength value.  This driver method is only called at very specific =

times.  The core does not poll signal_strength.  It is expected that the =

driver will send signal strength value to the core periodically, by =

whatever means is optimal for the hardware.  Most modems use a custom =

unsolicited notification or CIND to provide information about signal =

strength automatically.  I suspect Cinterion has a similar extension.

>
> That being the case I'm not sure why cind_support_cb() should be
> reporting an error and removing the device when it should be able to
> fallback and continue?

The consequence of the above is that it can't.  If no vendor extension =

is available for unsolicited notifications and signal strength is not =

provided via CIND, then the netreg atom driver can either poll signal =

strength manually or simply not provide any signal strength updates. =

For the latter, it must enable such behavior explicitly.  Hence why your =

patch providing OFONO_VENDOR_CINTERION logic makes this work properly.

Hope that made sense.

Regards,
-Denis

--===============3720520640477475431==--

