Content-Type: multipart/mixed; boundary="===============2166594272573424057=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call Barring and MMI Supplementary Service codes
Date: Tue, 19 Oct 2010 12:13:07 -0500
Message-ID: <4CBDD1A3.4050909@gmail.com>
In-Reply-To: <AANLkTinR2KBpu+Qs4Y-Tgu1AKCZFFKzAndzZkzFYv3T+@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2166594272573424057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/19/2010 10:30 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2010/10/19 Denis Kenzior <denkenz@gmail.com>:
>> So let me repeat what you said in my own words.  The lowlevel register
>> message has these variations:
>>
>> - All data circuit sync
>> - All sync services
>>
>> - All data circuit async
>> - All async services
>>
>> In both cases they actually refer to the same set of bearer services.
> =

>> So sending one vs the other makes no difference.  So instead of
>> deprecating the 'all sync' and 'all async' versions of the low level
>> register messages the spec still expects us to send them for whatever
>> reason.
> =

> There is also a set of PLMN-specific services. I suppose it is up to
> network to decide which are sync or async and which involve data
> circuits... There are some traces in Nokia modems indicating even that
> they have been actually used at some point.
> =


Yep I've always wondered how anyone could implement these with an AT
based modem.

Anyway, this has been fixed by commit
b75a5574f5a5652880ab2fe4760c2f3272815496

Please test and report back if the conformance cases pass now.

Regards,
-Denis

--===============2166594272573424057==--

