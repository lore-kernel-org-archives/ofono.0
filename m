Content-Type: multipart/mixed; boundary="===============8653932643910395631=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] gisi: Consumer functions for ISI message iterator
Date: Thu, 03 Mar 2011 19:08:30 +0200
Message-ID: <AANLkTi=KaFexYH_q20ixEGn32ym9X7bUxjNQawgDUg-2@mail.gmail.com>
In-Reply-To: <1299136959-22653-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8653932643910395631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

2011/3/3 Antti Paila <antti.paila@nokia.com>:
<snip>

> =C2=A0struct _GIsiSubBlockIter {
> + =C2=A0 =C2=A0 =C2=A0 uint8_t cursor;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *start;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gboolean longhdr;

The cursor actually needs to be 16 bits, because when the long header
format is in use, that is what subblock length uses.

I pushed this patch, and fixed the issue afterwards.

Cheers,
Aki

--===============8653932643910395631==--

