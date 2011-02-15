Content-Type: multipart/mixed; boundary="===============2247801750777560868=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Makefile: rerun genbuiltin on reconfigure.
Date: Wed, 16 Feb 2011 00:34:10 +0100
Message-ID: <AANLkTinHd+yrYdcEY7NWWztB53aOtByrTKdwPPseYAJ2@mail.gmail.com>
In-Reply-To: <1297803329.2519.6.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2247801750777560868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 15 February 2011 21:55, Marcel Holtmann <marcel@holtmann.org> wrote:
>> -src/builtin.h: src/genbuiltin $(builtin_sources)
>> +src/builtin.h: src/genbuiltin config.status
>> =C2=A0 =C2=A0 =C2=A0 $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modul=
es) > $@
>
> so depending on config.status is fine, but why no longer on
> $(builtin_sources)?

I didn't see a point for that dependency, it triggers unneeded
rerunning of genbuiltin as far as I see?

Best regards

--===============2247801750777560868==--

