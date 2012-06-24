Content-Type: multipart/mixed; boundary="===============6903622196734077751=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] hardwaremanipulator: Use the best scheme for CBS
 message
Date: Sun, 24 Jun 2012 17:12:35 -0500
Message-ID: <4FE790D3.2050904@gmail.com>
In-Reply-To: <1340809845-26595-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6903622196734077751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/27/2012 10:10 AM, Philippe Nunes wrote:
> ---
>   src/control.cpp             |    9 +++----
>   src/hardwaremanipulator.cpp |   61 ++++++++++++++++++++++--------------=
-------
>   src/hardwaremanipulator.h   |    6 +++--
>   3 files changed, 38 insertions(+), 38 deletions(-)
>

<snip>

> @@ -91,43 +90,45 @@ QString HardwareManipulator::constructCBMessage(const=
 QString&messageCode, int
>           warning(tr("Invalid Channel,"),
>                   tr("Channel  must be 4 hex digits long "
>                      "and no larger than FFFF"));
> -        return "";
> +        return;
>       }
>
> -    //scheme is currently hardcoded to QSMS8_BitCodingScheme
> -    //uint sch =3D convertString(scheme, NIBBLE_MAX, ONE_CHAR,HEX_BASE,&=
ok);
> -    //if ( !ok )
> -    //    return "";
> -
>       QCBSMessage::Language lang =3D (QCBSMessage::Language)language;
>
> -    uint npag =3D convertString(numPages, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&=
ok);
> -    if ( !ok ) {
> -        warning(tr("Invalid number of pages,"),
> -                tr("Number of pages  must be 1 hex digit long "
> -                   "and no larger than F"));
> -        return "";
> -    }
> -
> -    uint pag =3D convertString(page, NIBBLE_MAX,ONE_CHAR,HEX_BASE,&ok);
> -    if ( !ok ) {
> -        warning(tr("Invalid page number,"),
> -                tr("Page number  must be 1 hex digit long "
> -                   "and no larger than F"));
> -        return "";
> -    }
> -
>       QCBSMessage m;
>       m.setMessageCode(mc);
>       m.setScope(gs);
>       m.setUpdateNumber(un);
>       m.setChannel(ch);
>       m.setLanguage(lang);
> -    m.setNumPages(npag);
> -    m.setPage(pag);
> +    m.setPage(1);
>       m.setText(content);
> +    m.setDataCodingScheme(m.bestScheme());
> +
> +    if ( m.dataCodingScheme() =3D=3D QSMS_DefaultAlphabet&&
> +                content.length()>  (15*93)) {
> +        warning(tr("Text too long"),
> +        tr("The maximum number of pages (15) "
> +                          "is reached - text is truncated"));
> +        m.setText(content.mid( 0, 15*93 ));
> +    } else if (content.length()>  (15*40)) {
> +        warning(tr("Text too long"),
> +        tr("The maximum number of pages (15) "
> +                           "is reached - text is truncated"));
> +        m.setText(content.mid( 0, 15*40 ));
> +    }

Why are you adding these checks when computeSize can already tell you =

the number of pages required?  Also, this really belongs in the =

follow-on patch since that deals with multiple pages.  It sounds like =

bestScheme / dataCodingScheme need some more thought.

> +
> +    uint nbPages, spaceLeftInLast;
> +    m.computeSize( nbPages, spaceLeftInLast );
> +    m.setNumPages(nbPages);

The split() operation should really be setting the number of pages.

Regards,
-Denis

--===============6903622196734077751==--

