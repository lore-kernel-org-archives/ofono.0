Content-Type: multipart/mixed; boundary="===============6130292218972672651=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 17:40:57 +0300
Message-ID: <AANLkTi=DWN54mvFZzn=odY9soF6h4hLVyQt30T0CvBSO@mail.gmail.com>
In-Reply-To: <1283413960-31490-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6130292218972672651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Morjes Aki,

2010/9/2 Aki Niemi <aki.niemi@nokia.com>:
> + =C2=A0 =C2=A0 =C2=A0 case SMS_ALPHABET_TURKISH:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gsm_encoded =3D conver=
t_utf8_to_gsm_with_lang(utf8, -1, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &written, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GSM_DIALECT_TURKISH,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GSM_DIALECT_TURKISH);

If you look at the tables,  the idea is normally to use either locking
Turkish and default single, or default locking and Turkish single
shift, never both.

Also, if it is possible to fit the message to one segment only using
national single shift table, single shift should be used (if receiver
does not support national variants, the result is much less garbled).

I just peeked in the 23.038 from release 9, it seems to me that we are
bound to get much more entertainment.

--Pekka

-- =

Pekka.Pessi mail at nokia.com

--===============6130292218972672651==--

