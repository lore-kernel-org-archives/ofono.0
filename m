Content-Type: multipart/mixed; boundary="===============1294795657177557908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: add +VTS support for HFP emulator
Date: Thu, 19 May 2011 11:42:29 -0500
Message-ID: <4DD54875.1010100@gmail.com>
In-Reply-To: <1305540829-14417-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1294795657177557908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

> +static void emulator_vts_cb(struct ofono_emulator *em,
> +			struct ofono_emulator_request *req, void *userdata)
> +{
> +	struct ofono_voicecall *vc =3D userdata;
> +	struct ofono_error result;
> +	const char *str;
> +
> +	switch (ofono_emulator_request_get_type(req)) {
> +	case OFONO_EMULATOR_REQUEST_TYPE_SET:
> +		str =3D ofono_emulator_request_get_raw(req);
> +
> +		if (__ofono_voicecall_tone_send(vc, str, vts_tone_cb, em) < 0)
> +			break;

This looks wrong.  The VTS command takes a single ascii character, not a
string.  So you need to validate that.  +VTS also does not accept P/p
characters, so you need to make sure to filter these out as well.

> +
> +		return;
> +
> +	default:
> +		break;
> +	}
> +

I'd do this like this:

if (__tone_send() =3D=3D 0)
	return;

> +	result.error =3D 0;
> +	result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +
> +	ofono_emulator_send_final(em, &result);
> +}
> +

Regards,
-Denis

--===============1294795657177557908==--

