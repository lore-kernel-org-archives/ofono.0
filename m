Content-Type: multipart/mixed; boundary="===============7179572714646917523=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] emulator: fix CCWA for PTS
Date: Wed, 06 Jul 2011 04:40:21 -0500
Message-ID: <4E142D85.7060204@gmail.com>
In-Reply-To: <1309445574-9891-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7179572714646917523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 06/30/2011 09:52 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> During test TP/TCA/BV-05-I [Terminate Ongoing Call =E2=80=93 While Call W=
aiting]
> PTS fails if multiple +CCWA are sent (waiting for 1st phone number when
> waiting one becomes incoming, intead of 2nd phone number).
> So, send only 1 +CCWA.
> =

> Update RING timer management to be started as soon as an incoming call
> exists, and retrieve +CLIP info for incoming or waiting call (in case
> of waiting call becoming incoming call, call indicator changes before
> internal call status is updated)
> =

> Force to send +CCWA (if needed) on reception of AT+CCWA=3D1
> ---
>  src/emulator.c |   95 ++++++++++++++++++++++++++++++++++----------------=
-----
>  1 files changed, 59 insertions(+), 36 deletions(-)
> =


I applied this patch, but added a small refactoring commit afterwards to
make the logic a bit more readable.  Can you double check that I didn't
screw anything up?

Regards,
-Denis

--===============7179572714646917523==--

