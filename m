Content-Type: multipart/mixed; boundary="===============5604525627476575451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: signal sim inserted when sim ready.
Date: Mon, 17 Dec 2012 10:17:00 -0600
Message-ID: <50CF457C.5030201@gmail.com>
In-Reply-To: <50CF434D.6060305@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5604525627476575451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

> I also realised that we only get #QSS: 1 iff a PIN is required, i.e. the
> modem firmware is doing the +CPIN query implicitly for us.
> If there is no PIN required we always get #QSS: 2 (SIM UNLOCKED) instead
> of #QSS: 1.
> Better leave the PIN querying or would you remove it?

If this behavior is consistent, then just get rid of CPIN query.  We can =

always add it back later if we really need it.

Regards,
-Denis

--===============5604525627476575451==--

