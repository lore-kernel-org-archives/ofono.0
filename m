Content-Type: multipart/mixed; boundary="===============0356734554985060933=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/5] stk: Add parser for send ussd commands
Date: Sun, 20 Jun 2010 21:52:11 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731ED8E752@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201006181404.27354.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0356734554985060933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,



>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Saturday, June 19, 2010 3:04 AM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH 1/5] stk: Add parser for send ussd commands
>
>Hi Yang,
>
>> ---
>>  src/stkutil.c |   61
>>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>src/stkutil.h |
>>    9 ++++++++
>>  2 files changed, 70 insertions(+), 0 deletions(-)
>
>Patches 1, 2 and 5 have been applied.  As discussed previously we're skipp=
ing
>patches 3 and 4 for now.  Please note that I broke Patch 2 into two patche=
s (1
>for decode_ussd in smsutil.[ch] and one for the unit test), but did not do=
 any
>modifications beyond that.
>
>Again, please watch out for this.  If your patch touches something in two =
or
>more directories of oFono, please send multiple patches.

Thank you for applying the patches. But I have a question on this: Should w=
e keep the code compile-able after each patch? Due to this consideration, I=
 put those changes all in patch 2. This would sometimes be helpful when we =
want to investigate a regression after a bunch of patches. If this is not a=
 requirement for this project, I will pay more attention on how to split th=
e patches reasonably.


>Regards,
>-Denis


Regards,
-Yang

--===============0356734554985060933==--

