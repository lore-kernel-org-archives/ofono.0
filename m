Content-Type: multipart/mixed; boundary="===============2012119781580171297=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] voicecall: Fix emergency number handling
Date: Wed, 19 Jan 2011 13:29:48 +0200
Message-ID: <AANLkTi=07D6OFuf_dz8C+Z6EEUeKMSPNhV=n3CMWgnfO@mail.gmail.com>
In-Reply-To: <1295428231-27485-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2012119781580171297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Self,

2011/1/19 Aki Niemi <aki.niemi@nokia.com>:
> @@ -2095,11 +2095,11 @@ static void ecc_g2_read_cb(int ok, int total_leng=
th, int record,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("%d", ok);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto check;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (total_length < 3) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_error("Unabl=
e to read emergency numbers from SIM");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto check;

Obviously, only one of the callbacks needs this fall-through logic in
case the read fails. Not both.

Cheers,
Aki

--===============2012119781580171297==--

