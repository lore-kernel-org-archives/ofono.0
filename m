Content-Type: multipart/mixed; boundary="===============1743568102609427820=="
MIME-Version: 1.0
From: Mylene Josserand <mylene.josserand@openwide.fr>
Subject: [help] connect 2 APN at the same time (PPP and QMI)
Date: Wed, 03 Dec 2014 11:14:26 +0100
Message-ID: <556279298.28727836.1417601666074.JavaMail.root@openwide.fr>
In-Reply-To: <1862208886.28721645.1417597240490.JavaMail.root@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1743568102609427820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,


I am new to Ofono and I need some advices.

My modem has two interfaces : one interface on which I can do a PPP connect=
ion and another interface QMI to make wwan connection.
My SIM card has 2 APNs and I must connect to them simultaneously. So, I nee=
d to be connected in PPP with APN1 and in qmi/wwan with APN2.

The two ways of being connected work. I have successfully configured "2 ofo=
nos" to make my modem works with "atmodem" for the PPP side and, by setting=
 ofono driver to gobi in udevng (such as Huawei does) for wwan side. To sum=
 up, Ofono works with PPP or with QMI. Now, I need to make it work with PPP=
 _and_ QMI at the same time.

I tried to connect, on the same modem, in my plugin file, the interface "De=
vice" to "qmimodem" driver (so what "gobi" plugin does) and the "Applicatio=
n" and "Modem" interfaces to "atmodem" driver but it failed because dbus in=
terfaces already exist (created by the first called). =


So I was wondering : what should be the best way to do it ? And is it possi=
ble ?
Should I create one modem with 2 drivers (with my own driver using atmodem =
and gobi driver) ? =

Or should I create 2 modems with each one the driver needed (gobi/qmimodem =
and my own driver/atmodem) ?
 =


I am using Ofono v1.15. If you need more information, do not hesitate. =


Thank you in advance for any advices or help


Best regards,

Myl=C3=A8ne

--===============1743568102609427820==--

