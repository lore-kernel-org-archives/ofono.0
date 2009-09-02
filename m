Content-Type: multipart/mixed; boundary="===============6048695390119092210=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 08:39:31 +0200
Message-ID: <8ecd5e23a3430057ddafaddb86c1def2@chewa.net>
In-Reply-To: <1251844960.1266.53.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6048695390119092210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 01 Sep 2009 15:42:40 -0700, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Our current assumption is that the basic setup of IP address, netmask
> and broadcast are done by oFono. Only routing and DNS are up to other
> programs like ConnMan for example.

WHAAAAAAAAAAT? No way. There is just no way.

We need to support letting the calling program configure the routing
parameters manually. For instance, if we want to connect to multiple
primary access points, it simply won't work if Ofono configures everything.
Instead, we need to either setup source routing or separate network
name-spaces. Ofono does not know what the caller intends to do with the APN
(and should not need to), so it cannot configure IP parameters. Besides, it
makes very little if any sense to configure IP parameters but not DNS.

-- =

R=C3=A9mi Denis-Courmont


--===============6048695390119092210==--

