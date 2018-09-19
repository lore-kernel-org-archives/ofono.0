Content-Type: multipart/mixed; boundary="===============2316399302372341450=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 11:35:24 +0300
Message-ID: <ff5bb1b4-7b9a-2b9a-c407-8097724781b0@jolla.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2316399302372341450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/09/18 08:37, Giacinto Cifelli wrote:
> ---
>   include/gprs-context.h |  1 +
>   include/lte.h          | 11 +++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index 20ca9ef..8869c12 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -57,6 +57,7 @@ enum ofono_gprs_context_type {
>   enum ofono_gprs_auth_method {
>   	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
>   	OFONO_GPRS_AUTH_METHOD_PAP,
> +	OFONO_GPRS_AUTH_METHOD_NONE,

I think there should be OFONO_GPRS_AUTH_METHOD_ANY (or =

OFONO_GPRS_AUTH_METHOD_PAP_CHAP) here as well, for completeness. Many =

modems support that too (and we had to add it in our fork).


>   };
>   =

>   struct ofono_gprs_primary_context {
> diff --git a/include/lte.h b/include/lte.h
> index ef84ab9..38587c3 100644
> --- a/include/lte.h
> +++ b/include/lte.h
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2016  Endocode AG. All rights reserved.
> + *  Copyright (C) 2018 Gemalto M2M
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -28,14 +29,18 @@ extern "C" {
>   =

>   #include <ofono/types.h>
>   =

> -struct ofono_lte;
> -
>   struct ofono_lte_default_attach_info {
>   	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> +	enum ofono_gprs_proto proto;
> +	enum ofono_gprs_auth_method auth_method;
> +	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> +	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
>   };

This is starting to look suspiciously similar to struct =

ofono_gprs_primary_context (the only thing left is cid). Is it really =

necessary to maintain two copies of essentially the same structure or is =

there some room for unification here?

Cheers,
-Slava

--===============2316399302372341450==--

