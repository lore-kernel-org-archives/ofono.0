Content-Type: multipart/mixed; boundary="===============2007539600418808948=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Bluetooth HF role
Date: Thu, 08 Sep 2011 12:03:52 +0200
Message-ID: <4E689308.9060400@bmw-carit.de>
In-Reply-To: <4E687C55.5030807@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2007539600418808948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/08/2011 10:27 AM, Mikel Astiz wrote:
> Hi Denis,
>
> On 08/21/2011 04:13 AM, Denis Kenzior wrote:
>> Hi Mikel,
>>
>> On 08/25/2011 07:32 AM, Mikel Astiz wrote:
>>> Hi Denis,
>>>
>>> On 08/20/2011 11:00 AM, Denis Kenzior wrote:
>>>> Hi Mikel,
>>>>
>>>> On 08/24/2011 10:28 AM, Mikel Astiz wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm trying to understand the features currently supported by oFono
>>>>> regarding the handsfree role in Bluetooth/HFP. My first impression
>>>>> looking at the source code is that some HFP functionality might be
>>>>> missing, but I would rather have your confirmation.
>>>>>
>>>> Correct, in general only features that map 1:1 to existing APIs are
>>>> exposed.  So that means network registration, voicecalls and call-volu=
me
>>>> interfaces.
>>>>
>>>>> Some examples I've found so far are the following:
>>>>> 1. Response and hold (AT+BTRH=3D0)
>>>>> 2. Redial last number (AT+BLDN)
>>>>> 3. Retrieval of supported Bluetooth features for a certain modem/devi=
ce
>>>>> (AT+BRSF)
>>>>>
>>>> BRSF is supported and used internally, but the information is not
>>>> exposed over D-Bus.
>>>>
>>>>> Could you clarify which (if any) of these features are currently
>>>>> supported by oFono?
>>>> Bluetooth specific features are not supported yet, these will require a
>>>> separate atom. Roughly this means anything starting with +B.. includin=
g:
>>>>       - +BINP
>>>>       - +BLDN
>>>>       - +BVRA
>>>>       - +NREC
>>>>       - +BSIR
>>>>       - +BTRH
>>>>
>>>>> In general, is there any documented list of unsupported features?
>>>>>
>>>> In general the TODO list is your best source of readily available
>>>> information.  In the case of HFP HF, there is no such documentation ;)
>>>> Patches adding tasks to the TODO list to support these features are
>>>> always welcome.
>>>>
>>>> Regards
>>>> -Denis
>>> OK, thanks for the information.
>>>
>>> Then I guess the next question is whether you have plans to support this
>>> in the future, or if you would accept patches in this direction. I'm
>>> afraid some of them could potentially affect the existing API.
>>>
>> Patches are always welcome.  I'm not sure why you want to change the
>> existing API, sounds like most of these features belong to a new atom
>> interface, however I could be wrong.  Go ahead and send your proposal so
>> we have a starting point for the discussion.
>>
>> Regards,
>> -Denis
> Before discussing the source code itself, I would like to know your
> opinion about the different alternatives that come into my mind.
>
> When you talk about a new atom interface, we could:
>
> a. Create an HFP interface that includes all bluetooth-specific
> extensions. This could something like org.ofono.Handsfree or
> org.ofono.HfpModem.
> b. Be more consistent with the existing oFono API and split the new
> extensions into several interfaces, such as org.ofono.hfp.Modem and
> org.ofono.hfp.VoiceCallManager (and whatever else is needed). This
> second interface would support methods such as Redial() and AnswerAndHold=
().
> c. If this second approach of hfp.VoiceCallManager is followed, we could
> not only include the extensions there, but also replicate the whole API
> in org.ofono.VoiceCallManager. Personally I would rather not do this,
> but it seems to me that org.ofono.cdma.CdmaVoiceCallManager has been
> designed that way.
>
> My vote would be in favor of the first option, for the sake of simplicity.
>
> What do you think? Any other alternative?

I forgot to add that another alternative would be to merge voice-call =

related extensions in the existing API. For example, by adding the =

method Redial() in org.ofono.VoiceCallManager, and extending the =

semantics of SwapCalls() to put incoming calls on hold.

Regards,
Mikel


--===============2007539600418808948==--

