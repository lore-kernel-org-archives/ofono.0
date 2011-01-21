Content-Type: multipart/mixed; boundary="===============5334297988299301998=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem: fix issue with user busy release
Date: Fri, 21 Jan 2011 15:19:06 +0200
Message-ID: <AANLkTi=SLmwcr6__BTwrPy4Wx0MmzF=GdEBFD4TJYYLO@mail.gmail.com>
In-Reply-To: <1295598270-13244-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5334297988299301998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

2011/1/21 Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>:
> when the user rejects the incoming call, hangup_active
> will get called on the driver side whereas when the user
> rejects the waiting call, set_udub will get called on the
> driver side.
> ---
> =C2=A0drivers/isimodem/voicecall.c | =C2=A0 13 +++++++++----
> =C2=A01 files changed, 9 insertions(+), 4 deletions(-)

Patch has been pushed, thanks!

Cheers,
Aki

--===============5334297988299301998==--

