Content-Type: multipart/mixed; boundary="===============0643631604491841129=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v3 3/3] modem: add support to restore state when
 resetting the modem
Date: Tue, 23 Nov 2010 16:07:31 -0600
Message-ID: <4CEC3B23.6040404@gmail.com>
In-Reply-To: <20101123213324.GF22502@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0643631604491841129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

>>>
>>> It also seems that the 'reset' value is not really needed.
>>
>> I'm using that to avoid emit DBus signal during the silent reset, Not
>> seeing how to do that without modem->reset, maybe we can rely on
>> modem->pending, not sure yet. =

> =

> Or do you mean that have DBus signaling about Powered and Online during
> silent reset is just fine? That is starting to make sense to me. We may
> want to notify users that the modem is not there.
> =


I actually think that emitting powered / online going on and off is
okay, there's no real way to hide this since all the atoms have to be
re-initialized.  So all the interfaces go away and magically re-appear,
all properties are re-emitted, etc.  Not emitting Powered or Online is
the least of our worries.

Silent resets are really just about avoiding having the user re-enter
the PIN when the modem crashes.

Regards,
-Denis

--===============0643631604491841129==--

