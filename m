Content-Type: multipart/mixed; boundary="===============3098102133878968322=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono running on new Freerunner distribution
Date: Mon, 23 Nov 2009 19:58:50 -0600
Message-ID: <200911231958.51455.denkenz@gmail.com>
In-Reply-To: <200911231505.18505.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3098102133878968322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This seems to be a peculiarity of the Calypso modem.  When using ATD on an
> uninitialized port the ATD returns immediately.  This means that
> dialing/alerting calls can be hung up.  However, we use CPI indications a=
nd
> for some reason the ATD behavior changes when this is used.  ATD now only
> returns when a call connects, which means we can't hangup dialing/alerting
> calls, as you point out.  There are a couple of solutions we can try, stay
> tuned.

I pushed an experimental fix.  Let me know if you can now hangup alerting =

calls.  It did not make it into release 0.11 though.

Regards,
-Denis

--===============3098102133878968322==--

