Content-Type: multipart/mixed; boundary="===============5980070159604601951=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Code standards
Date: Wed, 27 May 2009 16:27:33 +0200
Message-ID: <1243434453.3043.4.camel@localhost.localdomain>
In-Reply-To: <200905271546.29540.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5980070159604601951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> I assume the coding styles are the "usual" ones, and the last thing I wan=
t is =

> to start a flame war about those. But which C dialect is Ofono supposed t=
o be =

> written in? plain C89, C89 syntax + C99 library, full C99, GNU C... ?

the coding style of oFono is the same as for the Linux kernel, BlueZ,
ConnMan, obexd etc. So basically checkpatch.pl patches are fine.

When using ./bootstrap-configure is used it enables a certain set of GCC
warnings and it should be warnings free. So that is good measurement for
the style details ;)

Regards

Marcel



--===============5980070159604601951==--

