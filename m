Content-Type: multipart/mixed; boundary="===============5698201434091393164=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Pi=C4=8Dugins?= Arsenijs <crimier@yandex.ru>
Subject: Re: [PATCH 2/3] sim800: add documentation.
Date: Wed, 07 Nov 2018 15:53:31 +0200
Message-ID: <5657011541598811@myt5-9da6df248f4a.qloud-c.yandex.net>
In-Reply-To: <7808bb11-d16f-4189-d4a0-76d861e40fd3@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5698201434091393164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Confused by this. Isn't the sim900 the serial modem and sim800 the USB
> model? The above rule is for a strictly "serial" modem.

Nope, the SIM800 is a serial modem - it's, as far as I can tell, the next g=
eneration
after SIM900 or something along those lines. It also has a USB port, IIRC,
but I never had a chance to use that.

-Arsenijs

07.11.2018, 15:50, "Jonas Bonn" <jonas@norrbonn.se>:
> Hi Clement,
>
> On 07/11/2018 11:14, Clement Viel wrote:
>> =C2=A0---
>> =C2=A0=C2=A0=C2=A0doc/sim800-modem.txt | 7 +++++++
>> =C2=A0=C2=A0=C2=A01 file changed, 7 insertions(+)
>> =C2=A0=C2=A0=C2=A0create mode 100644 doc/sim800-modem.txt
>>
>> =C2=A0diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
>> =C2=A0new file mode 100644
>> =C2=A0index 0000000..a299e97
>> =C2=A0--- /dev/null
>> =C2=A0+++ b/doc/sim800-modem.txt
>> =C2=A0@@ -0,0 +1,7 @@
>> =C2=A0+SIM800 modem usage
>> =C2=A0+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0+
>> =C2=A0+To enable SIM800 module support you need to put the following
>> =C2=A0+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
>> =C2=A0+
>> =C2=A0+KERNEL=3D=3D"ttyS0", ENV{OFONO_DRIVER}=3D"sim800"
>
> Confused by this. Isn't the sim900 the serial modem and sim800 the USB
> model? The above rule is for a strictly "serial" modem.
>
> /Jonas
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============5698201434091393164==--

