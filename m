Content-Type: multipart/mixed; boundary="===============7389591808763784552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim 10/13] Port from c-style casts to static_cast<>()
Date: Mon, 18 Nov 2019 15:13:24 -0600
Message-ID: <bf367606-25d4-a879-8a24-da940fb1c067@gmail.com>
In-Reply-To: <20191112213719.9309-11-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7389591808763784552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 11/12/19 3:37 PM, Jonah Br=C3=BCchert wrote:
> Done using the google-readability-casting check of clang-tidy
> ---
>   src/callmanager.cpp          |   6 +-
>   src/hardwaremanipulator.cpp  |  12 +-
>   src/phonesim.cpp             |  62 +++---
>   src/qatresult.cpp            |  10 +-
>   src/qatresultparser.cpp      |   6 +-
>   src/qatutils.cpp             | 116 +++++------
>   src/qcbsmessage.cpp          |   6 +-
>   src/qgsmcodec.cpp            |  54 ++---
>   src/qsimcommand.cpp          | 370 +++++++++++++++++------------------
>   src/qsimcontrolevent.cpp     |  16 +-
>   src/qsimenvelope.cpp         |  48 ++---
>   src/qsimterminalresponse.cpp |  98 +++++-----
>   src/qsmsmessage.cpp          | 208 ++++++++++----------
>   src/qsmsmessage_p.h          |   4 +-
>   src/qwsppdu.cpp              |  94 ++++-----
>   src/simapplication.cpp       |  68 +++----
>   src/simauth.cpp              |  12 +-
>   src/simfilesystem.cpp        |  24 +--
>   18 files changed, 605 insertions(+), 609 deletions(-)
> =


This patch is really way too long, and since it was seemingly done by =

machine, you probably need to check whether all the changes make sense =

first.  Just a few examples, picking at random:

> diff --git a/src/callmanager.cpp b/src/callmanager.cpp
> index 1fa13cf..5436e08 100644
> --- a/src/callmanager.cpp
> +++ b/src/callmanager.cpp
> @@ -203,8 +203,8 @@ bool CallManager::command( const QString& cmd )
>                   multiparty =3D 0;
>               QString line =3D
>                   "+CLCC: " + QString::number(info.id) + "," +
> -                QString::number((int)(info.incoming)) + "," +
> -                QString::number((int)(info.state)) + ",0," +
> +                QString::number(static_cast<int>(info.incoming)) + "," +
> +                QString::number(static_cast<int>(info.state)) + ",0," +

These casts are not needed at all due to implicit conversions

>                   QString::number(multiparty);
>               if ( !info.number.isEmpty() ) {
>                   line +=3D ",";

<snip>

> @@ -2501,8 +2501,8 @@ void DemoSimApplication::BIPMenu( const QSimTermina=
lResponse& resp )
> =

>                   destAddress +=3D 0x21;
>                   destAddress +=3D 0x7F; /* local host 127.0.0.1 */
> -                destAddress +=3D (char) 0x00;
> -                destAddress +=3D (char) 0x00;
> +                destAddress +=3D static_cast<char>(0x00);
> +                destAddress +=3D static_cast<char>(0x00);

Why use a cast here but not lines above or below..

>                   destAddress +=3D 0x01;
> =

>                   apn +=3D 0x06;
> diff --git a/src/simauth.cpp b/src/simauth.cpp
> index 93b8826..b5fc7b1 100644
> --- a/src/simauth.cpp
> +++ b/src/simauth.cpp
> @@ -52,8 +52,8 @@ void SimAuth::gsmAuthenticate( QString rand, QString &s=
res,
> =

>       comp128( ki, _rand, _sres, _kc );
> =

> -    sres =3D QByteArray( (const char *)_sres, 4 ).toHex();
> -    kc =3D QByteArray( (const char *)_kc, 8 ).toHex();
> +    sres =3D QByteArray( reinterpret_cast<const char *>(_sres), 4 ).toHe=
x();
> +    kc =3D QByteArray( reinterpret_cast<const char *>(_kc), 8 ).toHex();

This likely needs a toUtf8 or something instead of messing with casts.

>   }
> =


Perhaps you want to split it up a bit more so the parts that make sense =

can get merged, and the rest we can address piecemeal by removing the =

unnecessary casts.

Regards,
-Denis
--===============7389591808763784552==--

