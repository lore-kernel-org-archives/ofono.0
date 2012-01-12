Content-Type: multipart/mixed; boundary="===============2975936259062298445=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Thu, 12 Jan 2012 13:55:30 +0300
Message-ID: <CAGNC_aNi_DeKV5c3ns31f6r155xo_-JQoqBnRKy1HhrmkYCJSw@mail.gmail.com>
In-Reply-To: <4F0D757D.3000208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2975936259062298445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2012/1/11 Denis Kenzior <denkenz@gmail.com>:
> Hi Marcel,
>
> On 01/11/2012 09:24 AM, Marcel Holtmann wrote:
>> Hi Denis,
>>
>>>>> + =C2=A0/* For obtain correct sms service number */
>>>>> + =C2=A0g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,=
 NULL, NULL);
>>>>
>>>> you might better introduce a OFONO_VENDOR_SIM900 quirk and use that in
>>>> the SMS atom driver. The phonebook support will also end up overwriting
>>>> this one later on. So I am not even sure this works reliable this way.
>>>> Might be just pure luck with the order of the atom.
>>>>
>>>
>>> Actually this is fine assuming the modem does not support UTF-8
>>> character set. =C2=A0The builtin assumption for most atoms is that CSCS=
 is
>>> set to something sane before they're initialized. =C2=A0The phonebook d=
river
>>> will temporarily switch to UCS2 for the duration of the phonebook read
>>> and restore the previous setting.
>>
>> we did a vendor quirk for this for USSD of Qualcomm based modems. Maybe
>> we should then also move that into the modem plugins.
>>
>
> Yes, I think that would be cleaner. =C2=A0I'll take care of it.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Hi Marcel,

How I understand, it is correct that I call CSCS command from
sim900_enable? Or I must move it in another stage?
Can I add OFONO_VENDOR_SIM900 in drivers/atmodem/vendor.h for use it
instead OFONO_VENDOR_NOKIA in ofono_netreg_create?

Best regards,
Renat Zaripov

--===============2975936259062298445==--

