Content-Type: multipart/mixed; boundary="===============8994890873702356483=="
MIME-Version: 1.0
From: Naresh Mehta <nareshtechs@gmail.com>
Subject: Re: Ofono - Quering PIN authentication state failed
Date: Wed, 26 May 2010 12:05:32 +0200
Message-ID: <AANLkTilrDCmb5s735_01prvlHfsT-qS5GNZ2Q6_QexiY@mail.gmail.com>
In-Reply-To: <201005250936.45180.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8994890873702356483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> It might help to tell us what modem you're using.
>
I am trying to use an ST-Ericsson modem. I think I might have a
wrong/non-functional (for this purpose) build flashled. I will try
again with a supposedly correct one.
> >
> > Below is the sequence of prints that I get on the daemon terminal after=
 I
> > execute enable-modem in another terminal:
> >
> > sudo ./src/ofonod -n -d 'plugins/*'
> > ofonod[8592]: oFono version 0.20
> > ofonod[8592]: plugins/atgen.c:atgen_enable() 0x93e9418
> > ofonod[8592]: plugins/atgen.c:atgen_pre_sim() 0x93e9418
> > ofonod[8592]: Querying PIN authentication state failed
> > ofonod[8592]: Querying PIN authentication state failed
>
> Also, please setenv / export OFONO_AT_DEBUG=3D1 so that we can see the AT=
 chat
> log.
>
I have exported that variable. There are no AT Chat logs printed since
the modem does not initialize (my guess). In the meantime, I tried
with ofono-phonesim and things have started working (atleast in
simulated environment). I had some problems initially to get the
phonesim working, mainly had to guess the argument list. But now that
things are rolling I am a bit more confident going ahead with my
experiments. I am thinking of writing a README for phonesim. Do you
think it will help somehow?

BTW, all the test scripts by default activate the modem[0] config so
it is not possible to have 2 modems connected and tested through those
scripts.

Do you think it might be an addition to modify the scripts to act
interactively for modem selection?

> > The problem that I have is that I can't see any more interfaces in eith=
er
> > the /generic or / path. The only interfaces it shows on / is
> > org.ofon.Manager. And on /generic it shows org.ofono.Modem and
> > org.ofono.SimManager. I saw the SimManager methods and since there is no
> > =C2=A0PIN set, I should be able to see further interfaces like VoiceCal=
lManager
> > =C2=A0and SmsManager. But I am not able to see that.
>
> It might be that voicecall atom fails its initialization as well, the AT =
chat
> log should help.
>


> Regards,
> -Denis

Thanks for your help once again. And I might bug again :).

--

BR; Naresh

visit me at:
http://www.naresh.se/

--===============8994890873702356483==--

