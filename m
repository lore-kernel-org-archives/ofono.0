Content-Type: multipart/mixed; boundary="===============8192606134354086064=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 1/7] plugins/ste: Include STK support from MBM driver.
Date: Mon, 16 Aug 2010 23:58:32 +0200
Message-ID: <1281995912.23399.44.camel@localhost.localdomain>
In-Reply-To: <1281993134-3926-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8192606134354086064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >>> ... The build system builds the plugins
> >>> properly and you can cross reference modem drivers from your modem
> >>> plugin without any problems.
> >>
> >>Simply refering to MBM driver from ste.c
> >>
> >one minor nitpick here. Can you please not squeeze this in between GPRS
> >and GPRS Context atoms. Put it at the same location the MBM plugin does.
> =

> Fixed.

patch has been applied. Thanks.

Regards

Marcel



--===============8192606134354086064==--

