Content-Type: multipart/mixed; boundary="===============2791549357626440027=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv1 3/5] service: Fill conversation list with messages
Date: Fri, 27 Apr 2012 14:25:22 +0200
Message-ID: <1335529522.16897.470.camel@aeonflux>
In-Reply-To: <1335344513-2347-4-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2791549357626440027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

> ---
>  src/service.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 87 insertions(+), 1 deletions(-)
> =

> diff --git a/src/service.c b/src/service.c
> index 18c11f4..2787c3a 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -719,13 +719,85 @@ static gboolean get_conversation_get_args(DBusMessa=
ge *dbus_msg,
>  	return TRUE;
>  }
> =

> +static gboolean is_recipient(const char *recipients, const char *number)
> +{
> +	const char *rec, *num;
> +
> +	while (*recipients !=3D '\0') {
> +		rec =3D recipients;
> +		num =3D number;
> +
> +		while (*rec !=3D '\0' && *num !=3D '\0') {
> +			if (*rec =3D=3D *num) {
> +				rec++;
> +				num++;
> +			} else {
> +				if (*rec =3D=3D '-' || *rec =3D=3D '.') {
> +					rec++;
> +					continue;
> +				}
> +
> +				if (*num =3D=3D '-' || *num =3D=3D '.') {
> +					num++;
> +					continue;
> +				}
> +
> +				rec++;
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * Phone numbers in recipients end with /TYPE=3DPLMN, so the
> +		 * wanted number is found if the whole string number is found
> +		 * and if the matched phone number ends with the wanted number
> +		 * (i.e.: "/TYPE=3DPLMN" must follow).
> +		 */
> +		if (*num =3D=3D '\0' && *rec =3D=3D '/')
> +			return TRUE;
> +
> +		recipients =3D rec;
> +	}
> +
> +	return FALSE;
> +}

please explain what this function is actually doing? Adding a comment
seems like a good idea here.

Regards

Marcel



--===============2791549357626440027==--

