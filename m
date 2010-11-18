Content-Type: multipart/mixed; boundary="===============7379358851015908751=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 1/3] Add TTY (hearing impaired) support
Date: Thu, 18 Nov 2010 09:26:53 -0200
Message-ID: <AANLkTinUWXjeiHChQi_9=yJ4qm8WPot=87fL-ba9_vxG@mail.gmail.com>
In-Reply-To: <1290052269.29148.16.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7379358851015908751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, Nov 18, 2010 at 1:51 AM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> Hi Lucas,
>
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A05 +-
>> =C2=A0include/dbus.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01=
 +
>> =C2=A0include/text-telephony.h | =C2=A0 71 ++++++++++
>> =C2=A0src/modem.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A01 +
>> =C2=A0src/ofono.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A02 +
>> =C2=A0src/text-telephony.c =C2=A0 =C2=A0 | =C2=A0333 +++++++++++++++++++=
+++++++++++++++++++++++++++
>> =C2=A06 files changed, 411 insertions(+), 2 deletions(-)
>> =C2=A0create mode 100644 include/text-telephony.h
>> =C2=A0create mode 100644 src/text-telephony.c
>
> did I miss the patch for doc/text-telephony.txt?

Sorry, I missed that. I'm sending again with the docs.

regards

Lucas De Marchi

--===============7379358851015908751==--

