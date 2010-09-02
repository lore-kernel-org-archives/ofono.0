Content-Type: multipart/mixed; boundary="===============2633073489524927399=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] Fix adding 8bit reference number
Date: Thu, 02 Sep 2010 12:16:30 -0500
Message-ID: <4C7FDBEE.9010007@gmail.com>
In-Reply-To: <1283413663-30349-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2633073489524927399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> -		if (offset !=3D 0) {
> -			sms->submit.ud[offset] =3D (ref & 0xf0) >> 8;
> -			sms->submit.ud[offset+1] =3D (ref & 0x0f);
> -		}
> -
>  		sms_address_from_string(&sms->submit.daddr, to);
> +
> +		if (offset =3D=3D 0)
> +			continue;
> +
> +		if (use_16bit) {
> +			sms->submit.ud[offset] =3D ref & 0xf0 >> 8;

This doesn't look right at all, bitwise shift >> has higher precedence
than bitwise AND &.

> +			sms->submit.ud[offset+1] =3D ref & 0x0f;
> +		} else {
> +			sms->submit.ud[offset] =3D ref & 0x0f;
> +		}

Regards,
-Denis

--===============2633073489524927399==--

