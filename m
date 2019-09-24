Content-Type: multipart/mixed; boundary="===============8382373849038914587=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 12:23:27 -0500
Message-ID: <7a839111-0ce5-65ae-af47-97b9d0234b13@gmail.com>
In-Reply-To: <e799cbb1-f8c5-d81e-6056-80e2b7b033cb@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8382373849038914587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> =

> Furthermore, there's not an AT command sent every 500 ms.=C2=A0 The comma=
nd =

> gets requeued after 500ms, but it doesn't actually go out until the =

> modem responds to the first one... not quite sure why this works, to be =

> honest.
> =


Funny.  But not real confidence inspiring :)

Martin, any ideas what could be going wrong here?

Regards,
-Denis

--===============8382373849038914587==--

