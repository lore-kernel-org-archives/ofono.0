Content-Type: multipart/mixed; boundary="===============7647766556314716431=="
MIME-Version: 1.0
From: Mylene Josserand <mylene.josserand@openwide.fr>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Thu, 04 Dec 2014 17:26:23 +0100
Message-ID: <296413424.28859588.1417710383928.JavaMail.root@openwide.fr>
In-Reply-To: <392376778.28854113.1417707247777.JavaMail.root@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7647766556314716431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,


> =

> I have tried it but, with the dbus method GetContext, only one
> context is shown (the QMI ones).
> The "at_gprs_context_probe" is called but failed at
> "g_at_chat_get_slave".
> I checked the gcd->chat and it is not NULL so it seems to come to the
> slave.
> =

> What is it for ? What have I missed ?
> =


I continued to look around and I succeed to make it work !

I looked to other modem plugins. I think I understand what the slave is tha=
nks to that. It is the other interfaces to send AT commands, only, whereas =
the "main" GAtChat serves to create the PPP connection, is not it ? If I am=
 wrong, do not hesitate to make me understand how it works.

I set the slave (via "g_at_chat_set_slave") to my "Application" device and =
I succeeded to get 2 contexts. I activate them and it creates the PPP and Q=
MI connections ! I still have a problem : I did not get an IP address on on=
e of the APN connection but this is another problem (connman ?) and I will =
search alone for that before asking for help :)


Anyway, thank you for the help you gave me !


Best regards,

Myl=C3=A8ne

--===============7647766556314716431==--

