Content-Type: multipart/mixed; boundary="===============7138902725056920338=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RfC] Retry registering packet radio to home PLMN when available.
Date: Wed, 28 Oct 2009 08:30:34 +0100
Message-ID: <fb249edb0910280030w76287e59me10ddcde2ae8f8db@mail.gmail.com>
In-Reply-To: <200910261906.58614.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7138902725056920338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/10/27 Denis Kenzior <denkenz@gmail.com>:
>> Instead of setting DataConnectionManager.Powered to false after
>> failed attempts to register to home PLMN with packet radio when
>> RoamingAllowed is false, wait for the home PLMN to become available
>> retrying everytime the circuit switched radio manages to register
>> to home PLMN. =C2=A0The downside is if the circuit switched radio is off,
>> we wait indefinitely.
>
> So I decided to simplify things even further. =C2=A0Before we can attach =
we must be
> registered to the network (e.g. COPS issued), otherwise attach fails. =C2=
=A0Since
> we need netreg for this anyway, we might as well always rely on netreg's
> registration status to base our attach / detach decisions on.
>
> To me this seems to be the most sensible way to approach this. =C2=A0Howe=
ver, this
> assumes that the modem can't be registered on netreg and roaming on gprs.
>
> It also might break down in low-signal conditions where packet radio has
> signal but circuit-switched radio doesn't (which is interesting case where
> COPS reports an operator, CGREG shows registered, but CREG shows unregist=
ered)
>
> Comments?

One reason you might want to not register to network would be for power sav=
ing.

It seems like a small gain for adding this dependency (which will seem
especially strange to users not knowing about this quirk we're relying
on).  The current picture is that we want to have an indication of
when we might be able to register back to home PLMN with gprs.  We
keep the gprs radio disabled and enable the circuit-switched radio
possibly with the only aim being to have that (possibly weak)
indication.  Couldn't we instead use the gprs radio for the same
purpose?  We would simply prohibit activating contexts while roaming
and we would report Attached =3D false on D-Bus.

Regards

--===============7138902725056920338==--

