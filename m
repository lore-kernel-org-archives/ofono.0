Content-Type: multipart/mixed; boundary="===============2118974459398923578=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4] Add Suspended property to GPRS (take 3)
Date: Fri, 10 Sep 2010 11:00:35 -0500
Message-ID: <4C8A5623.8010805@gmail.com>
In-Reply-To: <1284126659-18741-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2118974459398923578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 09/10/2010 08:50 AM, Mika Liljeberg wrote:
> Comments from Denis applied.
> =

> Br,
> =

> 	MikaL
> =

> [PATCH 1/4] TODO: Claim ownership of Suspended property for GPRS
> [PATCH 2/4] gprs: add Suspended property
> [PATCH 3/4] isimodem: implement Suspended property
> [PATCH 4/4] test: add enable-gprs and disable-gprs scripts
> =

>  TODO                     |    3 +-
>  doc/connman-api.txt      |   19 ++++++++++++
>  drivers/isimodem/debug.c |   25 ++++++++++++++++
>  drivers/isimodem/debug.h |    2 +
>  drivers/isimodem/gpds.h  |   17 +++++++++++
>  drivers/isimodem/gprs.c  |   56 +++++++++++++++++++++++++++++++++++-
>  include/gprs.h           |   10 ++++++
>  src/gprs.c               |   72 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  test/disable-gprs        |   20 +++++++++++++
>  test/enable-gprs         |   20 +++++++++++++
>  10 files changed, 242 insertions(+), 2 deletions(-)

All four patches have been applied.  Thanks :)

Just a heads up, when you're adding new files to the project, check to
see whether the build system (Makefile.am) needs to be told about these
files.  In this case you forgot to add the two test scripts to
Makefile.am.  Running 'make distcheck' whenever new files are added
helps catch most of such issues.

Regards,
-Denis

--===============2118974459398923578==--

