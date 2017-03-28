Content-Type: multipart/mixed; boundary="===============4719068346051572847=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] atmodem: telit - re-attach gprs automatically
Date: Tue, 28 Mar 2017 12:04:25 -0500
Message-ID: <ccab4ccb-467c-9909-f18f-8be76691631b@gmail.com>
In-Reply-To: <1490701361-14182-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4719068346051572847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

> @@ -214,6 +240,10 @@ static void cgev_notify(GAtResult *result, gpointer =
user_data)
>
>  	if (g_str_equal(event, "NW DETACH") ||
>  			g_str_equal(event, "ME DETACH")) {
> +		if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
> +				gd->telit_try_reattach)
> +			return;
> +
>  		ofono_gprs_detached_notify(gprs);

I think you're missing setting gd->attached to FALSE here

>  		return;
>  	} else if (g_str_has_prefix(event, "ME PDN ACT")) {
>

Regards,
-Denis

--===============4719068346051572847==--

