Content-Type: multipart/mixed; boundary="===============4785014423282025839=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] [RfC] stk-api: Proposed Set Up Call api.
Date: Tue, 17 Aug 2010 17:42:04 +0200
Message-ID: <AANLkTimDpcPUxOBtpz3NMROGbVuyBy5TMgfDzTPcA6BN@mail.gmail.com>
In-Reply-To: <1282055945.23399.106.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4785014423282025839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 17 August 2010 16:39, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrew,
>
>> ---
>> =C2=A0doc/stk-api.txt | =C2=A0 15 +++++++++++++++
>> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
>> index 2e863a9..b85c7db 100644
>> --- a/doc/stk-api.txt
>> +++ b/doc/stk-api.txt
>> @@ -55,6 +55,14 @@ Signals =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Prop=
ertyChanged(string property, variant value)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Signal is emitted whenever a property has changed.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 The new value is passed as the signal argument.
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CallSetUp(string message, by=
te icon_id, object call)
>
> to be consistent this should be CallSetup(...)

They're not interchangeable though because setup is a noun, and in
this case we're notifying that "a call has been set up / is being set
up".

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Informs about a new VoiceCall that is being set
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
up as a result of a UICC request and gives the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
message associated with the call to be shown to
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
the user. =C2=A0Hanging-up the call before it is
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
connected will terminate the current session.
>> +
>> =C2=A0Properties =C2=A0 string IdleText
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Contains the text to be used when the home screen is
>> @@ -189,6 +197,13 @@ Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0byte Requ=
estSelection(string title, byte icon_id,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Possible Errors: [service].Error.SimToolkit.GoBack
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean ConfirmCallSetup(str=
ing message, byte icon_id)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Asks the agent to request user to confirm an
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
outgoing call setup.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Possible Errors: [service].Error.SimToolkit.EndSession
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void Cancel()
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Asks the agent to cancel any ongoing operation in
>
> Why do we need two handlers here. One signal and one agent callback. I
> do understand the agent callback. That is pretty obvious, but why do you
> also wanna send the signal as well. Would this be just go via the voice
> call interface and be transparent for the dialer?

This is a possiblity, I'm not very sure what would be the best option.
 The reason for the signal was so that the alpha id can be associated
with given VoiceCall object. (The same VoiceCall object will of course
be available in VoiceCallManager properties).

The timeline for call setup is something like:

 * Modem asks user for confirmation using icon1 / alphaId1.
 * User confirms
 * Modem starts dialling, screen displays icon2 / alphaId2,
 * Call is connected, modem replies to the proactive command, screen
keeps displaying icon2 / alphaId2 until the phone call is over.

Best regards

--===============4785014423282025839==--

