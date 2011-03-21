Content-Type: multipart/mixed; boundary="===============7194469609908179349=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 3/6] gathdlc: add mechanism to detect ppp suspension from
 DUN client.
Date: Mon, 21 Mar 2011 15:17:10 +0100
Message-ID: <4D875DE6.8010609@linux.intel.com>
In-Reply-To: <4D826B7E.4020507@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7194469609908179349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 17/03/2011 21:13, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 03/15/2011 04:19 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/gathdlc.c |   58 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 files changed, 58 insertions(+), 0 deletions(-)
> http://en.wikipedia.org/wiki/Time_Independent_Escape_Sequence
>
> If you really want to do this, then lets do this properly, including the
> guard timeouts.
>
> Regards,
> -Denis
>
I noticed also this guard timeouts after having sent the set of patches. =

I will send a 2nd version of patches.
However I can't test the "+++" sequence with telnet because it is adding =

some '\r' '\n' characters when I do do "+++" then "Enter".
I could try to filter those characters but it would add some specific =

code for telnet test case.

I have tried to modifiy gsmdial to send "+++" 5 seconds after the 2 ppp =

devices have been set up for instance.
I have implemented a g_at_ppp_send_escape_sequence() function to send =

it. (this function directly writes on the GIOChannel)
Then the GAtChat is resumed and an ATH0 is sent.

Should I commit first the test case over gsmdial and then commit the =

escape sequence detection mechanism?

Kind regards,
Guillaume



--===============7194469609908179349==--

