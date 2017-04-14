Content-Type: multipart/mixed; boundary="===============4281644835187385830=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH QMI LTE v2 01/13] qmi: duplicate callback data correctly
Date: Fri, 14 Apr 2017 16:49:14 -0500
Message-ID: <23b001af-27f4-547c-6386-0b67af8f6c91@gmail.com>
In-Reply-To: <20170414213646.32066-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4281644835187385830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/14/2017 04:36 PM, Jonas Bonn wrote:
> ---
>  drivers/qmimodem/gprs-context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-cont=
ext.c
> index a1ee217..247ee9e 100644
> --- a/drivers/qmimodem/gprs-context.c
> +++ b/drivers/qmimodem/gprs-context.c
> @@ -198,7 +198,7 @@ static void start_net_cb(struct qmi_result *result, v=
oid *user_data)
>  	data->pkt_handle =3D handle;
>
>  	/* Duplicate cbd, the old one will be freed when this method returns */
> -	cbd =3D cb_data_new(cb, user_data);
> +	cbd =3D cb_data_new(cb, cbd->data);

Ah darn, my fault for not double-checking my earlier fix. Thanks for =

catching this.

>  	cbd->user =3D gc;
>
>  	if (qmi_service_send(data->wds, QMI_WDS_GET_SETTINGS, NULL,
>

Applied, thanks.

Regards,
-Denis

--===============4281644835187385830==--

