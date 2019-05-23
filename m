Content-Type: multipart/mixed; boundary="===============5606958445758334433=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] qmimodem: support wake on SMS receive
Date: Thu, 23 May 2019 15:30:37 +0200
Message-ID: <20190523133037.GA15765@amd>
In-Reply-To: <33895343.1315.1558616914012@wamui-dingo.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5606958445758334433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> Some modems, like Quectel EC25, support waking the host platform from a s=
uspend state upon an SMS reception. Current SMS handling configures the mod=
em to not save incoming messages. On platforms where the modem's interfaces=
 (eg, cdc-wdm, wwan, etc) disconnect on suspend and reconnect on resume, oF=
ono will re-initialize. This can cause lost messages upon resume because th=
e QMI indication is sent before oFono is ready.
> =

> Changes to support suspend/resume with wake on SMS:
> - On startup:
>   1. Configure modem to save messages to NV and notify for class NONE.
>   2. Delete all processed messages in modem memory to free space.
>   3. Get list of unread messages, then get and delete each.
> - After startup:
>   1. Process message upon event indication and delete.
>   2. Then check for possibly more messages to process.
> ---
>  drivers/qmimodem/sms.c | 344 +++++++++++++++++++++++++++++++++++++++++--=
------
>  drivers/qmimodem/wms.h |  77 ++++++++---
>  2 files changed, 348 insertions(+), 73 deletions(-)
> =


> +static void delete_msg(struct ofono_sms *sms, uint8_t tag) {
> +	struct sms_data *data =3D ofono_sms_get_data(sms);
> +	struct qmi_param *param;
> +	qmi_result_func_t func =3D NULL;
> +
> +	DBG("");
> +
> +	param =3D qmi_param_new();
> +	if (param =3D=3D NULL)
> +		goto done;
> +
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_STORE,
> +				QMI_WMS_STORAGE_TYPE_NV);
> +
> +	if (tag =3D=3D QMI_WMS_MT_UNDEFINE) {
> +		DBG("delete read msg type %d ndx %d", data->rd_msg_id.type,
> +			data->rd_msg_id.ndx);
> +
> +		/* delete 1 msg */
> +		qmi_param_append_uint32(param, QMI_WMS_PARAM_DEL_NDX,
> +					data->rd_msg_id.ndx);
> +		func =3D delete_msg_cb;
> +	} else {
> +		DBG("delete msg tag %d mode %d", tag, data->msg_mode);
> +
> +		/* delete all msgs from 1 tag type */
> +		qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_TYPE, tag);
> +	}
> +
> +	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_MODE, data->msg_mode);
> +
> +	if (qmi_service_send(data->wms, QMI_WMS_DELETE, param,
> +			func, sms, NULL) > 0)
>  		return;
> +
> +	qmi_param_free(param);
> +
> +done:
> +	return;
> +}

Explicit "return" at the end of void function looks quite strange to
me. goto jumping to it even more so... =

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5606958445758334433==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsem1vSDBBQ2drUU1PZndhcFhiK3ZLVWFRQ2d1T1Y5QllqeTFYUFhLRWRlK2UyYzlDYXgK
S2FVQW5qRWVzbUtXd2ttOU5BNGtyakg1VHBQRWVKdEwKPWJTVHMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5606958445758334433==--

