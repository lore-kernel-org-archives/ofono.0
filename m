Content-Type: multipart/mixed; boundary="===============1980154617781796923=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/2] hfpmodem: Retry AT+CLCC request after outgoing
 callsetup
Date: Wed, 30 Jan 2013 21:50:51 -0600
Message-ID: <5109EA1B.1010407@gmail.com>
In-Reply-To: <07c8015b845d8b1a310dc9f33397cda7dd42e4a2.1359360111.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1980154617781796923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

<snip>

> +static void clcc_poll_dialing_cb(gboolean ok, GAtResult *result,
> +			gpointer user_data)
> +{
> +	struct ofono_voicecall *vc =3D user_data;
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	GSList *calls, *dialing;
> +
> +	if (!ok)
> +		return;
> +
> +	calls =3D at_util_parse_clcc(result);
> +	dialing =3D find_dialing(calls);
> +
> +	if (dialing =3D=3D NULL) {
> +		if (vd->clcc_source)
> +			g_source_remove(vd->clcc_source);
> +
> +		vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
> +												poll_clcc, vc);
> +		return;
> +	}
> +
> +	clcc_poll_cb(ok, result, user_data);

I'm not entirely happy that we parse the CLCC list twice here, once in =

this function and once in the clcc_poll_cb.  Would setting a flag in =

ciev_callsetup_notify and checking it in clcc_poll_cb be a better idea?

e.g.
if (num_active > 1 || num_held > 1)
	vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc,
                                                         vc);

would go into something like:

poll_again =3D num_active > 1 || num_held > 1;
if (vd->flags & FLAG_NOKIA_N9_BROKEN_DIAL) {
	poll_again =3D TRUE;
	vd->flags &=3D FLAG_NOKIA_N9_BROKEN_DIAL;
}

if (poll_again)
	....

Regards,
-Denis

--===============1980154617781796923==--

