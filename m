Content-Type: multipart/mixed; boundary="===============8520264152235105352=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 13:50:30 -0500
Message-ID: <554127F6.6030401@gmail.com>
In-Reply-To: <554121F0.4010907@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8520264152235105352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 04/29/2015 01:24 PM, Alex J Lennon wrote:
> Hi Denis,
>
> On 29/04/2015 20:17, Denis Kenzior wrote:
>> Hi Alex,
>>
>> On 04/29/2015 11:45 AM, Alex J Lennon wrote:
>>> Hi,
>>>
>>> I've created a patch which adds support for the Cinterion EHS6 to Ofono.
>>>
>>> This is based on the TC65 source code with some changes to address an
>>> issue with +CIND handling
>>>
>>
>> Most likely TC65 has this issue as well.  Are there any other changes ?
>>
>
> Yes it does. I started out with the TC65, couldn't get it going and had
> to apply that patch to it to get a connection up.

It might be easier to rename tc65.c into cinterion.c and have it handle =

both tc65 and ehs6 if this is the only difference.

>
> I didn't include the change as am focussed on EHS6 hardware here and
> wasn't sure what the impact would be on TC65.
> I can provide the TC65 patch easily enough too if you think it useful.
>

I would like to avoid duplicating modem drivers.  So if plugins/tc65.c =

can handle the EHS6 with just minor tweaks, then this would be the =

preferred approach.

Regards,
-Denis


--===============8520264152235105352==--

