Content-Type: multipart/mixed; boundary="===============0926862587278342004=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Wed, 12 Apr 2017 23:10:14 +0200
Message-ID: <02fc8ecc-c8d9-94cc-6eef-a1e9d83742ad@southpole.se>
In-Reply-To: <f72e9541-7cdd-d93b-0872-92488be71dbc@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0926862587278342004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 04:28 PM, Jonas Bonn wrote:
> On 04/11/2017 11:21 PM, Denis Kenzior wrote:
>> Hi Jonas,
>>
>> On 04/11/2017 03:48 PM, Jonas Bonn wrote:
>>> Hi Denis,
>>>
>>> On 04/11/2017 07:07 PM, Denis Kenzior wrote:
>>>> On 04/11/2017 03:18 AM, Jonas Bonn wrote:
>>>>> The LTE atom should watch the network status and automatically =

>>>>> activate
>>>>> the default bearer when the modem becomes registered to the LTE =

>>>>> network.
>>>>>
>>>>> This patch adds a device callback, activate_default_bearer(), to =

>>>>> allow
>>>>> the device to start networking.
>>>>
>>>> Nope, we're not doing it this way.  Once we're attached to LTE there's
>>>> no need to activate a default bearer.  It is already active. The
>>>> modem should tell us that this is the case.
>>>>
>>>> Another issue is that the network is free to ignore our default bearer
>>>> setting, so you might be activating (or trying to) yet another =

>>>> context.
>>>>
>>>> Doesn't QMI provide an equivalent of +CGEV?
>>>
>>> I haven't found an equivalent.  Right now it looks to me as though the
>>> only way to set up a PDP context is to call the "Start Networking"
>>> method.  If I don't start networking, the packet status callback never
>>> gives me a "connected" status.  It's not enough to just power on the
>>> modem... although that does get me registered to the network.
>>
>> QMI is an ancient protocol, so maybe it simply didn't get extended =

>> for LTE.  Or we just don't know how to drive it properly.  Is there =

>> an AT channel ?  Does that one report anything related to CGEV?
>>
>>>
>>> Furthermore, it doesn't matter what APN I use, I always get a usable
>>> data-connection.  "Get Settings" never returns an APN string, either,
>>> which makes me that the network is ignoring my setting altogether and
>>> just giving me a default bearer...???
>>
>> The network is ultimately responsible for allocating an APN.  It =

>> could be blank or null or whatever.  Or maybe we don't know the right =

>> magic incantation.
>
> Alright, I'm going to explain my understanding of how this works:
>
> When the QMI modem registers to an LTE network, it negotiates a =

> default bearer using the "default settings".  The default settings are =

> taken from the QMI WDS "default profile" which is presumably profile 1 =

> by default.
>
> Even though the network registration has taken place and the bearer is =

> in place, the QMI modem doesn't bring up the network interface. =

> Calling "get current settings" at this point gives you nothing.
>
> At this point, you need to bring up the network interface by calling =

> "Start network".  Start network takes a bunch of parameters but these =

> parameters are all ignored since the bearer is already set up.
>
> I haven't tested this, but I suspect that calling "Start network" for =

> the same profile again will fail...???  A profile number corresponds =

> to a Context ID...???  Maybe...

I tested this and "start network" fails when attempting to connect a =

profile a second time.

>
> If you need a specific setting for the default bearer (like APN), you =

> need to set it in the default profile before registering to the =

> network.  This is what the LTE atom must take care of... and, hence, =

> the atom must be created
> before setting the modem online.
>
> For non-LTE, the bearer isn't set up until "Start network" is called, =

> so the usual context parameters can be passed to it at that time.  Any =

> parameters that are omitted are taken from the default profile.
>
> Given all of the above, for QMI this means:
>
> i)  When the netreg atom detects registration to an LTE network then =

> we can call "Start network" immediately.
> ii)  Start network will give us the packet-handle for the default =

> bearer.  This can be held by the netreg atom.
> iii)  The packet handle survives until the network becomes =

> unregistered (even through a transition to UMTS,GPRS,etc networks).
> iv)  There is never any reason to call "Stop network" for the default =

> bearer because a network unregistration will achieve the same thing.  =

> If the network becomes unregistered we can throw away the packet =

> handle.  The gprs-context associated with the default bearer won't =

> know the packet-handle, so we need to make sure it doesn't try to call =

> "Stop network" for it's instance... but that's a detail, I think.
Point iv) is wrong... we need to release the packet handle using "stop =

network" when the bearer goes away.

/Jonas

> It seems that there exists a method to change the default profile =

> number... it's undocumented, though, AFAICT.
>
> What's a bit unclear to me, though, is how this interacts with network =

> technology transitions... what happens when I move out of LTE coverage =

> and into a UMTS/GPRS network?
>
> Questions?  Feedback appreciated...
> /Jonas
>


--===============0926862587278342004==--

