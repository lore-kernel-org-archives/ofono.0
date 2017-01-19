Content-Type: multipart/mixed; boundary="===============7459638953937390121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] drivers: Add gemaltomodem driver to handle GNSS
Date: Thu, 19 Jan 2017 13:36:23 -0600
Message-ID: <ab8b2538-eb8c-b28e-dd5b-6294f0d9afe0@gmail.com>
In-Reply-To: <1484739124-1117-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7459638953937390121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/18/2017 05:32 AM, Vincent Cesson wrote:
> Add a new location-reporting driver for Gemalto Cinterion modems based
> on telit implementation + use it in gemalto plugin. It supports
> activation of GNSS engine (Request) with command AT^SGPSC. This driver
> is tested on PHS8. NMEA frames are accessible on /dev/ttyUSB1.
> ---
>  Makefile.am                               |   6 +
>  drivers/gemaltomodem/gemaltomodem.c       |  49 ++++++
>  drivers/gemaltomodem/gemaltomodem.h       |  25 ++++
>  drivers/gemaltomodem/location-reporting.c | 237 ++++++++++++++++++++++++=
++++++
>  plugins/gemalto.c                         |   7 +-
>  5 files changed, 321 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gemaltomodem/gemaltomodem.c
>  create mode 100644 drivers/gemaltomodem/gemaltomodem.h
>  create mode 100644 drivers/gemaltomodem/location-reporting.c
>

Looks good to me. I split this into two commits, one for the drivers =

portion and one for the plugins/gemalto.c changes.

Applied, thanks!

Regards,
-Denis


--===============7459638953937390121==--

