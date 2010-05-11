Content-Type: multipart/mixed; boundary="===============8649309830879925551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/19] stkutil: Add setup menu proactive command parser
Date: Tue, 11 May 2010 14:21:26 -0500
Message-ID: <201005111421.27125.denkenz@gmail.com>
In-Reply-To: <1273487942-27213-11-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8649309830879925551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> @@ -281,8 +281,9 @@ static gboolean parse_dataobj_alpha_id(struct
>  comprehension_tlv_iter *iter, char *utf8;
> =

>  	len =3D comprehension_tlv_iter_get_length(iter);
> -	if (len < 1)
> -		return FALSE;
> +
> +	if (len =3D=3D 0)
> +		return TRUE;
> =

>  	data =3D comprehension_tlv_iter_get_data(iter);
>  	utf8 =3D sim_string_to_utf8(data, len);

There is no mention that the Alpha identifier can be present and empty, so =

returning TRUE on a len 0 is not actually correct.  The only exception so f=
ar =

seems to be text string which explicitly allows NULL strings.

> @@ -373,8 +374,10 @@ static gboolean parse_dataobj_item(struct
>  comprehension_tlv_iter *iter, char *utf8;
> =

>  	len =3D comprehension_tlv_iter_get_length(iter);
> -	if (len < 2)
> -		return FALSE;
> +
> +	if (len =3D=3D 0)
> +		return TRUE;
> +
> =


Same with this one...

>  	data =3D comprehension_tlv_iter_get_data(iter);
> =

> @@ -2006,6 +2009,7 @@ static gboolean parse_dataobj(struct
>  comprehension_tlv_iter *iter, GSList *l;
>  	va_list args;
>  	gboolean minimum_set =3D TRUE;
> +	GSList **list =3D NULL;
> =

>  	va_start(args, type);
> =

> @@ -2022,29 +2026,74 @@ static gboolean parse_dataobj(struct
>  comprehension_tlv_iter *iter, entries =3D g_slist_prepend(entries, entry=
);
>  	}
> =

> -
>  	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
>  		goto out;
> =

>  	entries =3D g_slist_reverse(entries);
> =

> -	for (l =3D entries; l; l =3D l->next) {
> +	for (l =3D entries; l;) {
>  		dataobj_handler handler;
>  		struct dataobj_handler_entry *entry =3D l->data;
> +		unsigned short tag;
> +		gboolean ret;
> +		void *dataobj;
> =

>  		handler =3D handler_for_type(entry->type);
> -		if (handler =3D=3D NULL)
> +		if (handler =3D=3D NULL) {
> +			l =3D l->next;
>  			continue;
> +		}
> =

> -		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
> -			if (handler(iter, entry->data))
> -				entry->parsed =3D TRUE;
> -			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
> -				break;
> +		tag =3D comprehension_tlv_iter_get_tag(iter);
> +		if (tag !=3D entry->type) {
> +			l =3D l->next;
> +			continue;
>  		}
> +
> +		if (tag =3D=3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE ||
> +			tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
> +
> +			if (tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM)
> +				dataobj =3D g_try_new0(struct stk_item, 1);
> +			else
> +				dataobj =3D g_try_new0(struct stk_file, 1);
> +
> +			if (!dataobj)
> +				goto out;
> +
> +			if (!list)
> +				list =3D entry->data;
> +
> +			ret =3D handler(iter, dataobj);
> +		} else
> +			ret =3D handler(iter, entry->data);
> +
> +		if (ret)
> +			entry->parsed =3D TRUE;
> +
> +		if (tag =3D=3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE ||
> +			tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
> +
> +			if (tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
> +				struct stk_item *item =3D dataobj;
> +				/* either return is FALSE or item is empty */
> +				if (item->id =3D=3D 0)
> +					g_free(item);
> +				else
> +					*list =3D g_slist_prepend(*list, item);
> +			} else
> +				*list =3D g_slist_prepend(*list, dataobj);
> +		} else
> +			l =3D l->next;
> +
> +		if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
> +			break;
>  	}
> =


I really don't like this.  I understand why you're doing it this way, but l=
ets =

try to make this more elegant.  Either add another FLAG saying that the ite=
ms =

are actually in a list, or parse the item list separately.

e.g. =


parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID,
			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
			&obj->alpha_id,
			STK_DATA_OBJECT_TYPE_ITEM,
			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM | DATAOBJ_FLAG_LIST,
			&obj->items, ...

or

/* Parse only until item list */
parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID,
			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
			&obj->alpha_id,
			STK_DATA_OBJECT_TYPE_ITEM,
			STK_DATA_OBJECT_TYPE_INVALID);

/* Manually parse item list */
...

/* Parse rest */
...

Regards,
-Denis

--===============8649309830879925551==--

