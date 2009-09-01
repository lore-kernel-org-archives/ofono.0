Content-Type: multipart/mixed; boundary="===============8028729478586692288=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Tue, 01 Sep 2009 23:26:01 +0300
Message-ID: <200909012326.01493.remi@remlab.net>
In-Reply-To: <4A9D8160.6000404@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8028729478586692288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mardi 1 septembre 2009 23:17:36 Jean-Christian de Rivaz, vous avez =C3=
=A9crit :
> Thanks for the explanation. I will start learning how phonet works. But
> I expect there exists a PPP stack somewhere in phonet because the modem
> I use don't have one.

ISI modems have a PPP "server-side" implementation to handle USB CDC ACM an=
d =

BlueTooth DUN. But there is only one instance per modem, so we reserve it f=
or =

the dumb Windows PC that we may be connected to ;)

> And I don't think it's possible to have a IP link
> over GPRS without the PPP protocol between them.

It might be possible in the standard, but I have not found any network =

offering such a PP over GPRS data service.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============8028729478586692288==--

