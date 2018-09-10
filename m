Content-Type: multipart/mixed; boundary="===============2932929802585232246=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add LTE state for AT+CREG
Date: Mon, 10 Sep 2018 15:07:40 -0500
Message-ID: <e0f7cb04-5635-4b5c-63a1-68bdea32cd53@gmail.com>
In-Reply-To: <4706dbb3-cbba-7151-264c-898060bf08c7@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2932929802585232246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 09/10/2018 02:56 PM, Slava Monich wrote:
> Hi Denis,
>> Hi Slava,
>>
>> On 09/10/2018 01:26 PM, Slava Monich wrote:
>>> Hi Anirudh, Denis at al.
>>>
>>>> @@ -669,6 +669,10 @@ const char *registration_status_to_string(int =

>>>> status)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "unknow=
n";
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMI=
NG:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roamin=
g";
>>>>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRA=
N:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "registered lte";
>>>>> +=C2=A0=C2=A0=C2=A0 case NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "roaming lte";
>>>
>>> What would be the difference between "roaming lte" and "roaming" (or =

>>> "registered lte" vs "registered") from the viewpoint of D-Bus API =

>>> clients? In other words, what would e.g. dialer do differently =

>>> depending on whether registration status is "registered lte" or just =

>>> "registered"? Is it worth the API break? The existing clients won't =

>>> know how to handle the new values until they (clients) get updated.
>>>
>>
>> I agree.=C2=A0 That is why I suggested a separate Property for this (and =

>> the CSFB case from 27.007) instead of modifying the Status property =

>> directly.
>>
>> E.g. REGISTERED_SMS_EUTRAN would map to Status=3D"registered" and =

>> SmsOnly=3DFalse.=C2=A0 ROAMING_SMS_EUTRAN would map to Status=3D"roaming=
" and =

>> SmsOnly=3DTrue.
>>
>> I assume that the Dialer can ignore this as the modem will fall back =

>> to 3G in case of a call?=C2=A0 Someone feel free to educate me.
> =

> The modems I dealt with do drop to 3G for voice calls. Once voice call =

> terminates, they switch back to LTE (well, most of the time). Dialler =

> (at least our dialler) doesn't care about access technology.

That is what I've seen as well.  But these are pre-VoLTE devices most =

likely.  VoLTE might act differently.

> =

> Just a thought - could the presence of org.ofono.VoiceCallManager and =

> org.ofono.MessageManager interfaces be used to indicate whether voice =

> calls and/or messaging is available? That wouldn't require any D-Bus API =

> changes at all.
> =


VoiceCallManager should always be available since you still need to make =

Emergency Calls.  There might be some really weird legacy devices which =

were Data-Only, but those aren't really the focus of oFono anyway.

What I assume is happening in 27.007 is that registration states 6/9 & =

7/10 allows one to discern whether Circuit Switched Fallback would be =

triggered.  I assume if the device (& network) is VoLTE capable, then =

you'd see state 9/10, 6/7 otherwise.  Perhaps all 4 states should be =

combined into a single CircuitSwitchedFallback property instead...

Regards,
-Denis

--===============2932929802585232246==--

