Content-Type: multipart/mixed; boundary="===============0661992627340146062=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] plugin: Interface for using plugins that find the MNC
 lenght from the IMSI
Date: Thu, 24 Oct 2013 11:37:37 -0500
Message-ID: <52694CD1.1000908@gmail.com>
In-Reply-To: <1382612560-29575-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0661992627340146062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/24/2013 06:02 AM, Alfonso Sanchez-Beato wrote:
> ---
>   include/sim-mnclength.h | 45 ++++++++++++++++++++++++++++++++++++++++++=
+++
>   1 file changed, 45 insertions(+)
>   create mode 100644 include/sim-mnclength.h
>
> diff --git a/include/sim-mnclength.h b/include/sim-mnclength.h
> new file mode 100644
> index 0000000..67769f2
> --- /dev/null
> +++ b/include/sim-mnclength.h
> @@ -0,0 +1,45 @@
> +/*
> + *
> + *  oFono - Open Telephony stack for Linux
> + *
> + *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).

Copy-pasting?

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
> +#ifndef OFONO_SIM_MNCLENGTH_H
> +#define OFONO_SIM_MNCLENGTH_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +
> +struct ofono_sim_mnclength_driver {
> +	const char *name;
> +	int (*get_mnclength)(const char *imsi);
> +};
> +
> +int ofono_sim_mnclength_driver_register(
> +			struct ofono_sim_mnclength_driver *driver);
> +void ofono_sim_mnclength_driver_unregister(
> +			const struct ofono_sim_mnclength_driver *driver);
> +

I'd actually like to keep this out of the core API for now.  Can you =

make this plugin a 'utility' plugin similar to plugins/mbpi.[ch]?

Feel free to extend provisioning API with a IMSI method for cases where =

EFad is not specifying the length.

> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* OFONO_SIM_MNCLENGTH_H */
>

Regards,
-Denis

--===============0661992627340146062==--

