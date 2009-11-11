Content-Type: multipart/mixed; boundary="===============3008163547228299120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Fix: Fill in the phone number info for outgoing call
Date: Wed, 11 Nov 2009 16:23:02 -0600
Message-ID: <200911111623.02579.denkenz@gmail.com>
In-Reply-To: <1257578131.2888.6.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3008163547228299120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> This is the latest version. Sorry for the noising from previous patches.
>
> There're two cases of outgoing call: dial from HF or dial from
> phone.
>
> In the first case, some phones may not support enhanced call status
> (AT+CLCC) to query outgoing number. So we need to pass struct
> atd_cb_data to fill in the number and type. Later, we invoke
> AT+CLCC to query phone number and overwrite ours if we are wrong.

This is actually not necessary.  The core already tracks the outgoing numbe=
r =

and fills it in if the dial returns before the new call is notified.  This =

should be always the case in HFP, since the ATD returns before CIEV is =

signaled, correct?

> +static GSList *parse_clcc(GAtResult *result)
> +{
> +	GAtResultIter iter;
> +	GSList *l =3D NULL;
> +	int id, dir, status, type;
> +	struct ofono_call *call;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CLCC:")) {
> +		const char *str =3D "";
> +		int number_type =3D 129;
> +
> +		if (!g_at_result_iter_next_number(&iter, &id))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &dir))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &status))
> +			continue;
> +
> +		if (!g_at_result_iter_next_number(&iter, &type))
> +			continue;
> +
> +		if (!g_at_result_iter_skip_next(&iter))
> +			continue;
> +
> +		if (g_at_result_iter_next_string(&iter, &str))
> +			g_at_result_iter_next_number(&iter, &number_type);
> +
> +		call =3D g_try_new0(struct ofono_call, 1);
> +
> +		if (!call)
> +			break;
> +
> +		call->id =3D id;
> +		call->direction =3D dir;
> +		call->status =3D status;
> +		call->type =3D type;
> +		strncpy(call->phone_number.number, str,
> +				OFONO_MAX_PHONE_NUMBER_LENGTH);
> +		call->phone_number.type =3D number_type;
> +
> +		if (strlen(call->phone_number.number) > 0)
> +			call->clip_validity =3D 0;
> +		else
> +			call->clip_validity =3D 2;
> +
> +		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
> +	}
> +
> +	return l;
> +}

If this function is a copy from atmodem, please put it into atutils instead=
 of =

duplicating it here.

> +	ofono_voicecall_notify(vc, call);
> +

As I mentioned above, you do not need to do this.  oFono will synthesize th=
e =

outgoing call properly.  Worst case we will send a PropertyChanged signal =

after CLCC is polled and the new number is obtained.

Also, there's actually two separate cases here.  Ideally I'd like them =

separated into two patches.

Regards,
-Denis

--===============3008163547228299120==--

