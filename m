Content-Type: multipart/mixed; boundary="===============5666401398541826163=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: Re: [PATCH 2/4]simutil: Changes to prepare for isimodem2.5
Date: Thu, 09 Dec 2010 09:59:02 +0100
Message-ID: <4D009A56.7090104@stericsson.com>
In-Reply-To: <1291822212.4795.177.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5666401398541826163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
> please write a proper commit message here. The subject is not acceptable
> since it misleads what this patch is doing.
>    =

>> +#include "types.h"
>> +
>>      =

> What is this include for? Please remove it.
>    =

> So please be consistent with lower-case hex encoding. So 0x6f07 etc.
  Ok, fix commit message, remove unnecessary include and use lower case. =

Will do.

> And while at it, you could be the one that makes this enum finally
> compliant to our coding style. This is one of our old left-overs that we
> have get fixed. We just never got around to it. Are you up for such a
> task?
>    =

Sure, I'll take this. This is just the simutil.h we are talking about, =

not the simutil.c as well?

> So you could just fix the coding style in one patch, fix the sorting in
> another and then add the new values.
>    =

3 patches to be sent in, and the last one to have the new values (with =

proper prefixes), I'll see to it.

Best Regards,
Jessica


--===============5666401398541826163==--

