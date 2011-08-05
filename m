Content-Type: multipart/mixed; boundary="===============5079611374780231056=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 06/14] huaweicdmamodem: create a huawei cdma driver.
Date: Fri, 05 Aug 2011 10:54:04 -0500
Message-ID: <4E3C121C.6070705@gmail.com>
In-Reply-To: <1312550475-8537-7-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5079611374780231056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/05/2011 08:21 AM, Bertrand Aygon wrote:
> ---
>  Makefile.am                               |    5 +++
>  drivers/huaweicdmamodem/huaweicdmamodem.c |   42 +++++++++++++++++++++++=
++++++
>  drivers/huaweicdmamodem/huaweicdmamodem.h |   21 ++++++++++++++
>  3 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
>  create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
> =


Patch has been applied, however:

<snip>

> diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.h b/drivers/huaweicd=
mamodem/huaweicdmamodem.h
> new file mode 100644
> index 0000000..018747f
> --- /dev/null
> +++ b/drivers/huaweicdmamodem/huaweicdmamodem.h
> @@ -0,0 +1,21 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +

I had to take out this empty line otherwise git am complained.  This
causes git am of patches 7, 8, 11 to fail.  So please resubmit these.

Regards,
-Denis

--===============5079611374780231056==--

