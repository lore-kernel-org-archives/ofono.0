Content-Type: multipart/mixed; boundary="===============8035153617600675229=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Thu, 01 Apr 2010 10:09:28 -0500
Message-ID: <201004011009.28487.denkenz@gmail.com>
In-Reply-To: <1270125842.2432.273.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8035153617600675229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> to, 2010-04-01 kello 11:14 +0200, ext Pekka Pessi kirjoitti:
> > It seems to me that Marcel and Aki want to control TX power with the
> > Powered property. (BTW, there already is a post-sim mechanism to
> > control the RX/TX, namely Register/Deregister.)
> =

> But then Register()'s meaning is overloaded to mean both RF on *and*
> (automatically) register. This doesn't work in the manual registration
> case, where after landing on the other side of the Atlantic, you first
> need to turn RF on, then select a roaming partner from a list.

I agree, Register is not the right one here.

> =

> In fact, Deregister() is currently not all that useful, and not even
> implemented in isimodem. I think it should simply be removed.

I'm actually fine removing it since most modems end up not supporting this =

either.

Regards,
-Denis

--===============8035153617600675229==--

