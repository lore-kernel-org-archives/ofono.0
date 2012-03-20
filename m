Content-Type: multipart/mixed; boundary="===============0465942493692960656=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 03/12] call-forwarding: Refactor
 cf_condition_find_with_cls() slightly
Date: Tue, 20 Mar 2012 18:50:26 -0500
Message-ID: <4F6917C2.2050001@gmail.com>
In-Reply-To: <1331646393-5249-4-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0465942493692960656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 03/13/2012 08:46 AM, Oleg Zhurakivskyy wrote:
> Mainly to simplify the usage.
> ---
>  src/call-forwarding.c |   98 +++++++++++++------------------------------=
-----
>  1 files changed, 27 insertions(+), 71 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 8b6659a..5a2ab28 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -42,6 +42,8 @@
>  /* According to 27.007 Spec */
>  #define DEFAULT_NO_REPLY_TIMEOUT 20
>  =

> +#define CFC(_x) ((struct ofono_call_forwarding_condition *)(_x))
> +

I'm okay with such helpers, but...

>  #define is_cfu_enabled(_cf)				\
>  ({							\
>  	cf_find_unconditional(_cf) ? TRUE : FALSE;	\
> @@ -86,63 +88,36 @@ static void get_query_next_cf_cond(struct ofono_call_=
forwarding *cf);
>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
>  static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
>  =

> -static gint cf_condition_compare(gconstpointer a, gconstpointer b)
> +static gint cf_compare(gconstpointer a, gconstpointer b)
>  {
> -	const struct ofono_call_forwarding_condition *ca =3D a;
> -	const struct ofono_call_forwarding_condition *cb =3D b;
> -
> -	if (ca->cls < cb->cls)
> -		return -1;
> -
> -	if (ca->cls > cb->cls)
> -		return 1;
> -
> -	return 0;
> +	return CFC(a)->cls - CFC(b)->cls;

You're breaking const-correctness here.

Also, why do you rename the function?  I do think we should have
'condition' or at least 'cond' in the name to make it clear what it
does.  My vote is for cf_cond_compare...

>  }
>  =

> -static gint cf_condition_find_with_cls(gconstpointer a, gconstpointer b)
> +static struct ofono_call_forwarding_condition *cf_find(GSList *l, int cl=
s)

Same as above, at least name it cf_cond_find.  Also, I'd prefer changes
to this function to be in a separate patch.

>  {
> -	const struct ofono_call_forwarding_condition *c =3D a;
> -	int cls =3D GPOINTER_TO_INT(b);
> -
> -	if (c->cls < cls)
> -		return -1;
> -
> -	if (c->cls > cls)
> -		return 1;
> +	for (; l; l =3D l->next)
> +		if (cls =3D=3D CFC(l->data)->cls)
> +			return CFC(l->data);
>  =

> -	return 0;
> +	return NULL;
>  }
>  =

> -static int cf_find_timeout(GSList *cf_list, int cls)
> +static int cf_find_timeout(GSList *l, int cls)

Same here, lets name this cf_cond_find_timeout

>  {
> -	GSList *l;
> -	struct ofono_call_forwarding_condition *c;
> -
> -	l =3D g_slist_find_custom(cf_list, GINT_TO_POINTER(cls),
> -		cf_condition_find_with_cls);
> -
> -	if (l =3D=3D NULL)
> -		return DEFAULT_NO_REPLY_TIMEOUT;
> -
> -	c =3D l->data;
> +	struct ofono_call_forwarding_condition *c =3D cf_find(l, cls);
>  =

> -	return c->time;
> +	return c ? c->time : DEFAULT_NO_REPLY_TIMEOUT;
>  }
>  =

> -static void cf_cond_list_print(GSList *list)
> +static void cf_cond_list_print(GSList *l)
>  {
> -	GSList *l;
> -	struct ofono_call_forwarding_condition *cond;
> -
> -	for (l =3D list; l; l =3D l->next) {
> -		cond =3D l->data;
> +	struct ofono_call_forwarding_condition *c;
>  =

> +	for (; l && (c =3D l->data); l =3D l->next)

After going back and forth on this one, I'm actually against this style.
 Mainly it is too hard to notice the assignment, inside the continuation
check expression.  I'd really prefer that we assign c inside the for
loop block.  Also, l->data should never be NULL, so in this case I'd
rather crash and find out early than inadvertently covering it up.

>  		DBG("CF Condition status: %d, class: %d, number: %s,"
>  			" number_type: %d, time: %d",
> -			cond->status, cond->cls, cond->phone_number.number,
> -			cond->phone_number.type, cond->time);
> -	}
> +			c->status, c->cls, c->phone_number.number,
> +			c->phone_number.type, c->time);
>  }
>  =

>  static GSList *cf_cond_list_create(int total,
> @@ -175,8 +150,7 @@ static GSList *cf_cond_list_create(int total,
>  				sizeof(struct ofono_call_forwarding_condition));
>  			cond->cls =3D j;
>  =

> -			l =3D g_slist_insert_sorted(l, cond,
> -							cf_condition_compare);
> +			l =3D g_slist_insert_sorted(l, cond, cf_compare);
>  		}
>  	}
>  =

