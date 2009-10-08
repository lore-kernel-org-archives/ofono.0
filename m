Content-Type: multipart/mixed; boundary="===============4999717985355860751=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] voicecall: allow P or , within the dial string
Date: Thu, 08 Oct 2009 22:30:57 +0300
Message-ID: <80fd4e750910081230i4a774e10nfabf3a2b201b3852@mail.gmail.com>
In-Reply-To: <200910081229.04491.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4999717985355860751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/10/8 Denis Kenzior <denkenz@gmail.com>:
>> "DTMF control digit separator" is used as pause according to GSM 02.07.
>> According to GSM 11.11 it is stored as BCD code 1100 in the SIM card. No=
kia
>> modems use 'p' to represent pause. AT commands use ',' to represent paus=
e.
>
> Strictly speaking AT modems use 'C' to represent the pause. =C2=A0Can you=
 point me
> to any spec that actually says ',' and 'p' are used the way you describe?

C?

RFC 4967 uses 'X' to wait for call completion, and 'P' for pause.

Nokia modems use 'p' to represent DMTF control digit separator. GSM
02.07 specifies how the DTMF control digit separator is used when
making calls. The dtmf digits in the dial string are sent after the
call gets connected. The extra separator characters represent extra
delays.

V.250 uses '@' to wait for call completion, and ',' for pause
(controlled by S8).

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Pause can be described wi=
th P or , */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tones[i] =3D=3D 'P' || t=
ones[i] =3D=3D ',') {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
tones[i] =3D 'p';
>
> This should really be 'C'.
>
> We also need to modify the code above not to accept 'D' as a valid charac=
ter
> since that is a wild card value.

The dial string stored  in the SIM card along with a phone number
cannot contain DTMF digits A-D. However, the other dialstrings do not
share the same limitation and they can can contain full set of DTMF
digits, 0-9, *, #, A, B, C, and D. The special bcd coded digits (dtmf
control digit separator and wildcard) from the SIM card must be mapped
outside this set.

Nokia modems use 'p' and '?' for that purpose (extended bcd code
0b1100 =3D> 'p', extended bcd code 0b1101 =3D> '?').  I think G1 uses ','
instead of 'p'. Either one is fine.

An why to include pause in the tones string in the first place? The
current API does not provide any feedback of the sent dtmf digits to
the application or between ofono driver and core, so the only way to
implement pauses between digits is to include them in the dial string
and hope the driver can do something about them.

-- =

Pekka.Pessi mail at nokia.com

--===============4999717985355860751==--

