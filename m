Content-Type: multipart/mixed; boundary="===============5783175940231592389=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 12:31:16 -0800
Message-ID: <1294086676.5852.11.camel@aeonflux>
In-Reply-To: <1294054101.3120.1577.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5783175940231592389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Any particular reason why you can't use the
> > same format as in mobile-broadband-provider-info?
> =

> I think reusing the format here makes sense, actually. If not for
> anything else than to be able to use an existing database for testing.

my thinking was that we should read the MBPI database if present and use
it as much as possible. Since oFono will not ship a database by default
anyway.

However we do need an extensible way of per-operator overrides at least.
And while MBPI database might work on the desktop, I think it will fail
on a mobile phone. The information in it are too desktop centric.

I also have a small problem on how it tries to solve the problem of
virtual providers and/or different contract details. This part of the
database if more designed for UI usage than for system usage.

Regards

Marcel



--===============5783175940231592389==--

