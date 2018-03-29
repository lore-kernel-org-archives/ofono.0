Content-Type: multipart/mixed; boundary="===============7845174026228090398=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 01/30] qmi: remove unused fields of service_send_data
Date: Thu, 29 Mar 2018 12:46:03 +0200
Message-ID: <ca674d4d-d43d-fec7-e146-09d44935571e@southpole.se>
In-Reply-To: <d7701932-a878-379f-bd79-009d020cbc8d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7845174026228090398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 28/03/18 21:53, Denis Kenzior wrote:
> Hi Jonas,
>
>> @@ -2308,17 +2304,18 @@ uint16_t qmi_service_send(struct qmi_service =

>> *service,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 data->service =3D service;
>> -=C2=A0=C2=A0=C2=A0 data->param =3D param;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->func =3D func;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->user_data =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->destroy =3D destroy;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req =3D __request_alloc(service->t=
ype, service->client_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 message, QMI_SERVICE_HDR_SIZE,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->param ? data->param->data : NULL,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->param ? data->param->length : 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 param ? param->data : NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 param ? param->length : 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_send_callback, data, (void **) &hdr);
>> +
>> +=C2=A0=C2=A0=C2=A0 qmi_param_free(param);
>> +
>
> This looks dangerous.=C2=A0 The problem is that all the qmi code issues =

> qmi_param_free in case qmi_service_send failed.=C2=A0 So you have a doubl=
e =

> free situation here.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!req) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>
>
So, I checked this again.=C2=A0 The above, as you pointed out, is not right=
.=C2=A0 =

But just moving the qmi_param_free to the end of the qmi_service_send =

function, just before it returns success, is what this should have =

been.=C2=A0 If the function returns success, the user expects that we free =

param; if we do it there then we don't need the reference into the callback.

I'll fix the patch and resubmit it.

/Jonas

> Regards,
> -Denis


--===============7845174026228090398==--

