Content-Type: multipart/mixed; boundary="===============2789129760726826059=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gemaltomodem: added Gemalto-specific gprs-context
 atom....
Date: Mon, 24 Sep 2018 15:50:18 -0500
Message-ID: <e7b07f59-78a2-0d26-1007-7be05d1d1f6f@gmail.com>
In-Reply-To: <CAKSBH7GCFk-ZoG9KB-YOOtUV4Xy_m24Syx-B1vOGXo8P_71xog@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2789129760726826059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>     So until the GPRS_AUTH_METHOD_NONE is actually introduced, you might
>     want to just get this upstream with the existing enumeration.=C2=A0 E=
.g.
>     just
>     assume that if username & password is empty, the auth method is none.
> =

> =

> I have pushed the new method NONE again, and I prefer to wait until it =

> is taken.
> =

> The current solution is really a non-documented hack.
> Checking whether user&password are empty to change the type of =

> authentication goes against the=C2=A0caller settings.
> It is better to give an error so that there is a chance to have good =

> settings.
> =


The issue is that you haven't properly addressed all the points that =

arise from adding a new enumeration.  You're touching something that =

essentially affects every driver and not updating these properly.  So =

take your pick, but nothing is going upstream until either this patch =

fits into the old framework, or the new framework is ready...

>     Fundamentally, your context activation has succeeded or it didn't.=C2=
=A0 The
>     DHCP operation is purely local between the modem and the host.=C2=A0 =
No
>     other
>     vendor in the world has this weird setup that you do.=C2=A0 So I don't
>     really
>     know what to tell you here as this ^SWWAN interaction is fundamentally
>     broken and it can't go upstream in this form.
> =

>     Can ^SWWAN support static ip reporting instead of DHCP?=C2=A0 That wo=
uld be
>     preferred anyway as DHCP is slow and unneeded.
> =

> =

> This is a discussion about how Gemalto products work.
> =

> Admittedly, there are a few models, in the high-volume low-price range =

> (already deployed),
> that won't return from AT^SWWAN until a DHCP exchange is performed, as =

> per Sebastian's comment above.
> =


Can firmware be fixed / upgraded on these?

> The rest (which are the large majority) of the modules would allow a =

> 'standard' treatment, but also work with the code above.

So why don't we enable sane ones for now and deal with the insane ones =

later?

> =

> As per DHCP vs static, we have both, depending on the module.
> =

> Just for information, I have stepped upon networks *requiring* DHCP:
> in this kind of networks, an MBIM module that would normally return a =

> static settings,
> returns 0x00 in the "IPv4 configuration Available" field in of the =

> IP_CONFIGURATION answer,
> instead of the usual 0x0F (address, gateway, dns, mtu).
> So, it looks like that DHCP has to be considered as a valid alternative =

> also in this case.

This is fine.  You just set the IP configuration method accordingly.  We =

already have a few examples where the gprs_context driver might choose =

one or the other depending on whether support for a given command =

exists.  This can be extended to support cases where the network =

requires DHCP.  Which by the way is completely weird for cases such as =

PPP where no concept of DHCP really exists and your address has to be =

obtained by the time the context is activated.  So I wouldn't mind some =

extra details on what is *actually* going on here under the hood.

> =

> We cannot change every module and every network to fit our wishes.
> =

> Back to the code, I don't see a solution at the moment other than that on=
e.
> I can add an 'if' to filter only the models that need it, but cannot =

> remove it completely.
> And this code would be specific for the driver, I don't see why it =

> couldn't go upstream.

So I would filter these models out from this driver.  Or see if they can =

work with PPP based driver and we can deal with these later.

Regards,
-Denis

--===============2789129760726826059==--

