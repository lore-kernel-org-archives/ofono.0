Content-Type: multipart/mixed; boundary="===============9167269379579124122=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 08/20] sms: document the org.ofono.SMSMessage D-Bus
 interface
Date: Mon, 26 Jul 2010 13:05:54 -0500
Message-ID: <4C4DCE82.7090700@gmail.com>
In-Reply-To: <1280164758.26204.157.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9167269379579124122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>>> +SMS / Messaging interface
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>> +
>>> +Service		org.ofono
>>> +Interface	org.ofono.SMSMessage
>>
>> oFono API is full CamelCase, so this should be SmsMessage.
> =

> I disagree. It would be like that if SMS was a word, but it is an
> acronym. It makes it quite confusing, if you ask me. If that's still how
> you like it, I'll change it, but I think it is wrong to capitalize an
> acronym.
> =


Your objection has been noted.  However, pure camel case looks nicer and
that is how most of the API already is (e.g. SmsManager, SimManager,
UnlockPin, etc)  So please change it or name it simply 'Message'.

Regards,
-Denis

--===============9167269379579124122==--

