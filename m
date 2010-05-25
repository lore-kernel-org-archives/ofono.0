Content-Type: multipart/mixed; boundary="===============0953018132659634605=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono - Quering PIN authentication state failed
Date: Tue, 25 May 2010 09:36:44 -0500
Message-ID: <201005250936.45180.denkenz@gmail.com>
In-Reply-To: <AANLkTinqHj40b3H0Zjg2ecS_3Ttzb0fqz-2N1Q1KoP-j@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0953018132659634605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

> Hi All,
> =

> I am new to Ofono development but am very interested in checking it out a=
nd
> see if I can contribute with something. I have pulled the ofono source and
> am able to build the daemon. I have also been able to connect to the
> AT-Modem interface on /generic (as defined in the modem.conf) file.

It might help to tell us what modem you're using.

> =

> Below is the sequence of prints that I get on the daemon terminal after I
> execute enable-modem in another terminal:
> =

> sudo ./src/ofonod -n -d 'plugins/*'
> ofonod[8592]: oFono version 0.20
> ofonod[8592]: plugins/atgen.c:atgen_enable() 0x93e9418
> ofonod[8592]: plugins/atgen.c:atgen_pre_sim() 0x93e9418
> ofonod[8592]: Querying PIN authentication state failed
> ofonod[8592]: Querying PIN authentication state failed

Also, please setenv / export OFONO_AT_DEBUG=3D1 so that we can see the AT c=
hat =

log.

> The problem that I have is that I can't see any more interfaces in either
> the /generic or / path. The only interfaces it shows on / is
> org.ofon.Manager. And on /generic it shows org.ofono.Modem and
> org.ofono.SimManager. I saw the SimManager methods and since there is no
>  PIN set, I should be able to see further interfaces like VoiceCallManager
>  and SmsManager. But I am not able to see that.

It might be that voicecall atom fails its initialization as well, the AT ch=
at =

log should help.

Regards,
-Denis

--===============0953018132659634605==--

