Content-Type: multipart/mixed; boundary="===============7370013908350749636=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 6/7] stemodem: Use RTNL for creating CAIF interface
Date: Tue, 17 Aug 2010 00:11:00 +0200
Message-ID: <1281996660.23399.55.camel@localhost.localdomain>
In-Reply-To: <1281993134-3926-6-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7370013908350749636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> CAIF in Linux kernel 2.6.35 must use RTNL for configuring
> CAIF interfaces.
> ---
>  drivers/stemodem/gprs-context.c |   51 +++++--
>  drivers/stemodem/rtnl.c         |  318 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/rtnl.h         |   24 +++
>  3 files changed, 380 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/stemodem/rtnl.c
>  create mode 100644 drivers/stemodem/rtnl.h

I can't really let you do make blocking reads to the netlink socket.
That would be pretty much a bad idea.

We need a better solution for this. Maybe one that also helps the ISI
modem drivers.

Regards

Marcel



--===============7370013908350749636==--

