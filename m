Content-Type: multipart/mixed; boundary="===============4923659031733727338=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check if lock is locked after code changing attempt
Date: Wed, 12 Jan 2011 09:35:51 -0600
Message-ID: <4D2DCA57.4080206@gmail.com>
In-Reply-To: <20A4FB08D632914F9C09B9F05CBDF258192D753286@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4923659031733727338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> I don't particularly wish to use the retry counters. I was just thinking =
that same
> information ( PUK required ) could be deduced by counting the retries. =


To my knowledge you cannot.  Correct me if I'm wrong, but the retry
counters are stored on the SIM and the SIM can be removed, and later
re-inserted.  You would not know how the counters have been affected.

Regards,
-Denis

--===============4923659031733727338==--

