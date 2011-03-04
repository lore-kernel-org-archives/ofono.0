Content-Type: multipart/mixed; boundary="===============7153110805950776692=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 1/3] ssn: remove SSN atom completely
Date: Fri, 04 Mar 2011 14:11:43 +0200
Message-ID: <4D70D6FF.5050609@nokia.com>
In-Reply-To: <4D6FF150.8010903@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7153110805950776692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/03/2011 09:51 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 03/03/2011 10:48 AM, Andras Domokos wrote:
>> ---
>>   Makefile.am                 |    6 +-
>>   drivers/atmodem/atmodem.c   |    2 -
>>   drivers/atmodem/atmodem.h   |    3 -
>>   drivers/atmodem/ssn.c       |  147 -------------------------
>>   drivers/isimodem/isimodem.c |    2 -
>>   drivers/isimodem/isimodem.h |    3 -
>>   drivers/isimodem/ssn.c      |   95 -----------------
>>   include/ssn.h               |   61 -----------
>>   plugins/calypso.c           |    2 -
>>   plugins/g1.c                |    2 -
>>   plugins/huawei.c            |    2 -
>>   plugins/ifx.c               |    2 -
>>   plugins/isiusb.c            |    2 -
>>   plugins/linktop.c           |    2 -
>>   plugins/n900.c              |    2 -
>>   plugins/phonesim.c          |    2 -
>>   plugins/ste.c               |    2 -
>>   plugins/tc65.c              |    2 -
>>   plugins/u8500.c             |    2 -
>>   plugins/wavecom.c           |    2 -
>>   src/ofono.h                 |   17 ---
>>   src/ssn.c                   |  247 -----------------------------------=
--------
>>   22 files changed, 2 insertions(+), 605 deletions(-)
>>   delete mode 100644 drivers/atmodem/ssn.c
>>   delete mode 100644 drivers/isimodem/ssn.c
>>   delete mode 100644 include/ssn.h
>>   delete mode 100644 src/ssn.c
>>
> Patch looks good but no longer applies due to changes that Aki pushed
> recently.

I will correct the problem.

> Regards,
> -Denis

Regards,
Andras

--===============7153110805950776692==--

