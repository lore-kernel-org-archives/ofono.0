Content-Type: multipart/mixed; boundary="===============5567501092097695374=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: Re: [PATCH] watchlist: added macro for notifying with no args
Date: Tue, 14 Nov 2017 09:25:04 -0800
Message-ID: <a3549bc2-98f5-e403-67ae-36ecd4106f65@linux.intel.com>
In-Reply-To: <1510680276-1215-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5567501092097695374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry, did I not mean to send to this list.


On 11/14/2017 09:24 AM, James Prestwood wrote:
> The macros currently did not support notifying a watchlist with
> no extra arguments.
> ---
>   src/watchlist.h | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/src/watchlist.h b/src/watchlist.h
> index 737b80d..3d87810 100644
> --- a/src/watchlist.h
> +++ b/src/watchlist.h
> @@ -2,7 +2,7 @@
>    *
>    *  Wireless daemon for Linux
>    *
> - *  Copyright (C) 2016  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2016-2017  Intel Corporation. All rights reserved.
>    *
>    *  This library is free software; you can redistribute it and/or
>    *  modify it under the terms of the GNU Lesser General Public
> @@ -92,3 +92,19 @@ void __watchlist_prune_stale(struct watchlist *watchli=
st);
>   		if ((watchlist)->stale_items)				\
>   			__watchlist_prune_stale(watchlist);		\
>   	} while	(false)
> +
> +#define WATCHLIST_NOTIFY_NO_ARGS(watchlist, type)			\
> +	do {								\
> +		const struct l_queue_entry *entry =3D			\
> +				l_queue_get_entries((watchlist)->items);\
> +									\
> +		(watchlist)->in_notify =3D true;				\
> +		for (; entry; entry =3D entry->next) {			\
> +			struct watchlist_item *item =3D entry->data;	\
> +			type t =3D item->notify;				\
> +			t(item->notify_data);			\
> +		}							\
> +		(watchlist)->in_notify =3D false;				\
> +		if ((watchlist)->stale_items)				\
> +			__watchlist_prune_stale(watchlist);		\
> +	} while	(false)


--===============5567501092097695374==--

