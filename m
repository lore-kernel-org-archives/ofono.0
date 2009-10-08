Content-Type: multipart/mixed; boundary="===============4189594459538697253=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: allow P or , within the dial string
Date: Thu, 08 Oct 2009 12:29:04 -0500
Message-ID: <200910081229.04491.denkenz@gmail.com>
In-Reply-To: <1255021194-31138-3-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4189594459538697253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> "DTMF control digit separator" is used as pause according to GSM 02.07.
> According to GSM 11.11 it is stored as BCD code 1100 in the SIM card. Nok=
ia
> modems use 'p' to represent pause. AT commands use ',' to represent pause.

Strictly speaking AT modems use 'C' to represent the pause.  Can you point =
me =

to any spec that actually says ',' and 'p' are used the way you describe?

> +		/* Pause can be described with P or , */
> +		if (tones[i] =3D=3D 'P' || tones[i] =3D=3D ',') {
> +			tones[i] =3D 'p';

This should really be 'C'.

We also need to modify the code above not to accept 'D' as a valid characte=
r =

since that is a wild card value.

Regards,
-Denis

--===============4189594459538697253==--

