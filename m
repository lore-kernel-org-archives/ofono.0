Content-Type: multipart/mixed; boundary="===============7010922705698090595=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: Terminating emergency calls
Date: Mon, 16 Aug 2010 14:55:13 +0200
Message-ID: <AANLkTi=BOv9QdZoOdEdKbdVZRroVqXNS6rESX_dLW+UP@mail.gmail.com>
In-Reply-To: <4C65978F.4000601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7010922705698090595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Sjur,
>
>>>> I have to verify this with some of my colleagues, but I am pretty sure
>>>> emergency calls cannot be applied to the AT+CHLD command. i.e. they
>>>> cannot be part of mpty.
>>
>> Initial testing on STE modem indicates that emergency call cannot
>> participate in multi call or be put on hold.
>
> What about a somewhat backdoor of putting call on hold on some modems:
> If a call is active, and you dial another call, the active call is
> automatically put on hold. =C2=A0So if an emergency call is active and we
> dial another number, what happens?

On the STE modem I get NO CARRIER if I try to put an emergency call on
hold this way.
fonod[27624]: > ATD911;\r
ofonod[27624]: < \r\nOK\r\n
...
ofonod[27624]: > ATD+4425993004494;\r
ofonod[27624]: < \r\nNO CARRIER\r\n

However the other way around works, by having a normal call and then
dialing an emergency number
puts the regular call on hold.

...
>> Yes, you're right using hangup_active will terminate all active calls
>> participating in a multi call.
>> So my proposal will not work as is. Maybe we need to know if
>> release_next was called for multi call?
>
> I have commited a fix for this that I think should work just fine. =C2=A0=
Can
> you please check bab23b39767b664061ac2bcba747fe2b96561ca7 and let me
> know if it solves the issue?

Yes, it does. I can now use hangup_all on an emergency call :-)

I think this closes the last voice call issue for STE modems (for now).

Regards
Sjur

--===============7010922705698090595==--

