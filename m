Content-Type: multipart/mixed; boundary="===============2117170875188110991=="
MIME-Version: 1.0
From: Thiago Cangussu de Castro Gomes <thiagoc@syst.com.br>
Subject: Re: Connecting with Huawei E226
Date: Wed, 18 Aug 2010 11:06:25 -0300
Message-ID: <AANLkTinVWfb22rdDprxbbbGKY-fB9kywbTrNBNHxsi-8@mail.gmail.com>
In-Reply-To: <4C6B3B29.1010109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2117170875188110991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2010 at 10:45 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>
> > I'm trying to connect with a Huawei E226, but I'm getting
> > different behavior whether I start ofonod with the modem (USB) plugged
> > in or not:
> >
> > Scenario 1:
> >
> > 1 - start ofonod
> > 2 - plug the modem
> > 3 - not working
> >
> > Log: huawei-connected.log (attached)
> >
> > Scenario 2:
> >
> > 1 - start ofonod
> > 2 - plug the modem
> > 3 - call disable-modem
> > 4 - call enable-modem
> > 5 - it works
> >
> > Log: huawei-testscripts.log
> >
> > Scenario 3:
> >
> > 1 - plug the modem
> > 2 - start ofonod
> > 3 - it works
> >
> > Log file: huawei-not-connected.log
> >
> > I'm testing with MeeGo, ofono from git and connman 0.57.
>
> The problem with the failed cases it that oFono / ConnMan combination is
> simply too fast. =C2=A0It tries to access the Modem before it had the cha=
nce
> to properly initialize the SIM card. =C2=A0We have pushed some fixes upst=
ream
> after the 0.26 release that should alleviate this.

Thanks for the response. You are right, I can reproduce the problem
even with connman turned off, by calling the test scripts before the
modem is ready.

I'm using both ofono and connman from git, with all the available
updates so far. Does it mean that the fixes didn't solved the issue in
my case? Could you point me to the patches?

Thanks,
Thiago

--===============2117170875188110991==--

