Content-Type: multipart/mixed; boundary="===============3015239010303739186=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 01/30] qmi: remove unused fields of service_send_data
Date: Wed, 28 Mar 2018 23:09:00 +0200
Message-ID: <741a037f-4138-e7a6-88fd-d6e8967b623c@southpole.se>
In-Reply-To: <d7701932-a878-379f-bd79-009d020cbc8d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3015239010303739186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



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

I agree, the patch looks weird.=C2=A0 I was sure this outside of any failur=
e =

path, but the context in the patch doesn't reflect that. I'll check again.

I can say, though, that I've run this change thousands of iterations and =

I've never hit a double-free...

/Jonas

>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!req) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>
>
> Regards,
> -Denis


--===============3015239010303739186==--

