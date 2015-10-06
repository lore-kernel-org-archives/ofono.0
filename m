Content-Type: multipart/mixed; boundary="===============7481011422907571676=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: Re: [PATCH 3/3] hfp_ag_bluez5: register audio card
Date: Tue, 06 Oct 2015 16:34:44 +0200
Message-ID: <5613DC04.5090502@canonical.com>
In-Reply-To: <5613D58C.80706@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7481011422907571676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06.10.2015 16:07, Denis Kenzior wrote:
> Hi Simon,
>
> On 10/06/2015 05:48 AM, Simon Fels wrote:
>> To let others (PulseAudio) be notified when a handsfree device is
>> connected with us and can be used for audio routing we need to
>> expose this by registering a audio card with the correct type.
>> ---
>>   plugins/hfp_ag_bluez5.c | 49
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>   src/emulator.c          |  1 +
>>   2 files changed, 50 insertions(+)
>>
>
> <snip>
>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index 5be7b63..626dec3 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -35,6 +35,7 @@
>>   #include "hfp.h"
>>   #include "gatserver.h"
>>   #include "gatppp.h"
>> +#include "handsfree-audio.h"
>
> I squished this part into patch #2 and applied all three.  Thanks!

Thanks a lot!

regards,
Simon


--===============7481011422907571676==--

