Content-Type: multipart/mixed; boundary="===============1027482306945162649=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] qmimodem: change kernel driver data format if needed
Date: Thu, 19 Jan 2017 14:20:25 -0600
Message-ID: <fedb3b69-5ed7-cf35-41cb-ce29ad03cd59@gmail.com>
In-Reply-To: <20170119081518.16765-3-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1027482306945162649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 01/19/2017 02:15 AM, Christophe Ronco wrote:
> During gprs-context driver probe function, check kernel device driver
> data format and modem low level data format.
> If they are different, align kernel device driver data format on
> modem low level data format.
> If an error occurs during this process, continue probing without error.
> This is inspired by what is done in qmicli and qmi-network (package
> libqmi).
> ---
>  drivers/qmimodem/gprs-context.c | 79 +++++++++++++++++++++++++++++++++++=
++++--
>  drivers/qmimodem/qmi.h          |  1 +
>  drivers/qmimodem/wda.h          | 25 +++++++++++++
>  3 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/qmimodem/wda.h
>

This looks fine to me.  You do need to add wda.h to the build in =

Makefile.am and also update the Copyright in that file accordingly.

Regards,
-Denis


--===============1027482306945162649==--

