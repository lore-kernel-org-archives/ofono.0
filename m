Content-Type: multipart/mixed; boundary="===============5800847114605618932=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 21:11:19 +0200
Message-ID: <55412CD7.3030600@dynamicdevices.co.uk>
In-Reply-To: <554127F6.6030401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5800847114605618932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 29/04/2015 20:50, Denis Kenzior wrote:
> Hi Alex,
>
> On 04/29/2015 01:24 PM, Alex J Lennon wrote:
>> Hi Denis,
>>
>> On 29/04/2015 20:17, Denis Kenzior wrote:
>>> Hi Alex,
>>>
>>> On 04/29/2015 11:45 AM, Alex J Lennon wrote:
>>>> Hi,
>>>>
>>>> I've created a patch which adds support for the Cinterion EHS6 to
>>>> Ofono.
>>>>
>>>> This is based on the TC65 source code with some changes to address an
>>>> issue with +CIND handling
>>>>
>>>
>>> Most likely TC65 has this issue as well.  Are there any other changes ?
>>>
>>
>> Yes it does. I started out with the TC65, couldn't get it going and had
>> to apply that patch to it to get a connection up.
>
> It might be easier to rename tc65.c into cinterion.c and have it
> handle both tc65 and ehs6 if this is the only difference.
>
> I would like to avoid duplicating modem drivers.  So if plugins/tc65.c
> can handle the EHS6 with just minor tweaks, then this would be the
> preferred approach. =


I understand. I am not sure what the differences are between the tc65
and the ehs6. I'll speak with Gemalto/Cinterion to get some
clarification on this.

My thought process for splitting it out was along these lines:

At present I am focussed just on supporting a data-connection for one of
our boards with the EHS6 on it with connman/ofono.

We'll be working with the EHS6 and probably the EHS5 extensively over
the next few years on a range of board products so I will likely be
testing out other functionalities for the EHS6 such as voice, sms etc.
etc. I imagine.

I can prove this out on our hardware and provide any needed patches
upstream if that is of use.

But we don't plan to make use of the TC65 and so I can't commit to
ensuring that anything I implement for the EHS6 would work for the TC65,
or indeed wouldn't break the current TC65 implementation.

I assumed that the current tc65 code worked, although it wasn't working
for me on the ehs6, and as I don't know what's' going on there I was
keen not to make any potentially breaking changes that might cause
others problems.

Can I come back to you with the response from Cinterion/Gemalto on
differences/similarities between TC65 and EHS5/6 and then you can decide
whether the patch needs refactoring?

Thanks,

Alex



--===============5800847114605618932==--

