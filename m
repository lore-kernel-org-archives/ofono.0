Content-Type: multipart/mixed; boundary="===============2655505359525913972=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: Add EmergencyCall property.
Date: Mon, 06 Dec 2010 20:55:08 -0600
Message-ID: <4CFDA20C.9020808@gmail.com>
In-Reply-To: <FE1DB9979BF5A743BEB836613423CAD8012C9C95@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2655505359525913972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 12/03/2010 02:00 AM, John.Mathew(a)elektrobit.com wrote:
> Hi Marcel, =

> =

>>
>>> This was a question open for discussion. What would be the =

>> appropriate property name?
>>
>> As per my understanding, this property is only to provide the =

>> Emergency call indication to the application side, so that =

>> applications can display a different UI compared to the normal =

>> UI. In this case, I think the property name "Emergency" is enough. =

>>
>> Since this is a property for the call, the following fits as =

>> well. We can remove the existing multiparty property and add =

>> it to the new property.
>>
>> string Type [readonly]
>>       Contains the Type of the current call.
>>
>>       The Values can be:
>>               "Normal"
>>               "Emergency"
>> 		   "Data"
>> 	         "Multiparty"	=

>>
>> Let me know your opinion on this.
>>
>                          =

> Any comments?
> =


We're not going to support data calls, not by re-using the Voicecall
interface anyway.  So I still prefer the original proposal of using
boolean Emergency property here.

Regards,
-Denis

--===============2655505359525913972==--

