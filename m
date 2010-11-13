Content-Type: multipart/mixed; boundary="===============2105585527430247652=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5b 2/3] stemodem: Create network interfaces statically
Date: Sat, 13 Nov 2010 10:32:22 +0900
Message-ID: <1289611942.3266.124.camel@aeonflux>
In-Reply-To: <1289574160-22899-3-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2105585527430247652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
> @@ -191,7 +189,7 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult =
*result,
>  	ofono_gprs_context_cb_t cb =3D cbd->cb;
>  	struct ofono_gprs_context *gc =3D cbd->user;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	struct conn_info *conn;
> +	struct conn_info *conn =3D NULL;
>  	GSList *l;

why do you need the conn =3D NULL assignment here? I haven't even looked
into your code flow, but I prefer clearly to not have these.

Regards

Marcel



--===============2105585527430247652==--

