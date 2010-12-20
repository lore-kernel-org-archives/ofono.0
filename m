Content-Type: multipart/mixed; boundary="===============2752205935109152360=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v2 3/9] cdma-voicecall: Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 13:47:28 -0800
Message-ID: <4D0FCEF0.8000501@nokia.com>
In-Reply-To: <4D0FC19B.6080908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2752205935109152360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

Thank you for reviewing these patches. I will submit new versions for =

your comments, please see any open points inline.

On 12/20/2010 12:50 PM, ext Denis Kenzior wrote:

>> + */
>> +
>> +#ifndef __OFONO_CDMA_VOICECALL_H
>> +#define __OFONO_CDMA_VOICECALL_H
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +#include<ofono/types.h>
>> +
>> +struct ofono_cdma_voicecall_manager;
>
> Please call this ofono_cdma_voicecall.
This is actually our preference as well as there is no multicall in =

CDMA, just the single voicecall. To that end, does it not make sense to =

also rename the interface "Voicecall" rather than "VoiceCallManager"?

Cheers
Dara

--===============2752205935109152360==--

