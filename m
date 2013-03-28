Content-Type: multipart/mixed; boundary="===============9069810949355309772=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 14:41:35 -0500
Message-ID: <51549CEF.3070906@gmail.com>
In-Reply-To: <CAAs3wMjr-0xrGo_JML1ZtDLqd+Dt_=VYXTy8Ob3nK8RMWGEXeg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9069810949355309772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi ,
> got new information. I start gdb and backtrace and i found where is the
> seg fault. The function "decode_at_error"  doesn't check if *error or
> *final are NULL... and in my case they are.
> if  I put a check in the function it remains stuck waiting AT cmd reply..=
..
>

The wakeup logic should only be used with the Freerunner.  Please =

disable it unless you know what you're doing.  Something else is wrong.

Regards,
-Denis

--===============9069810949355309772==--

