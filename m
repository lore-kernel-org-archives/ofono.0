Content-Type: multipart/mixed; boundary="===============8707108366313069783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] ZTE: Create a modem driver to enable radio settings
Date: Mon, 26 Mar 2012 16:51:49 -0500
Message-ID: <4F70E4F5.1090708@gmail.com>
In-Reply-To: <1332500470-8297-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8707108366313069783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 03/23/2012 06:01 AM, Bertrand Aygon wrote:
>  - Create ZTE modem driver
>  - Add radio settings support to ZTE modem driver
>  - Enable radio settings in ZTE plugin =

> =

> Bertrand Aygon (3):
>   Add ZTE modem driver
>   ztemodem: Add radio settings support
>   zte: Add support for radio settings
> =

>  Makefile.am                       |    6 +
>  drivers/ztemodem/radio-settings.c |  212 +++++++++++++++++++++++++++++++=
++++++
>  drivers/ztemodem/ztemodem.c       |   49 +++++++++
>  drivers/ztemodem/ztemodem.h       |   25 +++++
>  plugins/zte.c                     |    3 +
>  5 files changed, 295 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ztemodem/radio-settings.c
>  create mode 100644 drivers/ztemodem/ztemodem.c
>  create mode 100644 drivers/ztemodem/ztemodem.h
> =


All three patches have been applied, thanks.

Regards,
-Denis

--===============8707108366313069783==--

