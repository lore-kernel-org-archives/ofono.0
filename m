Content-Type: multipart/mixed; boundary="===============8054136992323569017=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add USC-2 to UTF-8 conversion utility function.
Date: Mon, 06 Jul 2009 11:26:26 -0500
Message-ID: <200907061126.26644.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8054136992323569017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The rest of the codebase uses g_convert which handles the necessary magic o=
f =

invoking iconv.  So this function is really not necessary, use g_convert(bu=
f, =

bufsize, "UTF-8//TRANSLIT", "UCS-2BE",... instead.

Regards,
-Denis


--===============8054136992323569017==--

