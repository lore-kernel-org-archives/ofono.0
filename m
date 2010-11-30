Content-Type: multipart/mixed; boundary="===============8458093208369320741=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Tue, 30 Nov 2010 11:58:03 +0100
Message-ID: <1291114683.4795.33.camel@aeonflux>
In-Reply-To: <1291105215.14343.14.camel@Nokia-N900-51-1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8458093208369320741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

do me a favor and try not to break the threading next time.

> > > * At Nokia, we also have some non-standard commands for internal use.
> > > * Some operators require some funky AT commands of their own. It might
> > not be
> > > possible to open-source them, even if we want to.
> >
> > And these should be on an engineering mode only USB CDC ACM interface
> > with a different backend anyway.
> =

> I already mentioned that the same software must run in certification and =
in user's hands for "whole device" certification to be valid. But anyway, s=
ome of those commands were requested as DUN extensions, not as testing stuf=
f. So no no no.

I am getting a bit sick of this secrecy. oFono is for all intense and
purposes open source. So if you want a proper discussion here then
please list the AT command in question.

Since you are clearly working on this right now, please compile a list
of required AT commands and share it. A good place to list the required
commands for "whole device" certification would be the doc/ directory.

Regards

Marcel



--===============8458093208369320741==--

