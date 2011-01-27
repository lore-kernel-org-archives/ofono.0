Content-Type: multipart/mixed; boundary="===============2578314928673041709=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC] voicecallmanager-api: call related SS signals (proposal)
Date: Thu, 27 Jan 2011 17:54:03 +0200
Message-ID: <4D41951B.4000808@nokia.com>
In-Reply-To: <1296133657.1520.145.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2578314928673041709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/27/2011 03:07 PM, ext Marcel Holtmann wrote:
> Hi Andras,
>
>> Here is a proposal for expanding VoiceCallManager's DBus interface with
>> call related Supplementary Services signals.
>> The implementation would be based on the functionality provided by the S=
SN
>> atom (handling the CSSU codes).
>>
>> ---
>>   doc/voicecallmanager-api.txt |   54 ++++++++++++++++++++++++++++++++++=
+++++++-
>>   1 files changed, 53 insertions(+), 1 deletions(-)
>>
>> diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
>> index 2bf9ded..5212eac 100644
>> --- a/doc/voicecallmanager-api.txt
>> +++ b/doc/voicecallmanager-api.txt
>> @@ -123,7 +123,59 @@ Methods		dict GetProperties()
>>   			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
>>   			typically not used in normal circumstances.
>>
>> -Signals		CallAdded(object path, dict properties)
>> +Signals		CallForwarded(object path)
>> +
>> +			Signal sent during call setup when the incoming call is
>> +			a forwarded call. The signal contains the object path of
>> +			the call in cause.
> I don't like this even a single bit. We changed the voice call API
> exactly this way to avoid any potential race conditions between calls
> and their properties. So please leave this as CallAdded() with the
> object path and its properties.
>
> Also having to watch more than three signals for call handling is a bit
> overboard. This will cause a lot of extra traffic during setup towards
> the D-Bus daemon. Pretty much a bad idea.

I agree, it seems better to have the various call related Supplementary
Services indications coming from the network be treated as voice call
properties.

The informations carried in SS indications coming from the network
during an MT call setup can be easily bound to the right call instance
(is the call being instantiated) and have them show up in the CallAdded
signal as properties. But then there are the indications sent during a
voice call, like when a call is put on hold or retrieved from held state by
the remote party, cases in which there is no information about what is
the targeted call instance, the SSN notifications are not providing this =

info.
This  becomes a problem when there are multiple calls since it is not
possible to determine to which call instance the indication is referring to.
This raises the question where/how to show this type of properties?

> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
Regards,
Andras

--===============2578314928673041709==--

