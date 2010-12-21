Content-Type: multipart/mixed; boundary="===============1082363678933591268=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 12:01:16 -0600
Message-ID: <4D10EB6C.8010503@gmail.com>
In-Reply-To: <87bp4f9vyb.fsf@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1082363678933591268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

>> I think the better way would be to drop a udev rule directly into
>> /etc/udev.d or similar.  The rule should be as simple as:
>> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
> =

> Do you mean in another file than 97-ofono.rules?

Yep.

Regards,
-Denis

--===============1082363678933591268==--

