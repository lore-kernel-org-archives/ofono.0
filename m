Content-Type: multipart/mixed; boundary="===============5680436366868101237=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 3/3] stk: Handle provide local info proactive command
Date: Wed, 01 Dec 2010 10:03:14 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4733073BA39@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802C4036D@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5680436366868101237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Jeevaka.Badrappan(a)elektrobit.com
>Sent: Wednesday, December 01, 2010 4:43 AM
>To: ofono(a)ofono.org
>Subject: RE: [PATCH 3/3] stk: Handle provide local info proactive command
>
>
>Hi Yang,
>
>>
>> +static void get_time(struct stk_response *rsp) {
>> +	time_t now;
>> +	struct tm *t;
>> +
>> +	time(&now);
>> +	t =3D localtime(&now);
>> +
>> +	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
>> +
>> +	if (t->tm_year > 100)
>> +		rsp->provide_local_info.datetime.year =3D
>> t->tm_year - 100;
>> +	else
>> +		rsp->provide_local_info.datetime.year =3D t->tm_year;
>> +
>
>Incase of error, localtime shall return a null pointer. I think its
>better to add the NULL check.


Thanks for the comment. I have sent out the modified version. =





Regards,
-Yang

--===============5680436366868101237==--

