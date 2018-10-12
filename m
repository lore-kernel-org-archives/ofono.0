Content-Type: multipart/mixed; boundary="===============6137038270696110851=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 2/5] lte.h: added proto and authentication handling
Date: Fri, 12 Oct 2018 09:44:21 +0200
Message-ID: <55123d63-6a43-7b4c-4fc2-34fce6e88346@southpole.se>
In-Reply-To: <20181012072749.7788-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137038270696110851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Pass --prefix=3D"PATCH v2" and --cover-letter options to git-format-patch =

in order to differentiate your patch submissions from each other.


On 12/10/18 09:27, Giacinto Cifelli wrote:
> Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>

Tags go after description, and you've already got this down below anyway.

>
> The ofono_lte_default_attach_info is extended with protocol,
> authentication method, username and password.
> The transmission of this info from the src to the atom happens
> through the existing set_default_attach_info.
> A signal is emitted when one of these properties changes
>
> Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
> ---
>   include/lte.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/lte.h b/include/lte.h
> index 0f2501c0..2f12ac29 100644
> --- a/include/lte.h
> +++ b/include/lte.h
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2016  Endocode AG. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M

I wouldn't add a copyright line for a trivial change like this...

>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -32,6 +33,10 @@ struct ofono_lte;
>   =

>   struct ofono_lte_default_attach_info {
>   	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> +	enum ofono_gprs_proto proto;
> +	enum ofono_gprs_auth_method auth_method;
> +	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> +	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
>   };
>   =

>   typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *d=
ata);

/Jonas

--===============6137038270696110851==--

