Content-Type: multipart/mixed; boundary="===============3121359473262699079=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC] Add agent API to message atom
Date: Tue, 31 Aug 2010 09:20:52 +0300
Message-ID: <AANLkTikEyMUfaHuPDFEsLx=ByaJLQ6VaxYipVeY0yYmh@mail.gmail.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8056A7653@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3121359473262699079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/8/31 Zhang, Caiwen <Caiwen.Zhang@windriver.com>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void RegisterApplicationAgen=
t(object path, uint dest, uint
>> src)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Registers an agent to receive application messages.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
The object path defines the path of the agent that
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
will be called when an application message is ready
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
to be dispatched.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
The dest parameter is the destination application
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
port number, and the src parameter is the optional
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
source application port number.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Possible Errors: [service].Error.InvalidArguments
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[service].Err=
or.InvalidFormat
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[service].Err=
or.InUse
>> +
> Push message is a kind of application message. If an agent register both
> RegisterPushAgent and RegisterApplicationAgent, will the message be proce=
ssed
> Twice. Will you offer same way to avoid this?

I think we'll just have a single ApplicationAgent interface that works
with app ports. I was thinking it would be elegant to be able to
register an agent only using the WAP app ID, but perhaps that's just a
waste of time.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void IncomingMessage(string =
message, dict info)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
New incoming text SMS received. =C2=A0Info has Sender,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
LocalSentTime, and SentTime information.
>> +
>
> Is the 'message' the text content of the income message(I mean the decode=
d user data)?

Just the body of the message (UTF-8 string), just like in the signals.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void IncomingPush(array{byte=
} message, dict info)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
New incoming push message received. =C2=A0Info has Sender,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
LocalSentTime, SentTime, and ApplicationId
>> information.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void IncomingApplication(arr=
ay{byte} message, dict info)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
New incoming application message received. =C2=A0Info has
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Sender, LocalSentTime, SentTime, DestinationPort, and
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
SourcePort information.
>> +
>
> Is the 'message' the whole PDU or only the user data?

The user data excluding the user data header, which we decode and
provide in the dict.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void Release()
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Agent is being released, possibly because of oFono
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
terminating, the MessageManager interface being torn
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
down or modem powering down.
>> --
>> 1.7.0.4
>>
>
> Will you consider send push message and application message?

Ah, good point. Yes, we obviously need to support sending binary
messages as well.

Cheers,
Aki

--===============3121359473262699079==--

