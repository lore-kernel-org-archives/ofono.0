Content-Type: multipart/mixed; boundary="===============4425432424335804206=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/6] atmodem: create struct atmodem_gprs
Date: Fri, 30 Apr 2010 15:34:42 +0200
Message-ID: <1272634482.22838.193.camel@localhost.localdomain>
In-Reply-To: <20100430125458.30019.94365.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4425432424335804206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> This is need to to provide more chat channels to atmodem gprs module.
> ---
> =

>  drivers/atmodem/gprs.c |    7 ++++---
>  drivers/atmodem/gprs.h |   29 +++++++++++++++++++++++++++++
>  plugins/hso.c          |    8 +++++++-
>  plugins/mbm.c          |    7 ++++++-
>  plugins/palmpre.c      |    8 +++++++-
>  plugins/phonesim.c     |    7 ++++++-
>  plugins/ste.c          |    7 ++++++-
>  7 files changed, 65 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/atmodem/gprs.h

I don't really like this. You only need to catch the CGREG anyway so we
might just wanna add some indication method. Similar to what we have for
network registration with ofono_netreg_status_notify.

Then the messed up CGREG from Huawei modem doesn't dictate the whole
simple one GAtChat approach. It is really their fault with no sending
these on the proper AT command channel. No need to make other drivers
suffer.

Regards

Marcel



--===============4425432424335804206==--

