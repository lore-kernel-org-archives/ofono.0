Content-Type: multipart/mixed; boundary="===============1098800372433489115=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2 4/7] stemodem: Add Radio Settings to STE Modem
Date: Mon, 16 Aug 2010 18:29:17 +0200
Message-ID: <AANLkTi=rS3-6DFMDzOQiL1pfpQUTuHNnWpJxv5-=gBbC@mail.gmail.com>
In-Reply-To: <1281967524.23399.40.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1098800372433489115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sjur,
>
>> Changes since last patch set:
>> o Moved updates to plugins/ste to separate patch.
>> o Updated error handling.
>> o Style issues.
>>
>>
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +-
>> =C2=A0drivers/stemodem/radio-settings.c | =C2=A0223 ++++++++++++++++++++=
+++++++++++++++++
>> =C2=A0drivers/stemodem/stemodem.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>> =C2=A0drivers/stemodem/stemodem.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>> =C2=A04 files changed, 230 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 drivers/stemodem/radio-settings.c
>
> is this identical to how MBM does it? If yes, then I prefer we add this
> to drivers/mbmmodem/ and you just reference it. If not then I like to
> see the MBM version of this and where it actually differs. Maybe a MBM
> version with a STE quirk is better.

Actually this is not yet implemented by MBM, so I guess STE is master
this time ;-)

> I prefer doing this in MBM since that modem driver was just the first.
> There is no other preference here ;)

This actually raises one question. How should we handle version variations =
from
the same Modem vendor.
The differences will be larger as we start adding support for LTE, and
support different
bearers (PC cards with USB and Modems with CAIF).
Should we create more entries in the vendor enum, or do you have something
else in mind?

Regards
Sjur

--===============1098800372433489115==--

