Content-Type: multipart/mixed; boundary="===============8785310917407333171=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 11:12:57 -0500
Message-ID: <4C769289.4080605@gmail.com>
In-Reply-To: <AANLkTi=iBgBu1KihScHS9LEg2Y_+wb8EjRVzEYAQAp1i@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8785310917407333171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 11:08 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2010/8/26 Denis Kenzior <denkenz@gmail.com>:
>>>>> Enable or disable Fixed Dialing Numbers feature on SIM card.
>>>>>
>>>>> If enabled, calls can be dialled or SMSs sent only to numbers listed =
on
>>>>> special FDN phonebook on the SIM card.
>>>>
>>>> FDN has serious implications for the rest of the system, particularly =
on
>>>> SMS atom and Sim Toolkit.  oFono will either have to support the entire
>>>> thing properly or use a 'limited' FDN mode (e.g. if FDN is enabled, we
>>>> only permit emergency calls.)
>>>
>>>> We have really not made our mind what makes sense here yet.
>>>
>>> I think most modems support FDN in the firmware. (Well, famous last
>>> words.) I don't think it makes any sense to support or "support" it in
>>> oFono.
>>
>> You're correct.  However, if FDN is enabled, carriers require that SMSes
>> to numbers not in FDN to be rejected.  It is quite unclear whether this
>> is done in the firmware or not.  If oFono has to handle it internally,
>> then we also require access to the FDN phonebook.
>>
>> Sim Toolkit interactions require FDN to be explicitly ignored for Send
>> SMS, Setup Call.  If these are not handled in the firmware, then we
>> can't properly support FDN.
> =

> Do you think oFono should reject the SIM if it happens to have FDN enable=
d? Why?

There is actually some 3GPP spec that mandates low-functionality mode if
FDN is not properly supported by the terminal.  e.g. 31.102:
"In case FDN is enabled, an ME which does not support FDN shall allow
emergency calls but shall not allow MO-CS calls and MO-SMS.
If BDN is enabled, an ME which does not support Call Control shall allow
emergency calls but shall not allow MO-CS calls."

> =

> If we don't support FDN restrictions, we don't support. This has
> nothing to do whether we should allow the user to disable the FDN on
> the SIM card or not.
> =


You might be right, I'm just saying we need to explore the issue more fully.

Regards,
-Denis

--===============8785310917407333171==--

