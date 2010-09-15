Content-Type: multipart/mixed; boundary="===============3522371804161721934=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: simulate language notification in sim app
Date: Wed, 15 Sep 2010 13:54:01 -0500
Message-ID: <4C911649.6070505@gmail.com>
In-Reply-To: <1284503275-21395-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3522371804161721934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/14/2010 05:27 PM, Jeevaka Badrappan wrote:
> ---
>  src/qsimcommand.cpp    |   11 ++++++++
>  src/simapplication.cpp |   68 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/simapplication.h   |    2 +
>  3 files changed, 81 insertions(+), 0 deletions(-)
> =

> diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
> index 9a9a169..9746592 100644
> --- a/src/qsimcommand.cpp
> +++ b/src/qsimcommand.cpp
> @@ -3280,6 +3280,17 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduO=
ptions options ) const
>          }
>          break;
>  =

> +        case LanguageNotification:
> +        {
> +            if ( qualifier & 0x01 ) {
> +                data +=3D (char)0xAD;
> +                data +=3D (char)0x02;
> +                data +=3D (char)0x73;
> +                data +=3D (char)0x65;
> +            }
> +        }
> +        break;
> +

I'd really prefer that this wasn't completely hard-coded.  Can we make
an enum of some sort, or even use a QString (null means no language
object included)

Regards,
-Denis

--===============3522371804161721934==--

