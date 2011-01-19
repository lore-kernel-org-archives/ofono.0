Content-Type: multipart/mixed; boundary="===============6147148630449785011=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [offline-atoms PATCH 1/2] Make gprs atom offline-safe.
Date: Wed, 19 Jan 2011 15:33:25 +0200
Message-ID: <AANLkTing29eqccHn1Y5_V1g=BELX0HJKMa3_MYD9SaW4@mail.gmail.com>
In-Reply-To: <4D3662BD.1060604@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6147148630449785011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/19 Denis Kenzior <denkenz@gmail.com>:
>> + =C2=A0 =C2=A0 if (gprs->netreg =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gprs_netreg_removed(gprs);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>
> I'm having trouble visualizing why this chunk is necessary. =C2=A0We reset
> netreg to NULL only when shutting down the atom or when netreg atom goes
> away. =C2=A0So this condition should never be triggered.

It is for the case where the gprs atom is inserted in post_sim but
netreg in post_online.

-- =

Pekka.Pessi mail at nokia.com

--===============6147148630449785011==--

