Content-Type: multipart/mixed; boundary="===============9156077143881555382=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: RE: [PATCH] udevng: use huaweicdma driver for olive V-ME101
Date: Fri, 06 Jan 2012 00:57:30 +0000
Message-ID: <688E999A39D0DD478D9CFCDC485D6482AE23@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <4F05CA3C.5090005@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9156077143881555382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of nicolas.bertrand
>Sent: Friday, January 06, 2012 12:05 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH] udevng: use huaweicdma driver for olive V-ME101
>
>Hi Marcel,
>
>On 01/05/2012 09:03 AM, Marcel Holtmann wrote:
>> Hi Nicolas,
>>
>>>   plugins/udevng.c |    3 +--
>>>   1 files changed, 1 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>>> index be87320..8d478cf 100644
>>> --- a/plugins/udevng.c
>>> +++ b/plugins/udevng.c
>>> @@ -800,11 +800,10 @@ static struct {
>>>   	{ "hso",	"hso"				},
>>>   	{ "gobi",	"qcserial"			},
>>>   	{ "sierra",	"sierra"			},
>>> -	{ "huawei",	"option",	"201e", "2009"	},
>>> +	{ "huaweicdma",	"option",	"201e", "2009"	},
>>>   	{ "huawei",	"cdc_ether",	"12d1"		},
>>>   	{ "huawei",	"option",	"12d1"		},
>>>   	{ "huaweicdma",	"option",	"12d1", "140b"	},
>>> -	{ "huaweicdma", "option",	"201e"		},
>>>   	{ "speedupcdma","option",	"1c9e", "9e00"	},
>>>   	{ "speedup",	"option",	"1c9e"		},
>>>   	{ "speedup",	"option",	"2020"		},
>>
>> the commit message does not explain why you are removing huaweicdma in
>> general for VID 0x201e.
>
>I've removed the generic configuration of HAIER's modem (0x201e) since
>there is only one product ID used for the moment by this vendor (seen in
>the option driver).
>
>Do I need to only use the generic configuration and removing the
>specific one to the PID 2009 or either simply add this comment in the
>commit message?

Haier helps many carriers to OEM dongles, including GSM/CDMA/TDS-CDMA/LTE..
So it'd not be a good idea to force all Haier dongle to load cdma driver.

>>
>> Regards
>>
>> Marcel
>>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> http://lists.ofono.org/listinfo/ofono
>>
>
>--
>regards,
>Nico
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============9156077143881555382==--

