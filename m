Content-Type: multipart/mixed; boundary="===============9058217593354836471=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 18:01:34 +0200
Message-ID: <4CFFABDE.2010102@nokia.com>
In-Reply-To: <1291812092.4795.165.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9058217593354836471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/08/2010 02:41 PM, ext Marcel Holtmann wrote:
> Hi Aki,
>
>    =

>>> so Denis and I talked about this a little bit and I am not fine with
>>> this at all.
>>>        =

>> Next time, can you invite me to join your little talk?
>>      =

> because you are not sitting next to me right now ;)
>
>    =

>>> Lets take this one step and please explain to me what your requirements
>>> and objectives are. I also wanna see a top to bottom from UI down to the
>>> modem usage of this API.
>>>        =

>> We need a UI showing total MO and MT call times. They also need to be
>> able to be reset, if the user so wishes. The data needs to be
>> reasonably reliable.
>>      =

> Fair enough, but when I look at such a feature as a whole, then my
> question is when does it need to be shown? What is your user interaction
> requirement with this data?
>
> Andras, please explain what reasonable reliable means.
>
>    =

The call counters are shown to the user when he or she opens up
an application/applet whatever UI component that is meant for
showing this information.
Coming to the reliability part, saving the call counters information
often enough, gives us sort of hard guarantee that whatever happens
with any subsystem, be that SW or HW, the call counters will stay enough
accurate. Syncing to the permanent storage, based on our product
requirements, should take place in fact every 5 sec, or could be
configurable.
There might be some liability issues if for some reason the counters would
"loose" time, the user my blame the phone manufacturer for the extra
expenses incurred by inaccurate counters.
>>> and consuming heavy IO with writing this information to disk. In
>>> addition to that there is no clear UI usage for the getter API.
>>>        =

>> What do you mean? Do you mean your iPhone has no such UI?
>>      =

> I have actually tested this with an iPhone and it has such an UI
> element, but it is not realtime. It gets updated after the call has been
> completed.
>
> So why can't we just update/reset this in Tracker via the history plugin
> in a general way. I am failing to see the need for this inside oFono. It
> seems to me that doing this within the scope of the Tracker integration
> is a lot cleaner and better for CPU and IO usage.
>    =

We can discuss the place of the call counters plugin, but I think using the
ofono history framework is a reasonable choice, with the note that the it
needs to be expanded with a history function called in the beginning
of a call.
The call counters plugin could be an optionally compiled/included (dynamic)
plugin or "downgraded" to experimental status.
>    =

>> The reason these are not properties is just because it makes no sense
>> to update the counters "live". The UI can poll if it so wishes, but
>> the poll interval is not something we want to decide.
>>
>>      =

>>> What are the granularity there. What is the expected user experience
>>> with this API. I don't see any clear usage model here.
>>>
>>> In addition to that, what is the problem with just updating the stats
>>> after the call has ended?
>>>        =

>> Because if your battery runs out in the middle of a 4 hour conference
>> call, your timers are not updated and become worthless. Obviously,
>> this is a compromise between how reliable the counters are and how
>> many wakeups and IO we can bear.
>>      =

> I think this is not a good idea to have oFono handles this. Why can't
> the system daemon just shutdown all calls when the battery reaches
> critical limit.
>    =

> You will never fully run down the battery anyway. One of the system
> health components in the system will prevent it and then can cleanly
> shutdown oFono and thus all calls. The only case where the system could
> potentially misfunction in this area would be an emergency call. But
> that is a total different use case anyway.
>    =

It was already pointed out by Mika Liljeberg there could be cases when we
might not get the chance to sync our data. We need to be prepared to cope
with such cases as well (syncing the data often "enough").

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

--===============9058217593354836471==--

