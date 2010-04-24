Content-Type: multipart/mixed; boundary="===============6926073017644732966=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix: clean-local target
Date: Sat, 24 Apr 2010 16:56:14 +0300
Message-ID: <k2n80fd4e751004240656l5c19dd46p7f46f898664b4fa6@mail.gmail.com>
In-Reply-To: <1272039918.22838.89.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6926073017644732966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 Marcel Holtmann <marcel@holtmann.org>:
>> @@ -426,5 +426,5 @@ include/ofono/%.h: include/%.h
>> -clean-local: include/ofono
>> - =C2=A0 =C2=A0 @$(RM) -r $<
>> +clean-local:
>> + =C2=A0 =C2=A0 $(RM) -rf include/ofono
>
> what is this trying to fix?

An error happening if you do make clean twice, or distclean followed
by clean. I have no idea what the original construct is trying to
achieve.

> And you removed the @ in front of the command.

I removed @ so it is consistent with Automake's clean rules. Other rm
commands are shown when you say make clean.

-- =

Pekka.Pessi mail at nokia.com

--===============6926073017644732966==--

