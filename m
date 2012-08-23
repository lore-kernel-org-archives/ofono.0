Content-Type: multipart/mixed; boundary="===============4797362754108693139=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Thu, 23 Aug 2012 16:26:35 +0200
Message-ID: <50363D9B.80400@linux.intel.com>
In-Reply-To: <503634B1.90701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4797362754108693139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 23/08/2012 15:48, Denis Kenzior wrote:
> Hi Guillaume,
>
> <snip>
>
>> Unfortunately I come to the conclusion that if I want to send one same
>> SMS to 3/4/5/... recipients with an application using oFono middleware,
>> I will not be able to send them through the same RRC channel, unless I
>> queue them offline.
>>
>
> If such a feature is important, then you do have a point. However, =

> implementing _anything_ by introducing an arbitrary delay is simply =

> wrong.  I believe they teach the reasons for that in Operating Systems =

> 101.  You are introducing a race condition that will break things at =

> the most inopportune time.

I agree that it is not the most elegant/cleanest solution.

>
> If we really require multi-recipient SMS to go on the same RRC =

> channel, then the best way to do so would be to introduce a new API =

> specifically for this use case.

Having a new API for multi-recipient SMS would be indeed the best solution.
With current implementation the test is passing with multi-segment SMS =

using script but GCF test description is mentioning 3 different SMS.
During device certification (with applications), the tester will try to =

send an SMS to 3 recipients but it will fail.
Another solution would be to remove multi-SMS support from the PICS.

Kind regards,
Guillaume


--===============4797362754108693139==--

