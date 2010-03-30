Content-Type: multipart/mixed; boundary="===============5528853878724004945=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 14:36:00 +0300
Message-ID: <80fd4e751003300436i46cb721fv4b9c6e56113241a3@mail.gmail.com>
In-Reply-To: <201003291353.43404.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5528853878724004945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/29 Denis Kenzior <denkenz@gmail.com>:
>> However, then powering modem down, there are problems. The N900 modem
>> control needs to make difference between the state where the modem is
>> no more useful and the safe-to-exit state when the power off request
>> has been completed, modem has flushed its state to flash and given
>> some time to safely turn off the SIM card.
>
> So if I understand correctly, you are saying that once the powered=3Doff =
request
> has been sent down to the modem, no other requests are valid. =C2=A0In ot=
her words,
> oFono's current implementation does not remove the atoms until powered=3D=
off
> request succeeds (which might result in those atoms attempting operations=
),
> which is wrong.

That is also a problem. The other problem is that the party
controlling the modem power state is supposed to keep GPIO lines in
known position for a while after the modem has indicated it has been
powered down. In an N900 running maemo, a daemon called sscd does
that. sscd exits only after modem has been safely powered down during
reboot and shutdown. If ofonod does the controlling, it should hang
around after power off for a while, too.

Another solution is to use sscd-like daemon also with ofono (the oFono
Powered property would then just follow the power state of the modem).

>> Also, if an another SetProperty("Powered") call is made while the
>> driver is powering the modem on or off, the change is ignored. It
>> seems to me that we need more fine grained power control than just the
>> current boolean in the core, too.
>
> We reply with the busy error, you're correct. =C2=A0However, I don't real=
ly see
> anything better we can do here, do you have any suggestions?

Keep the target state around somewhere, or call enable/disable
regardless of the current state of the Powered property?

-- =

Pekka.Pessi mail at nokia.com

--===============5528853878724004945==--

