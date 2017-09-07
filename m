Content-Type: multipart/mixed; boundary="===============7543000469346367351=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 20:11:13 +0300
Message-ID: <989359f1-9639-27ec-b2b2-7cbee320402f@jolla.com>
In-Reply-To: <2771ab58-48c9-60ab-d492-f37977d67f24@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7543000469346367351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/09/17 19:05, Denis Kenzior wrote:
> Hi Slava,
>
> On 09/07/2017 08:06 AM, Slava Monich wrote:
>> On 07/09/17 12:47, Jonas Bonn wrote:
>>> On 09/07/2017 06:23 AM, Nishanth V wrote:
>>>> added new DBUS methods RegisterAgent and UnregisterAgent to
>>>> Networkmonitor interface so that any client of ofono can register for
>>>> serving cell updates. Added new agent interface NetworkMonitorAgent
>>>> with two methods, ServingCellInformationChanged and Release.
>>>
>>> My spontaneous reaction to this is that it feels like the wrong =

>>> approach.  Why not make the properties actual DBus properties and =

>>> provide PropertiesChanged events for them? That begets you the same =

>>> functionality for "free".
>>
>> The implementation also seems to limit the number of clients =

>> receiving those cell change notifications to just one. Why? In real =

>> life more than one process may need those.
>>
>
> You keep saying that, but never provide concrete scenarios how this =

> could be 'useful'?  I am tempted to simply ignore such feedback in the =

> future.
>

In the Sailfish OS case, one is the positioning helper, and there's the =

factory test app. That makes it at least two. The factory test app often =

plays the role of the second client since it's touching pretty much all =

the important interfaces in the system. And there are 3rd party apps =

which we don't control.

> For now I don't see why we would want to have multiple agents =

> registered and to keep the implementation simple we will only support =

> one.
>

That's fine, we are using a different interface for getting cell =

information anyway. Go ahead and ignore the feedback.

Cheers,
-Slava

> Regards,
> -Denis


--===============7543000469346367351==--

