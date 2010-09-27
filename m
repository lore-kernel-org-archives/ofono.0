Content-Type: multipart/mixed; boundary="===============5633922207498793187=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] ss: Use errno for ssc handling functions
Date: Sun, 26 Sep 2010 20:01:54 -0500
Message-ID: <4C9FED02.2040006@gmail.com>
In-Reply-To: <1285064479-12907-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5633922207498793187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +	if (__ofono_call_barring_is_busy(cb))
> +		return EBUSY;

Please use negative errno values, e.g. return -EBUSY, etc.

>  	if (strlen(sic) > 0)
> -		goto bad_format;
> +		return EINVAL;

here

>  =

>  	if (strlen(dn) > 0)
> -		goto bad_format;
> +		return EINVAL;

and here

>  =

>  	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
> -		goto bad_format;
> +		return EINVAL;
>  =


and here

> +	if (!operation)
> +		return ENOSYS;

And here, etc..

> diff --git a/src/ussd.c b/src/ussd.c
> index bbb9aed..6119573 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -205,32 +205,29 @@ static gboolean recognized_passwd_change_string(str=
uct ofono_ussd *ussd,
>  		break;
>  =

>  	default:
> -		return FALSE;
> +		return -ENOENT;
>  	}
>  =

>  	if (strcmp(sc, "03") || strlen(dn))
> -		return FALSE;
> +		return -ENOENT;
>  =

>  	/* If SIC & SID don't match, then we just bail out here */
> -	if (strcmp(sic, sid)) {
> -		DBusConnection *conn =3D ofono_dbus_get_connection();
> -		DBusMessage *reply =3D __ofono_error_invalid_format(msg);
> -		g_dbus_send_message(conn, reply);
> -		return TRUE;
> -	}
> +	if (strcmp(sic, sid))
> +		return EINVAL;
>  =

>  	while ((l =3D g_slist_find_custom(l, sia,
>  			ssc_entry_find_by_service)) !=3D NULL) {
>  		struct ssc_entry *entry =3D l->data;
>  		ofono_ussd_passwd_cb_t cb =3D entry->cb;
> +		int result =3D cb(sia, sib, sic, msg, entry->user);
>  =

> -		if (cb(sia, sib, sic, msg, entry->user))
> -			return TRUE;
> +		if (result >=3D 0)
> +			return result;

I suggest simply checking for -ENOENT here.

Regards,
-Denis

--===============5633922207498793187==--

