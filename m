Content-Type: multipart/mixed; boundary="===============0886404414948385616=="
MIME-Version: 1.0
From: DJDAS <djdas@djdas.net>
Subject: Re: oFono running on new Freerunner distribution
Date: Mon, 23 Nov 2009 16:20:37 +0100
Message-ID: <4B0AA845.1020100@djdas.net>
In-Reply-To: <4B0A754F.40601@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0886404414948385616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DJDAS ha scritto:
> Hi Denis,
>> Hi Dario,
>>  =

>>> Do I have to take the git code or these features are already in the
>>> current 0.10 version?
>>>     =

>>
>> This change was made after 0.10 was tagged.  So you'll need the git =

>> version.
>>
>>   =

>
> OK, I'm pulling from the git, I'll let you know ASAP.
> Bye,
> Dario.

GREAT!!!! It worked!!! :)
It registers in less than one minute! :)
I noticed I don't need to call the Register method of =

NetworkRegistration interface but I just need to power up the modem, is =

it ok?
I have another question but maybe it's my fault: I noticed if I want to =

hangup a call during its "alerting" state, I can't, the other party =

continues ringing even if I call the hangup method on the correct path ( =

/calypso0/voicecall01). What am I missing?
Thank you very much in advance, bye.
Bye,
Dario.


--===============0886404414948385616==--