> @@ -330,12 +304,8 @@ static void set_new_cond_list(struct ofono_call_forw=
arding *cf,
>  		if (type =3D=3D CALL_FORWARDING_TYPE_NO_REPLY)
>  			snprintf(tattr, sizeof(tattr), "%sTimeout", attr);
>  =

> -		o =3D g_slist_find_custom(old, GINT_TO_POINTER(lc->cls),
> -					cf_condition_find_with_cls);
> -
> -		if (o) { /* On the old list, must be active */
> -			oc =3D o->data;
> -
> +		oc =3D cf_find(old, lc->cls);
> +		if (oc) { /* On the old list, must be active */
>  			if (oc->phone_number.type !=3D lc->phone_number.type ||
>  				strcmp(oc->phone_number.number,
>  					lc->phone_number.number)) {
> @@ -356,8 +326,8 @@ static void set_new_cond_list(struct ofono_call_forwa=
rding *cf,
>  						&timeout);
>  =

>  			/* Remove from the old list */
> -			g_free(o->data);
> -			old =3D g_slist_remove(old, o->data);
> +			old =3D g_slist_remove(old, oc);
> +			g_free(oc);
>  		} else {
>  			number =3D phone_number_to_string(&lc->phone_number);
>  =

> @@ -435,21 +405,12 @@ static void set_new_cond_list(struct ofono_call_for=
warding *cf,
>  			if (i =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
>  				continue;
>  =

> -			l =3D g_slist_find_custom(cf->cf_conditions[i],
> -					GINT_TO_POINTER(BEARER_CLASS_VOICE),
> -					cf_condition_find_with_cls);
> -
> -			if (l =3D=3D NULL)
> +			lc =3D cf_find(cf->cf_conditions[i], BEARER_CLASS_VOICE);
> +			if (lc =3D=3D NULL)
>  				continue;
>  =

> -			if (new_cfu)
> -				number =3D "";
> -			else {
> -				lc =3D l->data;
> -
> -				number =3D phone_number_to_string(
> +			number =3D new_cfu ? "" : phone_number_to_string(
>  							&lc->phone_number);

This part really belongs in a separate patch.

> -			}
>  =

>  			ofono_dbus_signal_property_changed(conn, path,
>  						OFONO_CALL_FORWARDING_INTERFACE,
> @@ -796,7 +757,6 @@ static DBusMessage *cf_set_property(DBusConnection *c=
onn, DBusMessage *msg,
>  =

>  	if (cf_condition_timeout_property(property, &cls)) {
>  		dbus_uint16_t timeout;
> -		GSList *l;
>  		struct ofono_call_forwarding_condition *c;
>  =

>  		type =3D CALL_FORWARDING_TYPE_NO_REPLY;
> @@ -809,15 +769,11 @@ static DBusMessage *cf_set_property(DBusConnection =
*conn, DBusMessage *msg,
>  		if (timeout < 1 || timeout > 30)
>  			return __ofono_error_invalid_format(msg);
>  =

> -		l =3D g_slist_find_custom(cf->cf_conditions[type],
> -					GINT_TO_POINTER(cls),
> -					cf_condition_find_with_cls);
>  =

> -		if (l =3D=3D NULL)
> +		c =3D cf_find(cf->cf_conditions[type], cls);
> +		if (c =3D=3D NULL)
>  			return __ofono_error_failed(msg);
>  =

> -		c =3D l->data;
> -
>  		return set_property_request(cf, msg, type, cls,
>  						&c->phone_number, timeout);
>  	} else if (cf_condition_enabled_property(cf, property, &type, &cls)) {

Regards,
-Denis

--===============0465942493692960656==--

