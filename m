Content-Type: multipart/mixed; boundary="===============3742264198596896630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/lte: proto and authentication handling
Date: Wed, 24 Oct 2018 22:06:09 -0500
Message-ID: <585d221c-7ae8-8635-857f-e6c08730f93d@gmail.com>
In-Reply-To: <CAKSBH7Fbsr_bntKrXmkYTGWWR1xpZv9KZwVbq83ZwNmh-9Cb5g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3742264198596896630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>> There is very strict separation between driver managed memory /
>> structures and ones owned by the core.
> =

> Thank you for the clarification, now I understand.
> =

> And yes, it is indeed the 3rd time you point it out.
> I hope it is the last one, but it is easy to fall for this,
> there should be some mechanism to either prevent it or guarantee that

There is: you scribble the data you need into the part of memory you =

control.  Easy.

> the object is persistent.

We're not changing the entire driver<->core model just because you find =

it inconvenient ;)

Regards,
-Denis

--===============3742264198596896630==--

