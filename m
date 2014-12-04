Content-Type: multipart/mixed; boundary="===============4452597678131453254=="
MIME-Version: 1.0
From: Mylene Josserand <mylene.josserand@openwide.fr>
Subject: Re: [help] connect 2 APN at the same time (PPP and QMI)
Date: Thu, 04 Dec 2014 16:34:07 +0100
Message-ID: <392376778.28854113.1417707247777.JavaMail.root@openwide.fr>
In-Reply-To: <547FA131.9000001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4452597678131453254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


Thank you for your help. I really appreciate.


> This sort of depends on whether your hardware actually supports
> multiple
> contexts being activated at once.


For this, it is okay. My hardware can have 3 contexts activated at the same=
 time.



> You could try modifying the gobi plugin and udevng to allocate 2
> gprs-contexts.  One using the QMI driver and the other using PPP.
> =

> e.g. something like:
> =

> gc =3D ofono_gprs_context_create(modem, 0, "qmimodem", device);
> ofono_gprs_add_context(gprs, gc);
> =

> gc =3D ofono_gprs_context_create(modem, 0, "atmodem", ppp_chat);
> ofono_gprs_add_context(gprs, gc);
> =

> and see if that works.
 =


I have tried it but, with the dbus method GetContext, only one context is s=
hown (the QMI ones). =

The "at_gprs_context_probe" is called but failed at "g_at_chat_get_slave". =

I checked the gcd->chat and it is not NULL so it seems to come to the slave=
. =


What is it for ? What have I missed ?


Thank you in advance,

Best regards,


Myl=C3=A8ne


--===============4452597678131453254==--

