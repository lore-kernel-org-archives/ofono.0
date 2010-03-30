Content-Type: multipart/mixed; boundary="===============0969728309341845459=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 07:19:49 -0700
Message-ID: <1269958789.11714.249.camel@localhost.localdomain>
In-Reply-To: <1269950249.2432.3.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0969728309341845459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Another solution is to use sscd-like daemon also with ofono (the oFono
> > Powered property would then just follow the power state of the modem).
> =

> My preference would be to have these things handled as oFono plugins.
> That being the recommended way of course doesn't preclude some other
> modem needing a slave plugin that monitors the accomplishments of a
> separate daemon.

why do we need this at all? Can't your kernel driver take care of this?
And obvious second question is why your kernel driver is not integrated
with the RFKILL subsystem?

Regards

Marcel



--===============0969728309341845459==--

