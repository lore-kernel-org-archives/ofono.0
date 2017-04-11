Content-Type: multipart/mixed; boundary="===============6727588181234049912=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Tue, 11 Apr 2017 16:21:31 -0500
Message-ID: <d1022bb7-9924-cb10-c653-54a6c85a3f6c@gmail.com>
In-Reply-To: <03d7a73f-be7d-6c2f-8016-d5a8478f0e56@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6727588181234049912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/11/2017 03:48 PM, Jonas Bonn wrote:
> Hi Denis,
>
> On 04/11/2017 07:07 PM, Denis Kenzior wrote:
>> On 04/11/2017 03:18 AM, Jonas Bonn wrote:
>>> The LTE atom should watch the network status and automatically activate
>>> the default bearer when the modem becomes registered to the LTE network.
>>>
>>> This patch adds a device callback, activate_default_bearer(), to allow
>>> the device to start networking.
>>
>> Nope, we're not doing it this way.  Once we're attached to LTE there's
>> no need to activate a default bearer.  It is already active.  The
>> modem should tell us that this is the case.
>>
>> Another issue is that the network is free to ignore our default bearer
>> setting, so you might be activating (or trying to) yet another context.
>>
>> Doesn't QMI provide an equivalent of +CGEV?
>
> I haven't found an equivalent.  Right now it looks to me as though the
> only way to set up a PDP context is to call the "Start Networking"
> method.  If I don't start networking, the packet status callback never
> gives me a "connected" status.  It's not enough to just power on the
> modem... although that does get me registered to the network.

QMI is an ancient protocol, so maybe it simply didn't get extended for =

LTE.  Or we just don't know how to drive it properly.  Is there an AT =

channel ?  Does that one report anything related to CGEV?

>
> Furthermore, it doesn't matter what APN I use, I always get a usable
> data-connection.  "Get Settings" never returns an APN string, either,
> which makes me that the network is ignoring my setting altogether and
> just giving me a default bearer...???

The network is ultimately responsible for allocating an APN.  It could =

be blank or null or whatever.  Or maybe we don't know the right magic =

incantation.

Regards,
-Denis

--===============6727588181234049912==--

