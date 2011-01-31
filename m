Content-Type: multipart/mixed; boundary="===============8968709592236795124=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] plugins:ste:preparation for hotswap
Date: Mon, 31 Jan 2011 10:52:18 +0100
Message-ID: <1296467538.1520.194.camel@aeonflux>
In-Reply-To: <1296463547.2044.7.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8968709592236795124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> > I am a bit lost in how you fit this into the existing SIM pin check.
> > Maybe it would be cleaner to remove that check first. And then add a
> > patch for the SIM notification handling.
> =

> I don't understand this comment. Patch in original mail shows how it
> fits to simpin_check. ( Line 91 ). =


is the simpin_check still needed after your patch?

> > Also this seems pretty much similar to what IFX does. Can we make sure
> > that it is handled similar as well?
> =

> I can't. I don't have such modem. =


You have the source code in plugins/ifx.c to look at how we did it
there.

Regards

Marcel



--===============8968709592236795124==--

