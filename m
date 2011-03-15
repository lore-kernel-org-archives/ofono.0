Content-Type: multipart/mixed; boundary="===============8020268009090601225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Tue, 15 Mar 2011 17:18:59 -0500
Message-ID: <4D7FE5D3.8060005@gmail.com>
In-Reply-To: <1299506559-32365-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8020268009090601225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/07/2011 08:02 AM, Mika Liljeberg wrote:
> Hi All,
> =

> Patches rebased to current master.
> =

> Regards,
> =

> 	MikaL
> =

> "IPv6 host walked into a bar. No-one would talk to it."
> =

> [RESEND 3 PATCH 01/13] gprs: factor out common code
> [RESEND 3 PATCH 02/13] gprs: Update documentation for IPv6
> [RESEND 3 PATCH 03/13] gprs: driver interface changes for IPv6
> [RESEND 3 PATCH 04/13] gprs: core support for IPv6
> [RESEND 3 PATCH 05/13] test: modify test scripts for IPv6
> [RESEND 3 PATCH 06/13] isimodem: IPv6 support
> [RESEND 3 PATCH 07/13] atmodem: update to new gprs context interface
> [RESEND 3 PATCH 08/13] huaweimodem: update to new gprs context interface
> [RESEND 3 PATCH 09/13] mbmmodem: update to new gprs context interface
> [RESEND 3 PATCH 10/13] hsomodem: update to new gprs context interface
> [RESEND 3 PATCH 11/13] ifxmodem: update to new gprs context interface
> [RESEND 3 PATCH 12/13] stemodem: update to new gprs context interface
> [RESEND 3 PATCH 13/13] phonesim: add IPv6 support
> =

>  Makefile.am                        |    3 +-
>  doc/connman-api.txt                |    9 +-
>  drivers/atmodem/gprs-context.c     |   41 ++--
>  drivers/hsomodem/gprs-context.c    |   48 +++--
>  drivers/huaweimodem/gprs-context.c |   43 +++--
>  drivers/ifxmodem/gprs-context.c    |   36 ++--
>  drivers/isimodem/gprs-context.c    |  119 +++++++-----
>  drivers/mbmmodem/gprs-context.c    |   65 ++++---
>  drivers/stemodem/gprs-context.c    |   30 ++-
>  include/gprs-context.h             |   27 ++-
>  plugins/phonesim.c                 |   32 +++-
>  src/gprs.c                         |  390 ++++++++++++++++++++++++------=
------
>  test/set-context-property          |   38 ++++
>  13 files changed, 580 insertions(+), 301 deletions(-)

So during OSTS Samuel, Marcel and I sat down and tried to figure out the
IPv6 stuff.  Based on this discussion and your implementation I pushed a
series of patches implementing IPv6 and dual-stack contexts.  I have
taken (and later re-worked) some of your patches so you get credit here
as well.

These are highly experimental and have not received much testing (since
I don't really have any facilities to do so).  So please look and let me
know if something isn't working as intended.

Regards,
-Denis

--===============8020268009090601225==--

