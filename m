Content-Type: multipart/mixed; boundary="===============8929205249914265167=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Call counters proposal (TODO patch)
Date: Mon, 25 Oct 2010 22:43:46 +0300
Message-ID: <AANLkTinMPwjA1bSfWtZdP8Mfx7rSENXsVNNX3T7k_HJf@mail.gmail.com>
In-Reply-To: <1288016698.3613.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8929205249914265167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/10/25 Marcel Holtmann <marcel@holtmann.org>:
>> I am proposing adding Call counters to Voicecall. Here is the TODO patch:
>>
>> diff --git a/TODO b/TODO
>> index d9a6580..89e180c 100644
>> --- a/TODO
>> +++ b/TODO
>> @@ -329,6 +329,15 @@ Voicecall
>> =C2=A0 =C2=A0 Complexity: C2
>> =C2=A0 =C2=A0 Owner: Pekka Pessi <pekka.pessi@nokia.com>
>>
>> +- Call counters. Provide total outgoing and incoming call duration
>> information.
>> + =C2=A0Separate call counters will be maintained for each SIM card. Call
>> counters
>> + =C2=A0can be read and reset to 0, and must be backed up periodically t=
o a
>> + =C2=A0non-volatile storage place.
>
> what is wrong with using the history plugin API and working towards a
> bridge to get these information into tracker.

I think what Andras is suggesting here are per-IMSI properties. This
can be done as a history plugin, sure, but probably a more natural
place would be the voicecall atom.

Cheers,
Aki

--===============8929205249914265167==--

