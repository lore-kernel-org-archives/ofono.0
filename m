Content-Type: multipart/mixed; boundary="===============0664649671641255855=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Connecting with Huawei E226
Date: Tue, 17 Aug 2010 20:45:13 -0500
Message-ID: <4C6B3B29.1010109@gmail.com>
In-Reply-To: <AANLkTin3h2nEwhgwYtEaJr9vy-nWK4bzcxhks2EeLeZj@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0664649671641255855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On 08/17/2010 03:31 PM, Thiago Cangussu de Castro Gomes wrote:
> Hi all,
> =

> I'm trying to connect with a Huawei E226, but I'm getting
> different behavior whether I start ofonod with the modem (USB) plugged
> in or not:
> =

> Scenario 1:
> =

> 1 - start ofonod
> 2 - plug the modem
> 3 - not working
> =

> Log: huawei-connected.log (attached)
> =

> Scenario 2:
> =

> 1 - start ofonod
> 2 - plug the modem
> 3 - call disable-modem
> 4 - call enable-modem
> 5 - it works
> =

> Log: huawei-testscripts.log
> =

> Scenario 3:
> =

> 1 - plug the modem
> 2 - start ofonod
> 3 - it works
> =

> Log file: huawei-not-connected.log
> =

> I'm testing with MeeGo, ofono from git and connman 0.57.

The problem with the failed cases it that oFono / ConnMan combination is
simply too fast.  It tries to access the Modem before it had the chance
to properly initialize the SIM card.  We have pushed some fixes upstream
after the 0.26 release that should alleviate this.

Regards,
-Denis

--===============0664649671641255855==--

