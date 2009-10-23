Content-Type: multipart/mixed; boundary="===============8206519056382517172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Replace Glib type with standard C type
Date: Fri, 23 Oct 2009 13:50:40 -0500
Message-ID: <200910231350.41132.denkenz@gmail.com>
In-Reply-To: <950565abe7cf75659689ac1b29a31e24@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8206519056382517172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Below patch is to replace Glib type with standard C type in hfpmodem.h,
> > like guint, guint8, etc.
>
> I see I am not the only one repulsed by those silly and pointless gtypede=
fs
>
> :)

For the most part I agree, however typing guint8 sure beats typing unsigned =

char.  I wouldn't mind us using a shorter type definition.  Perhaps we shou=
ld =

standardize on uint8_t, uint16_t and friends from stdint.h?

Regards,
-Denis

--===============8206519056382517172==--

