Content-Type: multipart/mixed; boundary="===============6376151453469592635=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call counters proposal (TODO patch)
Date: Mon, 25 Oct 2010 17:19:12 -0500
Message-ID: <4CC60260.7010501@gmail.com>
In-Reply-To: <AANLkTinMPwjA1bSfWtZdP8Mfx7rSENXsVNNX3T7k_HJf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6376151453469592635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 10/25/2010 02:43 PM, Aki Niemi wrote:
> Hi,
> =

> 2010/10/25 Marcel Holtmann <marcel@holtmann.org>:
>>> I am proposing adding Call counters to Voicecall. Here is the TODO patc=
h:
>>>
>>> diff --git a/TODO b/TODO
>>> index d9a6580..89e180c 100644
>>> --- a/TODO
>>> +++ b/TODO
>>> @@ -329,6 +329,15 @@ Voicecall
>>>     Complexity: C2
>>>     Owner: Pekka Pessi <pekka.pessi@nokia.com>
>>>
>>> +- Call counters. Provide total outgoing and incoming call duration
>>> information.
>>> +  Separate call counters will be maintained for each SIM card. Call
>>> counters
>>> +  can be read and reset to 0, and must be backed up periodically to a
>>> +  non-volatile storage place.
>>
>> what is wrong with using the history plugin API and working towards a
>> bridge to get these information into tracker.
> =

> I think what Andras is suggesting here are per-IMSI properties. This
> can be done as a history plugin, sure, but probably a more natural
> place would be the voicecall atom.

voicecall atom is already pretty complicated, so if possible this should
be done outside of the voicecall atom.  Or does the call tracking
require access to the call state information that history api does not
provide?

Regards,
-Denis

--===============6376151453469592635==--

