Content-Type: multipart/mixed; boundary="===============5552678255887679091=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Thu, 24 Sep 2009 00:01:48 +0200
Message-ID: <fb249edb0909231501k213b46f4lcd388351e16b0f45@mail.gmail.com>
In-Reply-To: <200909231505.15068.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5552678255887679091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/9/23 Denis Kenzior <denkenz@gmail.com>:
> Hi Andrew,
>
>> The only corner case where order is now different is when the first
>
> Sorry, I'm not following, can you elaborate? =C2=A0If sim_efli_format enc=
ounters an
> empty entry it simply continues on...

In 5.1.1.2 of 31.102, EFpl also takes precedence before EFli if FFFF
is in the first entry of EFli, you may interpret this case as EFpl
comes first then EFli, or EFli is discarded altogether.

Regards

--===============5552678255887679091==--

