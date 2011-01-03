Content-Type: multipart/mixed; boundary="===============6119770257486305496=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 12:34:55 -0800
Message-ID: <1294086895.5852.15.camel@aeonflux>
In-Reply-To: <1294061902.2077.51.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6119770257486305496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > > Well, my intention was to make format simple and fast to parse, but
> > > still be extensible enough, which I think my proposed format fulfills=
. =

> > >
> > > These <access>-elements contain just data needed for GPRS context
> > > settings (as attributes), and if there is need for any other operator
> > > specific provisioning information, you can always add separate elemen=
ts,
> > > this is still proper XML.
> > =

> > But IMHO it is really ugly and not a properly designed XML.
> =

> Well, to me it looks simple, compact and clean, and most certainly
> provides all necessary extensibility any XML format provides.  =

> =

> > Again, why not use mobile-broadband-provider-info DTD? If there's somet=
hing
> > missing, I'm sure maintainers are willing to extend it. No need to
> > reinvent the wheel.
> =

> In this format biggest thing that I see missing is type of access point
> ("internet","mms","lte"), protocol (for IPv6) and mms-server (or
> "homepage"). And I assume <name> of <provider> could be interpreted as
> SPN for provisioning.
> =

> The good point of using mobile-broadband-provider-info is that it would
> indeed provide existing database for testing purposes. For product
> creation, manufacturers will anyway create their own databases, and
> there the format does not matter much.

I think we need something in between both formats.

The mobile-broadband-provider-info is too much and too complex from my
point of view. It contains too much details that are not really helping
us if you wanna do provisioning. We need to automate this and can not
really ask the user.

On the other hand, I would prefer a little bit more XML style nesting or
we just use key files right away.

Regards

Marcel



--===============6119770257486305496==--

