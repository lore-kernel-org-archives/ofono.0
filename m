Content-Type: multipart/mixed; boundary="===============8884729629477911778=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/4] Add a driver for u-blox modems
Date: Tue, 08 Jul 2014 08:59:14 -0500
Message-ID: <53BBF932.7000800@gmail.com>
In-Reply-To: <1404383526-12790-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8884729629477911778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 07/03/2014 05:32 AM, Philip Paeps wrote:
> Changes since v2:
> =

>  o Rebased on master 6df64cd
>  o Used none_prefix consistently
> =

> =

> Philip Paeps (4):
>   udevng: add detection logic for u-blox modems
>   plugins: new driver for u-blox SARA-U270 modems
>   sim: query u-blox PIN retries with AT+UPINCNT
>   atmodem: set the auth method for u-blox modems
> =

>  Makefile.am                    |    3 +
>  drivers/atmodem/gprs-context.c |   31 ++++-
>  drivers/atmodem/sim.c          |   45 ++++++
>  plugins/ublox.c                |  293 ++++++++++++++++++++++++++++++++++=
++++++
>  plugins/udevng.c               |   42 ++++++
>  5 files changed, 411 insertions(+), 3 deletions(-)
>  create mode 100644 plugins/ublox.c
> =


I went ahead an applied all patches in this series with a small fix
afterward.

Regards,
-Denis

--===============8884729629477911778==--

