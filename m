Content-Type: multipart/mixed; boundary="===============7615980899217606983=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] ISI modem version detection with plugin
Date: Mon, 31 Jan 2011 14:32:16 +0100
Message-ID: <1296480736.1520.215.camel@aeonflux>
In-Reply-To: <1296479491-29491-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7615980899217606983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

>  Makefile.am                |    4 +
>  drivers/isimodem/debug.c   |   39 ++++
>  drivers/isimodem/debug.h   |    4 +
>  drivers/isimodem/mtc.h     |   38 ++++
>  drivers/isimodem/version.h |   26 +++
>  plugins/ofono.rules        |    3 +
>  plugins/u8500.c            |  477 ++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/udev.c             |    5 +-
>  8 files changed, 595 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/isimodem/version.h
>  create mode 100644 plugins/u8500.c

you do need to split this. At least one for isimodem, one for udev
changes and one for the u8500 plugin.

Regards

Marcel



--===============7615980899217606983==--

