Content-Type: multipart/mixed; boundary="===============2706264583635152012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Wed, 11 Jan 2012 05:41:49 -0600
Message-ID: <4F0D757D.3000208@gmail.com>
In-Reply-To: <1326295458.6454.238.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2706264583635152012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/11/2012 09:24 AM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>>> +	/* For obtain correct sms service number */
>>>> +	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL, =

>>>> +			NULL, NULL, NULL);
>>>
>>> you might better introduce a OFONO_VENDOR_SIM900 quirk and use that in
>>> the SMS atom driver. The phonebook support will also end up overwriting
>>> this one later on. So I am not even sure this works reliable this way.
>>> Might be just pure luck with the order of the atom.
>>>
>>
>> Actually this is fine assuming the modem does not support UTF-8
>> character set.  The builtin assumption for most atoms is that CSCS is
>> set to something sane before they're initialized.  The phonebook driver
>> will temporarily switch to UCS2 for the duration of the phonebook read
>> and restore the previous setting.
> =

> we did a vendor quirk for this for USSD of Qualcomm based modems. Maybe
> we should then also move that into the modem plugins.
> =


Yes, I think that would be cleaner.  I'll take care of it.

Regards,
-Denis

--===============2706264583635152012==--

