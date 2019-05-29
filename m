Content-Type: multipart/mixed; boundary="===============6053726963531830224=="
MIME-Version: 1.0
From: Pranoti Bobade <pranotib@renuelectronics.com>
Subject: Re: AW: Regarding ofonod sending signal 11 after calling
 setup_sim7x00 for sim7600
Date: Wed, 29 May 2019 15:17:52 +0530
Message-ID: <60229CBD50924AF594EC713CF5ECF48C@RENU.COM>
In-Reply-To: <AM0PR08MB442034275757DE3D2F2006DCD71D0@AM0PR08MB4420.eurprd08.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6053726963531830224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

>Do you force ofono to detect a sim7600 at /dev/ttymxc1?
>> Can you how we can achieve this. We have recently started working with =

>> ofono.

Thanks.

Kind Regards,
Pranoti B.


-----Original Message----- =

From: Funktionspostfach Herbrechtsmeier OSS
Sent: Monday, May 27, 2019 2:26 PM
To: Pranoti Bobade ; ofono(a)ofono.org
Subject: AW: Regarding ofonod sending signal 11 after calling setup_sim7x00 =

for sim7600

Hi,

ofono assumes that you use a USB interface with multiple serial interfaces.

I suppose the second DBG in setup_sim7x00() failed because of a NULL in =

info->number.

Do you force ofono to detect a sim7600 at /dev/ttymxc1?

Best regards,
  Stefan

-----Urspr=C3=BCngliche Nachricht-----
Von: ofono [mailto:ofono-bounces(a)ofono.org] Im Auftrag von Pranoti Bobade
Gesendet: Montag, 20. Mai 2019 09:35
An: ofono(a)ofono.org
Betreff: Fw: Regarding ofonod sending signal 11 after calling setup_sim7x00 =

for sim7600



-----Original Message-----
From: Pranoti Bobade
Sent: Friday, May 17, 2019 5:28 PM
To: mailman(a)ofono.org
Subject: Regarding ofonod sending signal 11 after calling setup_sim7x00 for
sim7600

Hello,

Hope you are doing well. We are currently working with ofono to make =

sim7600e work with our ARM based embedded board. Our modem is connected =

through serial interface. We have cloned the latest git repository for ofon=
o =

and compiled it for our board, But when we run ofonod it gives segmentation =

fault in setup_sim7x00() from plugins/udevng.c. Screenshot is attached with =

the mail for reference. Our query is to know if there is support for Serial =

interface of sim7600e.

Thanks in advance. =




--===============6053726963531830224==--

