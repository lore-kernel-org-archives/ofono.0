Content-Type: multipart/mixed; boundary="===============8793066398694997911=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v0 3/3] huaweicdma: Delete unused plugin
Date: Fri, 06 Jan 2012 13:51:37 -0800
Message-ID: <1325886697.6454.100.camel@aeonflux>
In-Reply-To: <1325863718-19357-4-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8793066398694997911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  Makefile.am          |    3 -
>  plugins/huaweicdma.c |  247 --------------------------------------------=
------
>  2 files changed, 0 insertions(+), 250 deletions(-)
>  delete mode 100644 plugins/huaweicdma.c

so I applied this patch as well. Just to get it out of way.

Since we merged huaweicdma into huawei modem plugin, we should also get
rid of drivers/huaweicdmamodem/ as well.

Lets move drivers/huaweicdmamodem/network-registration.c into
drivers/huaweimodem/cdma-netreg.c.

Regards

Marcel



--===============8793066398694997911==--

