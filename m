Content-Type: multipart/mixed; boundary="===============7739771689747173798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 4/5] ifxmodem: Add support for tty call notifications
Date: Wed, 12 Jan 2011 23:23:03 -0600
Message-ID: <4D2E8C37.60001@gmail.com>
In-Reply-To: <1294668092-27896-5-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7739771689747173798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> +static void ctm_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GSList *l;
> +	struct ofono_call *call;
> +
> +	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(0),
> +				at_util_call_compare_by_status);

So here we find the first call in the active state.  This is not
necessarily guaranteed to be the only active call.  Ideally this
notification should also provide the call id.

So the question is, is this safe enough and not subject to race conditions?

> +	if (l =3D=3D NULL) {
> +		ofono_error("CTM for unknown call");
> +		return;
> +	}
> +
> +	call =3D l->data;
> +
> +	ofono_voicecall_tty_notify(vc, call);
> +}
> +

Regards,
-Denis

--===============7739771689747173798==--

