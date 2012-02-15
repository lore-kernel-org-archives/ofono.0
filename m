Content-Type: multipart/mixed; boundary="===============8627377680274006517=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] emulator: Fix start of RING event
Date: Wed, 15 Feb 2012 05:27:47 -0600
Message-ID: <4F3B96B3.1060202@gmail.com>
In-Reply-To: <1328796763-9777-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8627377680274006517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

On 02/09/2012 08:12 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> RING event should only be sent when callsetup indicator is set to
> Incoming and there is no active call.
> =

> If call indicator is set to inactive while callsetup is
> already set to Incoming (waiting call has generated +CCWA),
> no RING event should be sent.
> =

> Ref.: PTS test TC_AG_TWC_BV_02_I
> ---
>  src/emulator.c |   18 +++---------------
>  1 files changed, 3 insertions(+), 15 deletions(-)
> =


After looking at the test case, it seems to be dealing with testing the
consequences of CHLD=3D1.  Essentially dropping the current active call
and accepting the waiting call.  The logic you're changing is also
dealing with a slightly different case, namely if the active call is
dropped by the remote party during a waiting call.

In the case of CHLD=3D1, the sequence should be one of these:

1. Active Call Index -> Disconnected, Waiting call Index -> Active

In the case of remote party dropping the Active call, the sequences can be:

1. Active Call Index -> Disconnected, Waiting Call Index -> Incoming

The logic has to be modified to handle the transition state (e.g. call
indicator going from 1 to 0, and waiting call present) and send the
proper indicators when the final state is reached.  Likely our handling
of the 'waiting' variable is incorrect, we cannot rely on the values of
callsetup and call, but instead should try to find any calls in the
'WAITING' state.

I believe that sending a call=3D0, then callsetup=3D0, call=3D1 is acceptab=
le,
but ideally in the case of CHLD=3D1 we should be sending callsetup=3D0 only.

Regards,
-Denis

--===============8627377680274006517==--

