Content-Type: multipart/mixed; boundary="===============3933152336025097159=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/10] ublox: network-registration atom
Date: Fri, 19 Jul 2019 01:40:08 -0500
Message-ID: <8d0dc895-9b6b-87fd-777f-aa378fec54c3@gmail.com>
In-Reply-To: <20190718102314.28094-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3933152336025097159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 7/18/19 5:23 AM, Jonas Bonn wrote:
> For uBlox modems, a bit of custom setup is required, but after that the
> generic "atmodem" (27.007-compatible) method implementations are
> sufficient.  This driver, therefore, just puts the custom probe method
> into place and defers remaining functionality to the recently exported
> atmodem implementations.
> ---
>   drivers/ubloxmodem/network-registration.c | 425 ++++++++++++++++++++++
>   drivers/ubloxmodem/ubloxmodem.c           |   2 +
>   drivers/ubloxmodem/ubloxmodem.h           |   3 +
>   3 files changed, 430 insertions(+)
>   create mode 100644 drivers/ubloxmodem/network-registration.c
> =


Also, please squash patch 4 into this one.

> diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmod=
em/network-registration.c
> new file mode 100644
> index 00000000..cfd194a9
> --- /dev/null
> +++ b/drivers/ubloxmodem/network-registration.c
> @@ -0,0 +1,425 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2010  ST-Ericsson AB.

Do you want to maybe update the copyrights for this new file?

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

Regards,
-Denis

--===============3933152336025097159==--

