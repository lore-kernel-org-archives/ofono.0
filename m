Content-Type: multipart/mixed; boundary="===============5101116244924481898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/7] udevng/gobi: log which iface is missing to succeed
 detection
Date: Thu, 04 May 2017 12:48:38 -0500
Message-ID: <f13392ca-33d3-0c90-b136-5cc01c7a733c@gmail.com>
In-Reply-To: <20170501205256.4205-3-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5101116244924481898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/01/2017 03:52 PM, Alexander Couzens wrote:
> ---
>  plugins/udevng.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index e8b800c1..4d928d02 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -224,8 +224,15 @@ static gboolean setup_gobi(struct modem_info *modem)
>  		}
>  	}
>
> -	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
> +	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL) {
> +		if (!qmi)
> +			DBG("mandatory qmi interface missing");
> +		if (!mdm)
> +			DBG("mandatory mdm interface missing");
> +		if (!net)
> +			DBG("mandatory net interface missing");
>  		return FALSE;
> +	}

This is really not our style.  If this is really needed, lets just have =

separate if statements for each condition. e.g.

if (qmi =3D=3D NULL) {
	DBG(..);
	return FALSE;
}

if (...) {
...
}

Also, please combine this with patch 4 to avoid some churn.  gobi =

doesn't use Diag or Modem.  So we might as well just take that out for now.

>
>  	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps=
, diag);
>
>

Regards,
-Denis

--===============5101116244924481898==--

