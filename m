Content-Type: multipart/mixed; boundary="===============7086038598022680664=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Mon, 29 Mar 2010 13:53:42 -0500
Message-ID: <201003291353.43404.denkenz@gmail.com>
In-Reply-To: <80fd4e751003291129n5baa0b5bhf16e404e95491d1c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7086038598022680664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> However, then powering modem down, there are problems. The N900 modem
> control needs to make difference between the state where the modem is
> no more useful and the safe-to-exit state when the power off request
> has been completed, modem has flushed its state to flash and given
> some time to safely turn off the SIM card.

So if I understand correctly, you are saying that once the powered=3Doff re=
quest =

has been sent down to the modem, no other requests are valid.  In other wor=
ds, =

oFono's current implementation does not remove the atoms until powered=3Dof=
f =

request succeeds (which might result in those atoms attempting operations), =

which is wrong.

Right?

> =

> Also, if an another SetProperty("Powered") call is made while the
> driver is powering the modem on or off, the change is ignored. It
> seems to me that we need more fine grained power control than just the
> current boolean in the core, too.

We reply with the busy error, you're correct.  However, I don't really see =

anything better we can do here, do you have any suggestions?

Regards,
-Denis

--===============7086038598022680664==--

