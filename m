Content-Type: multipart/mixed; boundary="===============1957136052635793023=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH mmsd 01/12] Constify GDBus tables
Date: Fri, 18 May 2012 15:05:32 -0700
Message-ID: <1337378732.2058.28.camel@aeonflux>
In-Reply-To: <1337371199-29496-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1957136052635793023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Constify method tables with the following commands:
> =

> find . -name '*.[ch]' -exec sed -i \
> 	     's/\(c\)\(GDBusSignalTable .* =3D\)/\1 const \2/g' {} \;
> =

> find . -name '*.[ch]' -exec sed -i \
> 	     's/\(c\)\(GDBusMethodTable .* =3D\)/\1 const \2/g' {} \;
> ---
>  plugins/ofono.c |    2 +-
>  src/service.c   |   12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

all 12 patches have been applied.

Regards

Marcel



--===============1957136052635793023==--

