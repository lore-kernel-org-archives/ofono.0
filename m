Content-Type: multipart/mixed; boundary="===============2292117135805932702=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Fri, 10 Dec 2010 10:14:26 +0200
Message-ID: <4D01E162.8090000@nokia.com>
In-Reply-To: <1291935199.30085.7.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2292117135805932702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/10/2010 12:53 AM, ext Marcel Holtmann wrote:
> Hi Kai,
>
>    =

>>>> I share the concern for the IO/CPU cost, but I don't think it
>>>> matters much in which daemon this is done. Especially if some slack
>>>> is>  allowed for the timers (which should be the case), ofonod will be
>>>> scheduled when the CPU is anyways woken up (e.g. modem/audio interrupts
>>>> wake up pulseaudio).
>>>>          =

>>> this is not really true. We can not wakeup ofonod every single second.
>>> You might wanna start running powertop.
>>>        =

>> uhm, but I'm not claiming that. I was just stating that moving
>> the timers to e.g. pulseaudio in this case won't save much if
>> anything (the CPU will be woken up anyways, and the cost between
>> scheduling ofonod or a thread from PA, has really no difference
>> to overall consumption.. the CPU is woken up anyways and roughly
>> the same code to handle the timer is run).
>>
>> So whether this code is in oFono or elsewhere, does not matter
>> much (to overall power consumption). The main question is of course
>> how often the counters are synced.
>>      =

> actually it does matter since you have no extra context switch and in
> addition you not accidentally wake up PA and then ofonod. You have one
> centralized wakeup of one thread.
>
> Of course this should be smart and done along with the PA audio
> processing and not async to that one.
>
> If we consider that the only sensible thing is to track the actual
> talking time, then PA becomes a nice choice for this.
>
> This doesn't mean that you should be implementing it, but I am still
> maintaining that this would be a pretty damn smart way of solving this
> efficiently.
>
>    =

Obviously, there are many implementation options, we have to
decide only about whether we want to have this implemented
in oFono or not, or in first place, whether the feature is needed
at all or not. For the latter part I am collecting more info from
our people.
>> Personally I think the every-10sec interval is too short.
>> It's also highly system specific when wakeups start to get
>> too costly, so picking up one value seems difficult.
>>      =

> My take here is that a granularity of 1 minute is enough.
>
> Doing this every 10 seconds and displaying it on a per second level
> sounds insane to me.
>    =


That second level D-Bus query of the call counters should be forgotten,
probably is not going to happen and anyways, querying is something
that can be controlled/tuned outside ofono. In fact any method can be
"abused" in a similar way, is not oFono's responsibility to prevent such
"misuse" from happening.
There is a single value to tune, the sync interval, we can either settle
on a reasonable value, or we can make it a configurable parameter (the
default value would disable the periodic syncing), then everybody can
do whatever with its own product.

> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>    =


Regards,
Andras

--===============2292117135805932702==--

