Content-Type: multipart/mixed; boundary="===============6979486453345703452=="
MIME-Version: 1.0
From: Bernhard Guillon <Bernhard.Guillon@hale.at>
Subject: Re: [PATCH] network-registration.c: enhance CIND=? support
Date: Tue, 07 Jun 2011 14:12:06 +0200
Message-ID: <alpine.DEB.2.00.1106071409280.4297@entw48>
In-Reply-To: <1307448289-4413-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6979486453345703452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On Tue, 7 Jun 2011, Bernhard.Guillon(a)hale.at wrote:

> From: Bernhard Guillon <Bernhard.Guillon@hale.at>
>
> *add support for CIND=3D? tokens like ("signal",(0-7,99))
> *add support for token encapsulation e.g.
>    (("one",(0-7,99)),("two",(0-7,99)))
> ---
> drivers/atmodem/network-registration.c |   51 +++++++++++++++++++++++++++=
+---
> 1 files changed, 46 insertions(+), 5 deletions(-)


Tested with:

Telit:
AT+CIND=3D?
+CIND: (("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounde=
r",(0,1)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0,1))=
,("rssi",(0-5,99)))

and some kind of Motorola from wikipedia [1]:

+CIND: ("Voice Mail",(0,1)),("service",(0,1)),("call",(0,1)),("Roam",(0-2))=
,("signal",(0-5)),("callsetup",(0-3)),("smsfull",(0,1))

Best regards,
Bernhard

1 http://en.wikipedia.org/wiki/Motorola_phone_AT_commands


--
Scanned by MailScanner.


--===============6979486453345703452==--

