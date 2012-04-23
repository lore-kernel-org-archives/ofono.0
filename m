Content-Type: multipart/mixed; boundary="===============2899220216490059417=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 02/13] call-forwarding: Refactor
 cf_condition_find_with_cls()
Date: Mon, 23 Apr 2012 15:42:52 -0500
Message-ID: <4F95BECC.5090702@gmail.com>
In-Reply-To: <1334060254-29547-3-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2899220216490059417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

Patch has been applied, however see comments below:

<snip>

> +static struct ofono_call_forwarding_condition *cf_cond_find(GSList *l, i=
nt cls)
>  {
> -	const struct ofono_call_forwarding_condition *c =3D a;
> -	int cls =3D GPOINTER_TO_INT(b);
> +	for (; l; l =3D l->next)
> +		if (((struct ofono_call_forwarding_condition *)
> +				(l->data))->cls =3D=3D cls)

I don't really find all this casting more readable, so I changed this
back to more or less the old way of assigning an
ofono_call_forwarding_condition variable first.  The parentheses make my
head hurt, so lets avoid such constructs in the future.

<snip>

>  			if (new_cfu)
>  				number =3D "";
>  			else {
> -				lc =3D l->data;
> -
> -				number =3D phone_number_to_string(

Something went wrong with your merge here, so I had to fix this manually
and amend your patch.

>  							&lc->phone_number);
>  			}
>  =


Regards,
-Denis

--===============2899220216490059417==--

