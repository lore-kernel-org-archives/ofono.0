Content-Type: multipart/mixed; boundary="===============9171068599647028725=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Fri, 24 Aug 2012 10:16:46 +0200
Message-ID: <5037386E.6090806@linux.intel.com>
In-Reply-To: <5036694F.7030805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9171068599647028725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 23/08/2012 19:33, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/23/2012 09:26 AM, Guillaume Zajac wrote:
>> Hi Denis,
>>
>> On 23/08/2012 15:48, Denis Kenzior wrote:
>>> Hi Guillaume,
>>>
>>> <snip>
>>>
>>>> Unfortunately I come to the conclusion that if I want to send one same
>>>> SMS to 3/4/5/... recipients with an application using oFono =

>>>> middleware,
>>>> I will not be able to send them through the same RRC channel, unless I
>>>> queue them offline.
>>>>
>>>
>>> If such a feature is important, then you do have a point. However,
>>> implementing _anything_ by introducing an arbitrary delay is simply
>>> wrong. I believe they teach the reasons for that in Operating Systems
>>> 101. You are introducing a race condition that will break things at
>>> the most inopportune time.
>>
>> I agree that it is not the most elegant/cleanest solution.
>>
>
> Then please refrain from sending patches which contain 'not the most =

> elegant/cleanest' solution in the future.  oFono has a very high =

> standard of quality, and the standard is even higher in the core than =

> the driver code.
>
> You are better off starting a discussion on IRC or describing the =

> problem in detail on the mailing list asking for possible solutions.
>
>>>
>>> If we really require multi-recipient SMS to go on the same RRC
>>> channel, then the best way to do so would be to introduce a new API
>>> specifically for this use case.
>>
>> Having a new API for multi-recipient SMS would be indeed the best =

>> solution.
>> With current implementation the test is passing with multi-segment SMS
>> using script but GCF test description is mentioning 3 different SMS.
>> During device certification (with applications), the tester will try to
>> send an SMS to 3 recipients but it will fail.
>> Another solution would be to remove multi-SMS support from the PICS.
>
> Our current goal is just the baseline.  That means if we're missing a =

> feature, then we need to note that down and continue on.
>
> This is where the TODO file comes in.  If you see features that are =

> missing, then send a patch to the TODO file describing the feature and =

> the preferred approach (after the relevant discussions on IRC/mailing =

> list).  The feature priority assignment / implementation can then =

> proceed with the well-established workflow.
>

Ok I will send a RFC about this new feature, this will be the new thread =

to discuss on it.

Kind regards,
Guillaume

--===============9171068599647028725==--

