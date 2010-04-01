Content-Type: multipart/mixed; boundary="===============3534571422512541995=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Thu, 01 Apr 2010 15:44:02 +0300
Message-ID: <1270125842.2432.273.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <k2m80fd4e751004010214r8f0ca85dx3675b4a02eacf505@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3534571422512541995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

to, 2010-04-01 kello 11:14 +0200, ext Pekka Pessi kirjoitti:
> It seems to me that Marcel and Aki want to control TX power with the
> Powered property. (BTW, there already is a post-sim mechanism to
> control the RX/TX, namely Register/Deregister.)

But then Register()'s meaning is overloaded to mean both RF on *and*
(automatically) register. This doesn't work in the manual registration
case, where after landing on the other side of the Atlantic, you first
need to turn RF on, then select a roaming partner from a list.

In fact, Deregister() is currently not all that useful, and not even
implemented in isimodem. I think it should simply be removed.

> What we miss from the core is a way to do asynchronous cleanup
> (separate from Powered). A shutdown() method in modem driver and
> corresponding callback, like ofono_modem_shutdown_ready(). This way we
> can do what ever N900 requires us to do and there is no need to touch
> other drivers.

That sounds reasonable to me.

Cheers,
Aki	=





--===============3534571422512541995==--

