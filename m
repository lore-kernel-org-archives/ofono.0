Content-Type: multipart/mixed; boundary="===============6649629278848157248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Terminating emergency calls
Date: Fri, 13 Aug 2010 14:05:51 -0500
Message-ID: <4C65978F.4000601@gmail.com>
In-Reply-To: <AANLkTiktt2fgxpRyg__p+f__K2gYx3kVLEXM30sfCFQf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6649629278848157248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>>> I have to verify this with some of my colleagues, but I am pretty sure
>>> emergency calls cannot be applied to the AT+CHLD command. i.e. they
>>> cannot be part of mpty.
> =

> Initial testing on STE modem indicates that emergency call cannot
> participate in multi call or be put on hold.

What about a somewhat backdoor of putting call on hold on some modems:
If a call is active, and you dial another call, the active call is
automatically put on hold.  So if an emergency call is active and we
dial another number, what happens?

> =

>>
>> If emergency calls cannot be part of mpty call, we can use either hangup=
_all or
>> hangup_active as Denis said. However, your suggested fix will break mult=
iparty call
>> scenario since multiparty_hangup calls voicecall_release_next as well.
> =

> Yes, you're right using hangup_active will terminate all active calls
> participating in a multi call.
> So my proposal will not work as is. Maybe we need to know if
> release_next was called for multi call?

I have commited a fix for this that I think should work just fine.  Can
you please check bab23b39767b664061ac2bcba747fe2b96561ca7 and let me
know if it solves the issue?

Regards,
-Denis

--===============6649629278848157248==--

