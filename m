Content-Type: multipart/mixed; boundary="===============4910121737410950020=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 5/5] cf: Handle send ss proactive command
Date: Mon, 27 Sep 2010 10:11:29 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732D912FDC@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A51C75@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4910121737410950020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Jeevaka.Badrappan(a)elektrobit.com
>Sent: Wednesday, September 22, 2010 3:29 AM
>To: ofono(a)ofono.org
>Subject: RE: [PATCH 5/5] cf: Handle send ss proactive command
>
>Hi Yang,
>
>> --- a/src/stk.c
>> +++ b/src/stk.c
>
>> +	unsigned char addnl[2];
>> +
>> +	default:
>> +		DBG("Send ss finishes with error type: %d",
>error->type);
>> +		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
>> +		addnl[0] =3D (unsigned char) error->error;
>> +		addnl[1] =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
>> +		rsp.result.additional =3D addnl;
>> +		rsp.result.additional_len =3D 2;
>> +		break;
>> +	}
>> +
>
>Isn't the above code, has to be something like
>
>	unsigned char addnl;
>
>	default:
>		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
>		addnl =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
>		rsp.result.additional =3D &addnl;
>		rsp.result.additional_len =3D 1;

You are right and I will change the code following this. Thanks for the com=
ment!


Regards,
-Yang

--===============4910121737410950020==--

