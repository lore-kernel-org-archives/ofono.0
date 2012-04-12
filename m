Content-Type: multipart/mixed; boundary="===============0710308716855051577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: use full CLCC handling in dialing case
Date: Wed, 11 Apr 2012 23:56:26 -0500
Message-ID: <4F86607A.8080304@gmail.com>
In-Reply-To: <1334172998-3969-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0710308716855051577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 04/11/2012 02:36 PM, Mike Brudevold wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
> =

> A call that moves from the dialing to active state before the +CLCC respo=
nse
> will not properly be added as a voicecall. This is because the dialing ca=
llback
> was using simplified handling and only looked for calls in the dialing or
> alerting state.
> =

> AT sequence that exhibited the failure (AG device was an iPhone accessing
> visual voicemail):
> =

>> +CIND: ("service",(0-1)),("call",(0-1)),("callsetup",(0-3)),
> ("battchg",(0-5)),("signal",(0-5)),("roam",(0-1)),("callheld",(0-2))
> ...
>> +CIEV: 3,2
> < AT+CLCC
>> +CIEV: 2,1
>> +CIEV: 3,0
>> +CLCC: 1,0,0,0,0,"**21153**",129,"Voicemail"
> ---
>  drivers/hfpmodem/voicecall.c |   68 +-----------------------------------=
------
>  1 files changed, 1 insertions(+), 67 deletions(-)
> =


Patch looks good to me.  Applied, thanks.

Regards,
-Denis

--===============0710308716855051577==--

