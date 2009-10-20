Content-Type: multipart/mixed; boundary="===============8659613169577199408=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Tue, 20 Oct 2009 10:13:52 -0500
Message-ID: <200910201013.52644.denkenz@gmail.com>
In-Reply-To: <4ADD7E7E.8030903@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8659613169577199408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Sorry. I have had a long few days. The last patch was just COMPLETELY
> wrong :(
>
> I think i got it right this time...

So the patch is still wrong :)

 	memset(&ti, 0, sizeof(ti));
 	cfmakeraw(&ti);
 =

+	fd =3D open(tty, O_RDWR | O_NOCTTY | O_NONBLOCK);
+	if (fd < 0)
+		return -1;
+
+	tcgetattr(fd,&ti);
+

You're blowing away the result of cfmakeraw.  Most of the devices are not t=
rue =

serial devices and so do not need any of the special options.  Passing a NU=
LL =

options GHashTable should result in cfmakeraw.  Why don't you just pass all =

the options you need instead of using tcgetattr?

The other parts of the patch look good to me.

Regards,
-Denis

--===============8659613169577199408==--

