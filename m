Content-Type: multipart/mixed; boundary="===============7915183218160486330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] qmimodem: return all serial numbers
Date: Tue, 16 Apr 2019 11:52:34 -0500
Message-ID: <fcdbb935-1806-2e5c-fe5a-d1dfc8f38d65@gmail.com>
In-Reply-To: <2097825122.6387.1555084361605@wamui-cinderella.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7915183218160486330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 04/12/2019 10:52 AM, Tom Nguyen wrote:
> Some modems, eg. Quectel EC25E, return the ESN, IMEI, and MEID even
> though they support only one network type in a region. Current serial
> number query gives precedence to the ESN if it exists, and does not
> consider the IMEI and MEID.
> =

> Add a check of the supported radio interfaces in deciding which
> serial number to return. If radio interfaces are 3GPP based, then
> return the IMEI, else return the ESN. If neither exist, return MEID
> if available, else fail.
> ---
>   drivers/qmimodem/devinfo.c | 88 +++++++++++++++++++++++++++++++++++++++=
-------
>   1 file changed, 75 insertions(+), 13 deletions(-)
> =


Applied with a minor tweak:

> @@ -150,6 +164,8 @@ static void qmi_query_serial(struct ofono_devinfo *de=
vinfo,
>   =

>   	DBG("");
>   =

> +	cbd->user =3D (void *) devinfo;
> +

cbd->user is void, so the explicit cast isn't necessary.

>   	if (qmi_service_send(data->dms, QMI_DMS_GET_IDS, NULL,
>   					get_ids_cb, cbd, g_free) > 0)
>   		return;

Regards,
-Denis

--===============7915183218160486330==--

