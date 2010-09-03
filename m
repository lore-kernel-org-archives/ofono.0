Content-Type: multipart/mixed; boundary="===============3282074311416655040=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 17:12:45 +0300
Message-ID: <1283523165.25646.35.camel@tucson.research.nokia.com>
In-Reply-To: <4C8100A0.4010804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3282074311416655040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-09-03 at 16:05 +0200, ext Denis Kenzior wrote:
> I see what you're doing now.  I'd rather you left out setting udhi in
> the dialect switch/case labels and changed this line to set UDHI to TRUE.

Ah, then I missed your point. Yes, it's better to set UDHI outside the
switch, I agree.

Cheers,
Aki


--===============3282074311416655040==--

