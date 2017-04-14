Content-Type: multipart/mixed; boundary="===============4607132514118986107=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Fri, 14 Apr 2017 23:53:13 +0200
Message-ID: <3d6e046c-0b3b-5755-9d14-1755fe99338b@southpole.se>
In-Reply-To: <1a742fa1-e303-3810-60ae-18a5c1bf1770@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4607132514118986107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/13/2017 05:14 PM, Denis Kenzior wrote:
> I haven't tested this, but I suspect that calling "Start network" for
>>> the same profile again will fail...??? A profile number corresponds
>>> to a Context ID...???  Maybe...
>>
>
> I would imagine that a profile has the same meaning as the 27.007 =

> equivalent of +CGDCONT <cid>

Yes, it does.  Others have tested modifying context parameters with AT =

commands and the changes are visible in the corresponding QMI profile.  =

However, this could theoretically be firmware dependent as it's not =

actually specified anywhere that it must be so.

>
>> I tested this and "start network" fails when attempting to connect a
>> profile a second time.
>>
>
> Makes sense.  Do note that the same APN can be (in theory) double, =

> triple, etc activated.  But this requires a separate cid for each =

> instance.

Yes, exactly.  Multiple profiles with identical parameters can be =

activated, as far as I can tell.
>>> Given all of the above, for QMI this means:
>>>
>>> i)  When the netreg atom detects registration to an LTE network then
>>> we can call "Start network" immediately.
>
> gprs atom driver needs to tell ofono core that a context is active. =

> This means gprs driver should call ofono_gprs_cid_activated
>
>>> ii)  Start network will give us the packet-handle for the default
>>> bearer.  This can be held by the netreg atom.
>
> why netreg atom?  This should be managed by gprs-context.

Yes, you're right.  I also came to this insight after writing this email! :)

I originally implemented this as described above but have now posted a =

new series that works as you described.  It really hasn't been easy to =

understand how this all was supposed to work but what I've got now seems =

reasonable and functions well.

One question:  ofono_gprs_notify_bearer()... why do we need this when =

netreg already provides the technology to the GPRS atom?

Thanks for taking the time to help me work through all of this! Much =

appreciated.

/Jonas

--===============4607132514118986107==--

