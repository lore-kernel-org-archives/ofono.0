Content-Type: multipart/mixed; boundary="===============3582584975729044776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] cdmamodem: create vendor.h file.
Date: Mon, 25 Jul 2011 01:23:26 -0500
Message-ID: <4E2D0BDE.3000001@gmail.com>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E5AB@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3582584975729044776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 07/25/2011 10:00 AM, Aygon, Bertrand wrote:
> Hi,
> =

>>>>>  Makefile.am                |    3 ++-
>>>>>  drivers/cdmamodem/vendor.h |   25 +++++++++++++++++++++++++
>>>>>  2 files changed, 27 insertions(+), 1 deletions(-)
>>>>>  create mode 100644 drivers/cdmamodem/vendor.h
>>>>>
>>>>> diff --git a/Makefile.am b/Makefile.am
>>>>> index e00f73b..f1ef96c 100644
>>>>> --- a/Makefile.am
>>>>> +++ b/Makefile.am
>>>>> @@ -270,7 +270,8 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.=
h \
>>>>>  			drivers/cdmamodem/voicecall.c \
>>>>>  			drivers/cdmamodem/devinfo.c \
>>>>>  			drivers/cdmamodem/connman.c \
>>>>> -			drivers/cdmamodem/network-registration.c
>>>>> +			drivers/cdmamodem/network-registration.c \
>>>>> +			drivers/cdmamodem/vendor.h
>>>>>  endif
>>>>>
>>>>>  builtin_modules +=3D g1
>>>>> diff --git a/drivers/cdmamodem/vendor.h b/drivers/cdmamodem/vendor.h
>>>>> new file mode 100644
>>>>> index 0000000..3b00bbf
>>>>> --- /dev/null
>>>>> +++ b/drivers/cdmamodem/vendor.h
>>>>> @@ -0,0 +1,25 @@
>>>>> +/*
>>>>> + *
>>>>> + *  oFono - Open Source Telephony
>>>>> + *
>>>>> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
>>>>> + *
>>>>> + *  This program is free software; you can redistribute it and/or
>> modify
>>>>> + *  it under the terms of the GNU General Public License version 2 as
>>>>> + *  published by the Free Software Foundation.
>>>>> + *
>>>>> + *  This program is distributed in the hope that it will be useful,
>>>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + *  GNU General Public License for more details.
>>>>> + *
>>>>> + *  You should have received a copy of the GNU General Public License
>>>>> + *  along with this program; if not, write to the Free Software
>>>>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-
>> 1301
>>>> USA
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +enum ofono_vendor {
>>>>> +	OFONO_VENDOR_GENERIC =3D 0,
>>>>> +	OFONO_VENDOR_SPEEDUP,
>>>>> +};
>>>>
>>>> do not bother with this until it is really needed. Vendor quirks are t=
he
>>>> last resort to avoid massive code duplication. In a lot of cases a
>>>> vendor specific atom driver is the better choice.
>>>>
>>>> And you can just share the atmodem ones in this case anyway.
>>>
>>> I am thinking again to this file, and I think we will definitely need a
>> Vendor.h for CDMA.
>>>
>>> As we said in another discussion, there is no standard in CDMA, so we s=
hould
>> have vendor specific code in any atom. And creating an atom per modem wi=
ll
>> duplicate a lot of code.
>>>
>>> And I don't know if we should set an OFONO_VENDOR_GENERIC for CDMA. I t=
hink
>> that if 2 modems are using the same AT command (CPIN for example), we sh=
ould
>> do a switch or if/else with all the different vendor.
>>>
>>> Another exemple. We are working on ConnMan atom. The 2 kind of dongle we
>> have used, Huawei and SpeedUp, are using ^DORMANT for dormant mode
>> notification. I don't think that we have to duplicate the ConnMan atom. =
We
>> should be using the same atom, and use vendor define to set the AT comma=
nd to
>> register.
>>>
>>> What do you think about this?
>>
>> are you sure that the SpeedUp and Huawei dongle are really different.
>> Maybe it is just a re-branded version of the other. They could be
>> different and just share the same AT command set, but even then we might
>> not just bother here.
> =

> I do not remember exactly, I will have to go through my log, but from wha=
t I remember, they are sharing lot of command.
> =


Please stop over-analyzing.  Write a huaweimodem driver for network
registration.  If it fits the bill for speedup, then just use it from
the speedup modem driver.

Based on the various CDMA docs I've read there won't be a generic netreg
atom implementation anyway, they're all different.

>> And from were I am standing, feel free to share the vendor quirks from
>> atmodem/vendor.h. At least until we have the rest figured out.
> =

> Ok, and what about the GENERIC, are we creating one? I don't think that t=
his is a good idea.
> =


This doesn't make sense in the first place.  If something is generic
then it belongs in drivers/cdmamodem and no quirk is required.

Regards,
-Denis

--===============3582584975729044776==--

