Content-Type: multipart/mixed; boundary="===============2843378788901394882=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/1] hfp: Add faked sim driver to support SIM ready
Date: Mon, 30 Aug 2010 16:33:49 -0300
Message-ID: <20100830193349.GB11191@vigoh>
In-Reply-To: <1283161817-22935-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2843378788901394882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

* Zhenhua Zhang <zhenhua.zhang@intel.com> [2010-08-30 17:50:17 +0800]:

> HFP modem doesn't have IMSI at all. In order to notify SIM ready to the
> core, we create a special sim driver with a faked IMSI number.
> ---
>  Makefile.am                 |    3 +-
>  drivers/hfpmodem/hfpmodem.c |    2 +
>  drivers/hfpmodem/hfpmodem.h |    3 +
>  drivers/hfpmodem/sim.c      |  114 +++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/hfp.c               |    6 ++
>  5 files changed, 127 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/hfpmodem/sim.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index f31180e..a1ec0e7 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -187,7 +187,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/hfpmodem/hfpmodem.c \
>  			drivers/hfpmodem/voicecall.c \
>  			drivers/hfpmodem/network-registration.c \
> -			drivers/hfpmodem/call-volume.c
> +			drivers/hfpmodem/call-volume.c \
> +			drivers/hfpmodem/sim.c
>  =

>  builtin_modules +=3D mbmmodem
>  builtin_sources +=3D drivers/atmodem/atutil.h \
> diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
> index 4471a7b..ecbabe3 100644
> --- a/drivers/hfpmodem/hfpmodem.c
> +++ b/drivers/hfpmodem/hfpmodem.c
> @@ -44,6 +44,7 @@ static int hfpmodem_init(void)
>  	hfp_voicecall_init();
>  	hfp_netreg_init();
>  	hfp_call_volume_init();
> +	hfp_sim_init();
>  =

>  	return 0;
>  }
> @@ -53,6 +54,7 @@ static void hfpmodem_exit(void)
>  	hfp_voicecall_exit();
>  	hfp_netreg_exit();
>  	hfp_call_volume_exit();
> +	hfp_sim_exit();
>  }
>  =

>  OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
> diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
> index bf5d563..631f773 100644
> --- a/drivers/hfpmodem/hfpmodem.h
> +++ b/drivers/hfpmodem/hfpmodem.h
> @@ -80,3 +80,6 @@ extern void hfp_call_volume_exit();
>  =

>  extern void hfp_voicecall_init();
>  extern void hfp_voicecall_exit();
> +
> +extern void hfp_sim_init();
> +extern void hfp_sim_exit();
> diff --git a/drivers/hfpmodem/sim.c b/drivers/hfpmodem/sim.c
> new file mode 100644
> index 0000000..e42cfb9
> --- /dev/null
> +++ b/drivers/hfpmodem/sim.c
> @@ -0,0 +1,114 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/sim.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +#include "hfpmodem.h"
> +
> +static void hfp_read_imsi(struct ofono_sim *sim, ofono_sim_imsi_cb_t cb,
> +			void *data)
> +{
> +	struct ofono_error error;
> +	const char *imsi =3D "1234567890123456";
> +
> +	DBG("%s", imsi);
> +
> +	/*
> +	 * Return the faked IMSI since HFP doesn't have IMSI.
> +	 */
> +	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +	cb(&error, imsi, data);
> +}
> +
> +static void hfp_sim_read_binary(struct ofono_sim *sim, int fileid,
> +					int start, int length,
> +					ofono_sim_read_cb_t cb, void *data)
> +{
> +	DBG("");
> +
> +	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
> +}
> +
> +static void hfp_sim_read_info(struct ofono_sim *sim, int fileid,
> +					ofono_sim_file_info_cb_t cb,
> +					void *data)
> +{
> +	DBG("");
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
> +}
> +
> +static int hfp_sim_probe(struct ofono_sim *sim, unsigned int vendor,
> +				void *data)
> +{
> +	ofono_sim_register(sim);
> +
> +	return 0;
> +}
> +
> +static void hfp_sim_remove(struct ofono_sim *sim)
> +{
> +}
> +
> +static struct ofono_sim_driver driver =3D {
> +	.name			=3D "hfpmodem",
> +	.probe			=3D hfp_sim_probe,
> +	.remove			=3D hfp_sim_remove,
> +	.read_file_info		=3D hfp_sim_read_info,
> +	.read_file_transparent	=3D hfp_sim_read_binary,
> +	.read_file_linear	=3D NULL,
> +	.read_file_cyclic	=3D NULL,
> +	.write_file_transparent	=3D NULL,
> +	.write_file_linear	=3D NULL,
> +	.write_file_cyclic	=3D NULL,
> +	.read_imsi		=3D hfp_read_imsi,
> +	.query_passwd_state	=3D NULL,
> +	.send_passwd		=3D NULL,
> +	.reset_passwd		=3D NULL,
> +	.lock			=3D NULL,
> +	.change_passwd		=3D NULL,
> +	.query_locked		=3D NULL,

You don't need to add the NULL funcions here.

-- =

Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

--===============2843378788901394882==--

