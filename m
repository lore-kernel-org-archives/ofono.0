Content-Type: multipart/mixed; boundary="===============7912533913861929117=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/6] smsutil: Remove dialect checks from caller
Date: Thu, 03 Feb 2011 22:29:43 +0200
Message-ID: <AANLkTinRL6ehkYFHmyT7mSyKtyMcb4tybwKzAy_eLS-t@mail.gmail.com>
In-Reply-To: <4D4B0993.1010607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7912533913861929117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/2/3 Denis Kenzior <denkenz@gmail.com>:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 converted =3D convert_gsm_to_utf8_with_lang(buf, written,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N=
ULL, NULL, 0,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l=
ocking_shift,
>
> I'm pretty sure you want to leave this check in, otherwise you will not
> be compliant with 23.040. =C2=A0If the dialect used is not understood, we
> have to fall-back to the default, not ignore the message.

Uh, you're right. My intention was to implement the fallback inside
convert_gsm_to_utf8_with_lang(), but then ended up factoring that
fallback behavior out with conversion_table_init()...

So maybe it's better done here anyway, and this patch can be ignored.

Cheers,
Aki

--===============7912533913861929117==--

