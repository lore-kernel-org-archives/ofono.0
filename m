Content-Type: multipart/mixed; boundary="===============4710369902831664796=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] gathdlc: add mechanism to detect ppp suspension from
 DUN client.
Date: Mon, 21 Mar 2011 13:57:16 -0500
Message-ID: <4D879F8C.3080106@gmail.com>
In-Reply-To: <4D875DE6.8010609@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4710369902831664796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 03/21/2011 09:17 AM, Guillaume Zajac wrote:
> Hi Denis,
> =

> On 17/03/2011 21:13, Denis Kenzior wrote:
>> Hi Guillaume,
>>
>> On 03/15/2011 04:19 AM, Guillaume Zajac wrote:
>>> ---
>>>   gatchat/gathdlc.c |   58
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 files changed, 58 insertions(+), 0 deletions(-)
>> http://en.wikipedia.org/wiki/Time_Independent_Escape_Sequence
>>
>> If you really want to do this, then lets do this properly, including the
>> guard timeouts.
>>
>> Regards,
>> -Denis
>>
> I noticed also this guard timeouts after having sent the set of patches.
> I will send a 2nd version of patches.
> However I can't test the "+++" sequence with telnet because it is adding
> some '\r' '\n' characters when I do do "+++" then "Enter".
> I could try to filter those characters but it would add some specific
> code for telnet test case.
> =

> I have tried to modifiy gsmdial to send "+++" 5 seconds after the 2 ppp
> devices have been set up for instance.
> I have implemented a g_at_ppp_send_escape_sequence() function to send
> it. (this function directly writes on the GIOChannel)
> Then the GAtChat is resumed and an ATH0 is sent.
> =

> Should I commit first the test case over gsmdial and then commit the
> escape sequence detection mechanism?
> =


The order doesn't matter, but it would be nice to have all of this in
the same patch series for context.  That way the entire series can be
applied and tested in one go.

You might have to do a bit more work than just sending +++ to the
IOChannel.  For instance you might need to shutdown I/O coming from the
TUN device so as not to overflow the GAtHDLC write queue.  So perhaps a
proper g_at_ppp_suspend and g_at_chat_send_command_mode_escape() is needed.

Regards,
-Denis

--===============4710369902831664796==--

