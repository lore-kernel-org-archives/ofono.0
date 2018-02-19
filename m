Content-Type: multipart/mixed; boundary="===============7685185848881329600=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] doc: Add SystemPath to Modem interface
Date: Mon, 19 Feb 2018 11:25:54 -0600
Message-ID: <1c57e6cd-6c6c-b21e-8030-0213cbaf3d7f@gmail.com>
In-Reply-To: <ce6ae2ee-8c43-ef67-18a3-01b6436536cf@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7685185848881329600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string SystemPath [readonly,=
 optional]
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Stri=
ng giving a consistent hardware path for the modem
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devi=
ce. It will not change in case of reboot of modem
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or o=
fono.
> =

> Given that many modems are USB devices, I don't think you can actually =

> promise this.=C2=A0 I can envision a (slightly pathological) hardware des=
ign =

> whereby the presence or absence of an _external_ device at startup may =

> change the device enumeration order and thereby the syspath...
> =


Right, this can depend on the kernel version also.  I wouldn't claim any =

guarantees at the D-Bus API level as it is outside our control.

If someone chooses to use it as a consistent path, then they do it at =

their own risk.

Regards,
-Denis

--===============7685185848881329600==--

