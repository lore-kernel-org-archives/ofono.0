Content-Type: multipart/mixed; boundary="===============5637274561272710187=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Mon, 16 Oct 2017 16:43:27 +0200
Message-ID: <39242095-0b3f-ba33-6744-a2f046882311@southpole.se>
In-Reply-To: <20171016160638.237f89f2@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5637274561272710187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 04:07 PM, Alexander Couzens wrote:
> Hi Jonas,
>
> I'm working on Gobi2000 sms support atm and having the same problem.
>
>> +	} else {
>> +		/* The Quectel EC21, at least, does not provide the
>> +		 * message data in the event notification, so a 'raw
>> read'
>> +		 * needs to be issued in order to query the message
>> itself
>> +		 */
>> +		struct qmi_param *param;
>> +
>> +		param =3D qmi_param_new();
>> +		if (!param)
>> +			return;
>> +
>> +		/* Message memory storage ID */
>> +		qmi_param_append(param, 0x01, sizeof(*notify),
>> notify);
>> +		/* The 'message mode' parameter is documented as
>> optional,
>> +		 * but the Quectel EC21 errors out with error 17
>> (missing
>> +		 * argument) if it is not provided... we default to
>> 3GPP
>> +		 * here because that's what works for me and it's
>> not clear
>> +		 * how to actually query what this should be
>> otherwise...
>> +		 */
>> +		/* Message mode */
>> +		qmi_param_append_uint8(param, 0x10,
>> +				QMI_WMS_MESSAGE_MODE_GSMWCDMA);
>> +
>> +		if (qmi_service_send(data->wms, QMI_WMS_RAW_READ,
>> param,
>> +					raw_read_cb, sms, NULL) > 0)
>> +			return;
>> +
>> +		qmi_param_free(param);
>>   	}
> Could you create a raw read request function? For the Gobi2000 I'll
> need the same function on powering to clean up the whole storage.

I'm not sure that the invocation of 'raw read' looks the same when =

iterating over the storage (from 'list messages'???) as when querying =

the data from an event...

/Jonas


>
> Best,
> Alexander



--===============5637274561272710187==--

