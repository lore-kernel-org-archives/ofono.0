Content-Type: multipart/mixed; boundary="===============1559167720639831884=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 01/30] qmi: remove unused fields of service_send_data
Date: Wed, 28 Mar 2018 14:53:17 -0500
Message-ID: <d7701932-a878-379f-bd79-009d020cbc8d@gmail.com>
In-Reply-To: <20180328190016.28509-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1559167720639831884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> @@ -2308,17 +2304,18 @@ uint16_t qmi_service_send(struct qmi_service *ser=
vice,
>   	if (!data)
>   		return 0;
>   =

> -	data->service =3D service;
> -	data->param =3D param;
>   	data->func =3D func;
>   	data->user_data =3D user_data;
>   	data->destroy =3D destroy;
>   =

>   	req =3D __request_alloc(service->type, service->client_id,
>   				message, QMI_SERVICE_HDR_SIZE,
> -				data->param ? data->param->data : NULL,
> -				data->param ? data->param->length : 0,
> +				param ? param->data : NULL,
> +				param ? param->length : 0,
>   				service_send_callback, data, (void **) &hdr);
> +
> +	qmi_param_free(param);
> +

This looks dangerous.  The problem is that all the qmi code issues =

qmi_param_free in case qmi_service_send failed.  So you have a double =

free situation here.

>   	if (!req) {
>   		g_free(data);
>   		return 0;
> =


Regards,
-Denis

--===============1559167720639831884==--

