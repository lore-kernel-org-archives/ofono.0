Content-Type: multipart/mixed; boundary="===============8269584298754173364=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [PATCH 0/3] Long dial string support (2nd)
Date: Wed, 24 Nov 2010 11:14:51 +0200
Message-ID: <4CECD78B.8080602@nokia.com>
In-Reply-To: <4CEC3A5C.8030509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8269584298754173364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 11/24/2010 12:04 AM, ext Denis Kenzior wrote:
> Hi Andras,
>
>    =

>> Even if we don't support FDN at this point, there is still a remaining
>> related issue, who we are going to dial numbers like:
>>
>> 12345456p1234#1111
>>
>> I think the the dial string could still be passed to the voicecall driver
>> that will take care of the modem specific details, most importantly
>> playing the DTMF tones and generating the tone events that would be
>> propagated back to voicecall manager and to D-Bus from there.
>>      =

> So we looked into what it would take to implement dial strings with AT
> modems.  The consensus was that passing the entire string to the driver
> was a bad idea as most modems simply do not support pause characters and
> have strict limitations on the number length.
>
> The best idea we have came up with so far is to parse the string passed
> to dial and separate the actual number from the dial string.  The dial
> string then gets assigned to a separate property on the voice call
> object (see Dial String task in the TODO).
>
> We would then extend the call state logic to queue the dial string the
> same as a DTMF once the call is active.  If you study the DTMF logic,
> you will note that Andrew has recently made it into a tone queue.
>
> Today we burst up to 8 (arbitrarily picked number) DTMF tones per driver
> request.  What we could do is send a single tone at a time.  In theory
> this would allow us to emit the Tone Started / Tone Stopped signals
> (please see the provide feedback of sent DTMF tones task) as well.
>
> It sounds like the ISI modems already work this way and are nicely
> covered by this approach...
>    =

Thanks for your clarification. I also had a thorough look at the
the DTMF tones handling implementation. Based on these infos
and assuming that we don't want to implement (full) FDN
support, these patches are not needed indeed.

> Regards,
> -Denis
>    =


Regards,
Andras

--===============8269584298754173364==--

