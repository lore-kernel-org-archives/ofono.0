Content-Type: multipart/mixed; boundary="===============6318789199565900812=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Thu, 10 Feb 2011 11:12:06 +0200
Message-ID: <4D53ABE6.7000709@nokia.com>
In-Reply-To: <4D535694.3030505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6318789199565900812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/10/2011 05:08 AM, ext Denis Kenzior wrote:
> Hi Andras,
>
>> diff --git a/include/ssn.h b/include/ssn.h
>> index d640cad..ba3701b 100644
>> --- a/include/ssn.h
>> +++ b/include/ssn.h
>> @@ -37,9 +37,10 @@ struct ofono_ssn_driver {
>>   };
>>
>>   /* SSN notifications (CSSI and CSSU).  */
>> -void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
>> -void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
>> -				const struct ofono_phone_number *number);
>> +void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, unsigned int id,
>> +				int code1, int index);
>> +void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, unsigned int id, int =
code2,
>> +			int index, const struct ofono_phone_number *number);
>>
>>   int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
>>   void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);
> Right now I'm not seeing any users (or even potential ones) of the SSN
> atom besides voicecall.  What do you think of removing the SSN atom and
> moving these to the voicecall atom?
Yes, we talked about removing the SSN atom, but I thought I would
keep it for now, it can be removed any time later, anyways, doesn't
save much removing it.

> The only one I'm not sure about is<code2>  from 27.007:
> 6	forward check SS message received (can be received whenever)
>
> Any idea what this one is about?
>
Never encountered this message, and I am not sure what is it for.
A patch for handling this message can be submitted later, if a real
life case is found for it.

> Regards,
> -Denis
Regards,
Andras

--===============6318789199565900812==--

