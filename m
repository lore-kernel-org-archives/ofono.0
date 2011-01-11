Content-Type: multipart/mixed; boundary="===============5544006031619962340=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 10 Jan 2011 16:59:38 -0800
Message-ID: <1294707578.3873.18.camel@aeonflux>
In-Reply-To: <87fwt9ng37.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5544006031619962340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> >> For me the best would be to have all plugins in ofono tree and
> >> enable/disable them with configure switches.
> >
> > I wanna use priorities and smart detection to use them. Nothing for the
> > user to configure. Just installing some extra packages should active its
> > usage. And yes, I want to make it possible to build all plugins at all
> > time.
> =

> Even better, maybe just a bit trickier to implement. But at least
> mobile-broadband-provider-info already supports pkgconfig so the
> location of the xml should be easy to detect automatically during
> configure.

so I assume you take yo the task to add support for it once we have the
rest of framework merged.

Regards

Marcel



--===============5544006031619962340==--

