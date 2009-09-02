Content-Type: multipart/mixed; boundary="===============4437996157906260148=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 02:16:40 -0700
Message-ID: <1251883000.1266.56.camel@localhost.localdomain>
In-Reply-To: <8ecd5e23a3430057ddafaddb86c1def2@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4437996157906260148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Our current assumption is that the basic setup of IP address, netmask
> > and broadcast are done by oFono. Only routing and DNS are up to other
> > programs like ConnMan for example.
> =

> WHAAAAAAAAAAT? No way. There is just no way.
> =

> We need to support letting the calling program configure the routing
> parameters manually. For instance, if we want to connect to multiple
> primary access points, it simply won't work if Ofono configures everythin=
g.
> Instead, we need to either setup source routing or separate network
> name-spaces. Ofono does not know what the caller intends to do with the A=
PN
> (and should not need to), so it cannot configure IP parameters. Besides, =
it
> makes very little if any sense to configure IP parameters but not DNS.

personally I don't care who finally sets the IP for the interface. It
really just makes no difference. What problem do you see if oFono would
set the IP address on that newly created interface that is up and
running now?

My point is that gateway and DNS is out of the question for oFono.

Regards

Marcel



--===============4437996157906260148==--

