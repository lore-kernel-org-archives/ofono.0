Content-Type: multipart/mixed; boundary="===============8805333244206996800=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] phonesim: add null text string case
Date: Tue, 04 Jan 2011 10:55:14 -0600
Message-ID: <4D2350F2.1090905@gmail.com>
In-Reply-To: <1294047790-2465-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8805333244206996800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/03/2011 03:43 AM, Jeevaka Badrappan wrote:
> ---
>  src/qsimcommand.cpp |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> =


I applied this patch, however:

> +    if ( str.isEmpty() && ( options & QSimCommand::EncodeEmptyStrings ) =
=3D=3D 0 ) {
> +        // Special form for empty strings.
> +        binary +=3D (char)tag;
> +        binary +=3D (char)0x01;
> +        binary +=3D (char)options;

This part was working by accident.  options does not necessarily map to
a valid dcs used by the Text data object.  I fixed this in a follow on
commit.

> +        return;
> +    }
>      int schemeMask =3D ((tag & 0xFF00) >> 8);     // For USSD string out=
put.
>      if ( ( options & QSimCommand::UCS2Strings ) =3D=3D 0 ) {
>          QTextCodec *gsm =3D QAtUtils::codec( "gsm-noloss" );

Regards,
-Denis

--===============8805333244206996800==--

