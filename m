Content-Type: multipart/mixed; boundary="===============8602308716523407221=="
MIME-Version: 1.0
From: Teemu Piiroinen <teemu.piiroinen@gmail.com>
Subject: Re: Option GTM 382
Date: Mon, 26 Apr 2010 16:33:17 +0300
Message-ID: <p2w35f991da1004260633q80d32ae4r5831ddd64e1b98bc@mail.gmail.com>
In-Reply-To: <878w8asd5i.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8602308716523407221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No luck yet..

Did I setup the sw correcty?
- I run configure, make and make install
- Added ofono.rules to /etc/udev/rules.d and /lib/udev/rules.d/
- Started ofono by running ofonod from shell

Is there something else I need to do?

I also removed network manager from Ubuntu, but that didn't help either.

Br,
Teemu

On Mon, Apr 26, 2010 at 1:48 PM, Kalle Valo <kalle.valo@canonical.com> wr=
ote:
> "Gu, Yang" <yang.gu@intel.com> writes:
>
>>>lsusb shows the device in the list:
>>>Bus 001 Device 004: ID 0af0:7601 Option
>>
>> Yes, it seems we have the same modem.
>>>
>>>Any ideas, what I should check next?
>>
>> Have you put the ofono.rules into /etc/udev/rules.d?
>
> BTW, that's /lib/udev/rules.d/ on Ubuntu 10.04.
>
> --
> Kalle Valo
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============8602308716523407221==--

