Content-Type: multipart/mixed; boundary="===============4531677334792514528=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 4/7] stemodem: Add Radio Settings to STE Modem
Date: Mon, 16 Aug 2010 16:05:24 +0200
Message-ID: <1281967524.23399.40.camel@localhost.localdomain>
In-Reply-To: <1281966848-14553-5-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4531677334792514528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Changes since last patch set:
> o Moved updates to plugins/ste to separate patch.
> o Updated error handling.
> o Style issues.
> =

> =

>  Makefile.am                       |    4 +-
>  drivers/stemodem/radio-settings.c |  223 +++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/stemodem.c       |    2 +
>  drivers/stemodem/stemodem.h       |    2 +
>  4 files changed, 230 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/stemodem/radio-settings.c

is this identical to how MBM does it? If yes, then I prefer we add this
to drivers/mbmmodem/ and you just reference it. If not then I like to
see the MBM version of this and where it actually differs. Maybe a MBM
version with a STE quirk is better.

I prefer doing this in MBM since that modem driver was just the first.
There is no other preference here ;)

Regards

Marcel



--===============4531677334792514528==--

