Content-Type: multipart/mixed; boundary="===============2025161098065320635=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 20:09:09 +0300
Message-ID: <AANLkTikUq6eQuhGj3eSaNt4Vh=YK4p6w-Ep5sLDB58HV@mail.gmail.com>
In-Reply-To: <AANLkTi=DWN54mvFZzn=odY9soF6h4hLVyQt30T0CvBSO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2025161098065320635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/9/3 Pekka Pessi <ppessi@gmail.com>:
> Morjes Aki,
>
> 2010/9/2 Aki Niemi <aki.niemi@nokia.com>:
>> + =C2=A0 =C2=A0 =C2=A0 case SMS_ALPHABET_TURKISH:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gsm_encoded =3D conve=
rt_utf8_to_gsm_with_lang(utf8, -1, NULL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &written, 0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GSM_DIALECT_TURKISH,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GSM_DIALECT_TURKISH);
>
> If you look at the tables, =C2=A0the idea is normally to use either locki=
ng
> Turkish and default single, or default locking and Turkish single
> shift, never both.

I suppose I should've looked at the tables, then.

Anyway, the best way to use the dialects would obviously be to find
the optimal encoding, and use as few extension tables as possible.
That is missing currently.

> Also, if it is possible to fit the message to one segment only using
> national single shift table, single shift should be used (if receiver
> does not support national variants, the result is much less garbled).

Sure, you could even try any combination of dialects to find the
optimal encoding.

If you look at the Turkish tables, they try to align with the default
tables. That is, if the recipient doesn't understand the extensions,
they will use a rather similar looking character from the default
table.

That principle is gone with Portuguese and later extensions.

> I just peeked in the 23.038 from release 9, it seems to me that we are
> bound to get much more entertainment.

The funny thing is that the new tables seem to pack a lot of new
characters into single shift. Which compared with UCS-2, is of course
only 2bits per character more efficient.

Cheers,
Aki

--===============2025161098065320635==--

