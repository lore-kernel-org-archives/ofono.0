Content-Type: multipart/mixed; boundary="===============0877448390186698739=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim 12/13] Annotate overriding functions with override
Date: Mon, 18 Nov 2019 15:32:52 -0600
Message-ID: <b5d615ea-3a57-b23d-4093-47389517933a@gmail.com>
In-Reply-To: <20191112213719.9309-13-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0877448390186698739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 11/12/19 3:37 PM, Jonah Br=C3=BCchert wrote:
> * Allows us to notice when a function becomes source incompatible in a Qt=
 major release,
>    and our implementation stops overriding.
> ---
>   src/aidapplication.cpp      |  3 ++-
>   src/aidapplication.h        |  4 ++--
>   src/callmanager.h           |  2 +-
>   src/control.h               | 18 +++++++--------
>   src/hardwaremanipulator.cpp |  1 +
>   src/phonesim.h              | 16 +++++++-------
>   src/qatutils.cpp            | 44 ++++++++++++++++++-------------------
>   src/qgsmcodec.h             | 10 ++++-----
>   src/qwsppdu.cpp             |  6 ++---
>   src/qwsppdu.h               |  4 ++--
>   src/simapplication.h        | 20 ++++++++---------
>   src/simauth.h               |  2 +-
>   src/simfilesystem.h         |  4 ++--
>   13 files changed, 68 insertions(+), 66 deletions(-)
> =

> diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
> index 807d7f9..395fe99 100644
> --- a/src/aidapplication.cpp
> +++ b/src/aidapplication.cpp
> @@ -190,7 +190,8 @@ bool AidAppWrapper::command( const QString& cmd )
> =

>               return true;
>           }
> -        break;
> +        // if CMD_TYPE_GSM_AUTH is the case, we already returned
> +        // and can't fallthrough, so no break here

This doesn't seem to belong in this patch, so I left it out.

>           case CMD_TYPE_UMTS_AUTH:
>           {
>               enum UmtsStatus status;

<snip>

> diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
> index ea895e7..63c498a 100644
> --- a/src/hardwaremanipulator.cpp
> +++ b/src/hardwaremanipulator.cpp
> @@ -363,4 +363,5 @@ void HardwareManipulator::simAppAbort()
> =

>   void HardwareManipulator::callManagement( QList<CallInfo> *info )
>   {
> +    Q_UNUSED(info)
>   }

Same here

Rest applied, thanks.

Regards,
-Denis
--===============0877448390186698739==--

