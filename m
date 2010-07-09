Content-Type: multipart/mixed; boundary="===============2609889452392214573=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Fri, 09 Jul 2010 12:19:37 -0500
Message-ID: <4C375A29.6090004@gmail.com>
In-Reply-To: <1278695517.2327.158.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2609889452392214573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/09/2010 12:11 PM, Inaky Perez-Gonzalez wrote:
> On Thu, 2010-07-08 at 17:22 -0700, Denis Kenzior wrote: =

>> Inaky,
>>
>> ....
>>>>
>>>> No worries, take your time.  Just as a heads up, I pushed some changes
>>>> to src/sms.c today.
>>>
>>> Grrr -- found the bug and deal with it. However, when I tried to pull
>>> your tree to rebase on top, I got weird conflicts on stkutil.c -- don't
>>> have time to diagnose now, but just wanted to ask: did you do a rebase? =

>>
>> Yep.
> =

> Rats. Don't. Rebase. A. Public. Tree. Please! :)
> =

> =


Maybe we're not talking about the same thing.  My workflow is

git commit / git am
git fetch
git rebase
git push

Regards,
-Denis

--===============2609889452392214573==--

