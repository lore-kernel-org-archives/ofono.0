Content-Type: multipart/mixed; boundary="===============1541369266133212451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bluetooth HF role
Date: Sat, 20 Aug 2011 21:13:47 -0500
Message-ID: <4E5069DB.4020006@gmail.com>
In-Reply-To: <4E5640F2.5010302@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1541369266133212451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 08/25/2011 07:32 AM, Mikel Astiz wrote:
> Hi Denis,
> =

> On 08/20/2011 11:00 AM, Denis Kenzior wrote:
>> Hi Mikel,
>>
>> On 08/24/2011 10:28 AM, Mikel Astiz wrote:
>>> Hi all,
>>>
>>> I'm trying to understand the features currently supported by oFono
>>> regarding the handsfree role in Bluetooth/HFP. My first impression
>>> looking at the source code is that some HFP functionality might be
>>> missing, but I would rather have your confirmation.
>>>
>> Correct, in general only features that map 1:1 to existing APIs are
>> exposed.  So that means network registration, voicecalls and call-volume
>> interfaces.
>>
>>> Some examples I've found so far are the following:
>>> 1. Response and hold (AT+BTRH=3D0)
>>> 2. Redial last number (AT+BLDN)
>>> 3. Retrieval of supported Bluetooth features for a certain modem/device
>>> (AT+BRSF)
>>>
>> BRSF is supported and used internally, but the information is not
>> exposed over D-Bus.
>>
>>> Could you clarify which (if any) of these features are currently
>>> supported by oFono?
>> Bluetooth specific features are not supported yet, these will require a
>> separate atom. Roughly this means anything starting with +B.. including:
>>     - +BINP
>>     - +BLDN
>>     - +BVRA
>>     - +NREC
>>     - +BSIR
>>     - +BTRH
>>
>>> In general, is there any documented list of unsupported features?
>>>
>> In general the TODO list is your best source of readily available
>> information.  In the case of HFP HF, there is no such documentation ;)
>> Patches adding tasks to the TODO list to support these features are
>> always welcome.
>>
>> Regards
>> -Denis
> =

> OK, thanks for the information.
> =

> Then I guess the next question is whether you have plans to support this
> in the future, or if you would accept patches in this direction. I'm
> afraid some of them could potentially affect the existing API.
> =


Patches are always welcome.  I'm not sure why you want to change the
existing API, sounds like most of these features belong to a new atom
interface, however I could be wrong.  Go ahead and send your proposal so
we have a starting point for the discussion.

Regards,
-Denis

--===============1541369266133212451==--

