Content-Type: multipart/mixed; boundary="===============4061326324176873359=="
MIME-Version: 1.0
From: Mylene Josserand <mylene.josserand@openwide.fr>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Fri, 05 Dec 2014 14:34:06 +0100
Message-ID: <471639151.28894314.1417786446200.JavaMail.root@openwide.fr>
In-Reply-To: <1677713536.28890660.1417783089563.JavaMail.root@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4061326324176873359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> =

> I am going to read/add debug in connman's code (plugin/ofono.c), I
> will post again if I find something.


I found something _very_ useful : https://github.com/aldebaran/connman/blob=
/master/plugins/ofono.c#L1074

Connman supports only one Internet context per modem that is why my 2nd con=
text did not work.

I will search how to handle that (and, maybe, ask some help to connman mail=
 list).



Best regards,

Myl=C3=A8ne

--===============4061326324176873359==--

