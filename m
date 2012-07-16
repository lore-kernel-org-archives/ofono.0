Content-Type: multipart/mixed; boundary="===============8410214304681462906=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_v2 0/3] Fix crash when network is lost
Date: Sun, 15 Jul 2012 20:06:44 -0500
Message-ID: <50036924.2040304@gmail.com>
In-Reply-To: <1342187068-10418-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8410214304681462906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 07/13/2012 08:44 AM, Guillaume Zajac wrote:
> Change log with previous version:
> 	- Fix naming issue
> 	- Simplify the logic
>
> Guillaume Zajac (3):
>    gprs-context: Add new driver entry
>    gprs-context: Add new driver entry definition
>    gprs: Release context in driver and core when network is lost
>
>   drivers/atmodem/gprs-context.c |   11 +++++
>   include/gprs-context.h         |    2 +
>   src/gprs.c                     |   84 ++++++++++++++++++++++++++++++---=
-------
>   3 files changed, 76 insertions(+), 21 deletions(-)
>

I went ahead and applied all three patches in this series.

Regards,
-Denis

--===============8410214304681462906==--

