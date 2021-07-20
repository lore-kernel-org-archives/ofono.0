Content-Type: multipart/mixed; boundary="===============1027895132136460281=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Tue, 20 Jul 2021 17:11:45 +0100
Message-ID: <8171168c-ee95-46c2-48bf-006dbfb59309@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1027895132136460281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm doing a bit of work with Ofono again, extending support for a =

Quectel EG91 - handling additional cell strength information which seems =

necessary for LTE.

I'm using Quectel's AT+QCOPS which is returning some negative signal =

strengths and after some investigation I've spotted that =

gatresult::g_at_result_iter_next_number() doesn't handle negative numbers.

No doubt there's a better solution than mine, but this does appear to work.

Cheers,

Alex

--- ofono-1.22.org/gatchat/gatresult.c=C2=A0 2011-10-11 18:21:45.000000000 =
+0000
+++ ofono-1.22/gatchat/gatresult.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2021-07-20=
 15:50:06.300001000 +0000
@@ -262,6 +262,7 @@
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int end;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int len;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int value =3D 0;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int sign =3D 1;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *line;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iter =3D=3D NULL)
@@ -276,10 +277,16 @@
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos =3D iter->line_pos;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D pos;

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if(line[end] =3D=3D '-') {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sign =3D -1;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 end +=3D 1;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (line[end] >=3D '0' && li=
ne[end] <=3D '9') {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 value =3D value * 10 + (int)(line[end] - '0');
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 end +=3D 1;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D sign * value;

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pos =3D=3D end)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return FALSE;

--===============1027895132136460281==--

