Content-Type: multipart/mixed; boundary="===============1832921247883223548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] qmi/discovery: sync the qmi state with the modem
Date: Thu, 07 Sep 2017 16:40:21 -0500
Message-ID: <21c21a32-9f36-8a9a-f0c3-c43fa736f1a6@gmail.com>
In-Reply-To: <20170907192306.18117-3-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1832921247883223548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 02:23 PM, Alexander Couzens wrote:
> The qmi sync call release all previous resources.
> Only call sync when the CTL service is >=3D 1.5
> ---
>   drivers/qmimodem/qmi.c | 47 +++++++++++++++++++++++++++++++++++++++++++=
++++
>   drivers/qmimodem/qmi.h |  5 ++++-
>   plugins/gobi.c         | 24 ++++++++++++++++++++++--
>   3 files changed, 73 insertions(+), 3 deletions(-)
> =


Please see HACKING, Submitting Patches section

> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 7ea22992f8f0..fedfb9666c08 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -1317,6 +1317,53 @@ bool qmi_device_shutdown(struct qmi_device *device=
, qmi_shutdown_func_t func,
>   	return true;
>   }
>   =

> +struct sync_data {
> +	qmi_sync_func_t func;
> +	void *user_data;
> +};
> +
> +static void qmi_device_sync_callback(uint16_t message, uint16_t length,
> +				     const void *buffer, void *user_data)
> +{
> +	struct sync_data *data =3D user_data;
> +
> +	if (data->func)
> +		data->func(data->user_data);
> +
> +	g_free(data);
> +}
> +
> +/* sync will release all previous clients */
> +bool qmi_device_sync(struct qmi_device *device,
> +		     qmi_sync_func_t func, void *user_data)
> +{
> +	struct qmi_request *req;
> +	struct qmi_control_hdr *hdr;
> +	struct sync_data *func_data;
> +
> +	if (!device)
> +		return false;
> +
> +	func_data =3D g_new0(struct sync_data, 1);
> +	func_data->func =3D func;
> +	func_data->user_data =3D user_data;
> +
> +	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
> +			QMI_CTL_SYNC, QMI_CONTROL_HDR_SIZE,
> +			NULL, 0,
> +			qmi_device_sync_callback, func_data, (void **) &hdr);
> +
> +	if (device->next_control_tid < 1)
> +		device->next_control_tid =3D 1;
> +
> +	hdr->type =3D 0x00;
> +	hdr->transaction =3D device->next_control_tid++;
> +
> +	__request_submit(device, req, hdr->transaction);
> +
> +	return true;
> +}
> +
>   static bool get_device_file_name(struct qmi_device *device,
>   					char *file_name, int size)
>   {
> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
> index b4955b40b1fb..8a348876edb9 100644
> --- a/drivers/qmimodem/qmi.h
> +++ b/drivers/qmimodem/qmi.h
> @@ -76,7 +76,7 @@ typedef void (*qmi_destroy_func_t)(void *user_data);
>   struct qmi_device;
>   =

>   typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
> -
> +typedef void (*qmi_sync_func_t)(void *user_data);
>   typedef void (*qmi_shutdown_func_t)(void *user_data);
>   typedef void (*qmi_discover_func_t)(uint8_t count,
>   			const struct qmi_version *list, void *user_data);
> @@ -96,6 +96,9 @@ bool qmi_device_discover(struct qmi_device *device, qmi=
_discover_func_t func,
>   bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t=
 func,
>   				void *user_data, qmi_destroy_func_t destroy);
>   =

> +bool qmi_device_sync(struct qmi_device *device,
> +		     qmi_sync_func_t func, void *user_data);
> +
>   enum qmi_device_expected_data_format qmi_device_get_expected_data_forma=
t(
>   						struct qmi_device *device);
>   bool qmi_device_set_expected_data_format(struct qmi_device *device,
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index a49859901f2f..40eefdfc867b 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -252,6 +252,15 @@ error:
>   	shutdown_device(modem);
>   }
>   =

> +static void create_shared_dms(void *user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gobi_data *data =3D ofono_modem_get_data(modem);
> +
> +	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
> +				  create_dms_cb, modem, NULL);
> +}
> +
>   static void discover_cb(uint8_t count, const struct qmi_version *list,
>   							void *user_data)
>   {
> @@ -266,6 +275,15 @@ static void discover_cb(uint8_t count, const struct =
qmi_version *list,
>   				list[i].type);
>   =

>   		switch (list[i].type) {
> +		case QMI_SERVICE_CONTROL:
> +			/* sync command resets the QMI state */
> +			if (list[i].major > 1 ||
> +					(list[i].major =3D=3D 1 &&
> +					 list[i].minor >=3D 5))
> +				ofono_modem_set_boolean(modem,
> +							"SupportQMISync",
> +							TRUE);
> +			break;

This really belongs as an API on qmi_device and not some property on the =

modem.

E.g. qmi_device_get_control_version or qmi_device_is_sync_supported

>   		case QMI_SERVICE_DMS:
>   			data->features |=3D GOBI_DMS;
>   			break;
> @@ -314,8 +332,10 @@ static void discover_cb(uint8_t count, const struct =
qmi_version *list,
>   		return;
>   	}
>   =

> -	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
> -						create_dms_cb, modem, NULL);
> +	if (ofono_modem_get_boolean(modem, "SupportQMISync") =3D=3D TRUE)
> +		qmi_device_sync(data->device, create_shared_dms, modem);
> +	else
> +		create_shared_dms(modem);
>   }
>   =

>   static int gobi_enable(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============1832921247883223548==--

