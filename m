Content-Type: multipart/mixed; boundary="===============6071945511991751381=="
MIME-Version: 1.0
From: Funktionspostfach Herbrechtsmeier OSS <stefan.herbrechtsmeier-oss@weidmueller.com>
Subject: AW: Regarding ofonod sending signal 11 after calling setup_sim7x00
 for sim7600
Date: Mon, 27 May 2019 08:56:22 +0000
Message-ID: <AM0PR08MB442034275757DE3D2F2006DCD71D0@AM0PR08MB4420.eurprd08.prod.outlook.com>
In-Reply-To: <491D5B1B2A4940AF808EC480A2D2A2B9@RENU.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6071945511991751381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

ofono assumes that you use a USB interface with multiple serial interfaces.

I suppose the second DBG in setup_sim7x00() failed because of a NULL in inf=
o->number.

Do you force ofono to detect a sim7600 at /dev/ttymxc1?

Best regards,
  Stefan

-----Urspr=C3=BCngliche Nachricht-----
Von: ofono [mailto:ofono-bounces(a)ofono.org] Im Auftrag von Pranoti Bobade
Gesendet: Montag, 20. Mai 2019 09:35
An: ofono(a)ofono.org
Betreff: Fw: Regarding ofonod sending signal 11 after calling setup_sim7x00=
 for sim7600



-----Original Message-----
From: Pranoti Bobade
Sent: Friday, May 17, 2019 5:28 PM
To: mailman(a)ofono.org
Subject: Regarding ofonod sending signal 11 after calling setup_sim7x00 for
sim7600

Hello,

Hope you are doing well. We are currently working with ofono to make sim760=
0e work with our ARM based embedded board. Our modem is connected through s=
erial interface. We have cloned the latest git repository for ofono and com=
piled it for our board, But when we run ofonod it gives segmentation fault =
in setup_sim7x00() from plugins/udevng.c. Screenshot is attached with the m=
ail for reference. Our query is to know if there is support for Serial inte=
rface of sim7600e.

Thanks in advance.=20

--===============6071945511991751381==--

