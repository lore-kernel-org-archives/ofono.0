Content-Type: multipart/mixed; boundary="===============3900939500757978284=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 13:43:50 +0300
Message-ID: <a32762a20909020343x2c90cdeege6185b6dd5c5b1b3@mail.gmail.com>
In-Reply-To: <6e52e431bc7dff6c694e46be9f79b86b@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3900939500757978284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/9/2 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
>> personally I don't care who finally sets the IP for the interface. It
>> really just makes no difference. What problem do you see if oFono would
>> set the IP address on that newly created interface that is up and
>> running now?
>
> Then the application cannot influence the way it's done. That's the whole
> point. Maybe I want to migrate the interface in a new namespace. For that,
> it must (1) create the interface, (2) migrate it, (3) configure it, in th=
at
> order. So Ofono cannot do (3) if it cannot do (2), and it certainly should
> not do (2) by itself. So it has to stick to (1).

And this generally applies to services that operators have decided to
run behind a dedicated APN, such as WAP, MMS, Push over Cellular (PoC)
and others. For example, Elisa in Finland seems to be running their
MMSC behind an "mms" APN, with public IP address space, but firewalled
from the rest of the Internet. oFono should isolate such an access
from the rest of the system, since only the MMS client would know how
to work with it properly.

Cheers,
Aki

--===============3900939500757978284==--

