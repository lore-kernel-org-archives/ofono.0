Content-Type: multipart/mixed; boundary="===============8257463239934209051=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/4][RFC] gatchat: Allow cancelling a running command.
Date: Mon, 03 May 2010 18:40:37 +0200
Message-ID: <k2sfb249edb1005030940p559bf53bn28db153b2bf62440@mail.gmail.com>
In-Reply-To: <201004292153.49983.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257463239934209051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30 April 2010 04:53, Denis Kenzior <denkenz@gmail.com> wrote:
>> Users need to be extra careful using the cancel functions because
>> there's a potential race condition where an OK or ERROR for the command
>> being cancelled arrives just the same moment the next command in the
>> queue is being submitted, and is treated as a response to that command.
>
> This is why this is just a really bad idea. =C2=A0The only one I think we=
 should
> cancel (and most vendors support reliably) is an ATD...

You're right, the only modem it seems to work on is the Calypso now
that I've tried a bunch of different ones.

Let's skip this patch.

>
> Are you sure your CSIM STATUS poll would actually time out or would the m=
odem
> return a +CME/+CMS error? =C2=A0In the end the modem does this polling it=
self...

In practice they'll return errors, though according to the specs, we
should be assuming the card is not there if we get no response for N
seconds.

On the Ericsson F3607 I found it'll actually fake a response with
status word 148,4 when card is not inserted, and doesn't do polling,
i.e. insertion can only be detected if you re-connected the modem, and
extraction only when you issued a command and the modem couldn't reach
the card to perform the command.

Regards

--===============8257463239934209051==--

