Content-Type: multipart/mixed; boundary="===============2771491145105125133=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 3/5] voicecall: implement SSN handling functions
Date: Fri, 11 Mar 2011 13:54:05 -0600
Message-ID: <4D7A7DDD.5000703@gmail.com>
In-Reply-To: <56722c85908a3516f0d5936cbef7b7e14c33efbd.1299258404.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2771491145105125133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> +static struct voicecall *voicecall_select(struct ofono_voicecall *vc,
> +						unsigned int id, int code)
> +{
> +	struct voicecall *v =3D NULL;
> +	GSList *l;
> +
> +	if (id !=3D 0) {
> +		l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(id),
> +				call_compare_by_id);
> +
> +		if (l =3D=3D NULL)
> +			return NULL;
> +
> +		v =3D l->data;
> +	} else if (g_slist_length(vc->call_list) =3D=3D 1) {
> +		v =3D vc->call_list->data;
> +
> +		switch (code) {
> +		case SS_MT_VOICECALL_RETRIEVED:
> +			if (v->remote_held !=3D TRUE)
> +				return NULL;
> +			break;
> +		case SS_MT_VOICECALL_ON_HOLD:
> +			if (v->remote_held =3D=3D TRUE)
> +				return NULL;
> +			break;
> +		case SS_MT_MULTIPARTY_VOICECALL:
> +			if (v->remote_multiparty =3D=3D TRUE)
> +				return NULL;
> +			break;
> +		default:
> +			return NULL;
> +		}

I was mostly fine with this patch, but didn't see the real need in these
checks, so I re-factored the patch slightly afterward.  Let me know if I
broke something.

> +	}
> +
> +	return v;
> +}
> +

Regards,
-Denis

--===============2771491145105125133==--

