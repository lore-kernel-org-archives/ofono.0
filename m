Content-Type: multipart/mixed; boundary="===============4288837111302626847=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 09/20] modem: add preferred ue mode handling
Date: Mon, 11 Apr 2011 14:36:03 -0500
Message-ID: <4DA35823.7070803@gmail.com>
In-Reply-To: <1302517218-2147-10-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4288837111302626847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

> +static const char *preferred_ue_mode_to_string(int mode)
> +{
> +	switch (mode) {
> +	case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
> +		return "PS mode 2";
> +	case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> +		return "PS/CS mode 1";
> +	case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> +		return "PS/CS mode 2";
> +	case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> +		return "PS mode 1";
> +	}
> +
> +	return "unknown";
> +}
> +

These values are really not telling anyone anything.  How do you
envision the upper layers using this information?

Regards,
-Denis

--===============4288837111302626847==--

