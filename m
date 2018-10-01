Content-Type: multipart/mixed; boundary="===============5239021128665482764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] coex: added agent for coex atom to provide bt and
 wifi data
Date: Mon, 01 Oct 2018 15:08:07 -0500
Message-ID: <088647e5-8a2d-c6e2-df38-6308effc75f0@gmail.com>
In-Reply-To: <1538390075-6342-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5239021128665482764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 10/01/2018 05:34 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Adding coexagent which implements coex agent interface to
> provide bt and wifi data
> ---
>   src/coexagent.c | 384 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/coexagent.h |  77 ++++++++++++

So this doesn't belong in the core since it is a vendor-specific API.

Is the plan to use this only on AT command based modems or also on RIL? =

If only on AT command ones, then I would put this in drivers/ifxmodem or =

drivers/xmm7modem.

Or perhaps we can come up with a new subdirectory for vendor-specific =

helper code. Like plugins/intel or common/intel.  Other ideas?

>   2 files changed, 461 insertions(+)
>   create mode 100644 src/coexagent.c
>   create mode 100644 src/coexagent.h
> =

> diff --git a/src/coexagent.c b/src/coexagent.c
> new file mode 100644
> index 0000000..7bdbef5
> --- /dev/null
> +++ b/src/coexagent.c
> @@ -0,0 +1,384 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.

Make sure to update Copyright dates properly.

Regards,
-Denis

--===============5239021128665482764==--

