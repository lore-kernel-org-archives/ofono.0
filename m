Content-Type: multipart/mixed; boundary="===============7905548938866665454=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] voicecall: fix callheld indicator for PTS
Date: Tue, 19 Jul 2011 11:19:50 -0500
Message-ID: <4E25AEA6.60508@gmail.com>
In-Reply-To: <1311091847-7900-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7905548938866665454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 07/19/2011 11:10 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> Fix PTS test TP/TWC/BV-03-I [Call Waiting- Hold Active/Retrieve
> Waiting Call or Held].
> =

> PTS test fails after receiving intermediate update of callheld indicator
> with value 0 (no held call) before it receives update to value 1
> (active and held calls). This is due to the non-atomic update of calls
> status after call swap (moving first call to active state before moving
> second one to hold state).
> =

> HFP 1.5 spec specifies that an update of callheld indicator to 1 should
> be sent after AT+CHLD=3D2 command.
> As oFono emulator sends +CIEV only if the indicator value changes, we
> need to use an intermediate state for callheld indicator (2, all calls on
> hold).
> =

> So, in case of multiple active calls, or an active call with an active
> mutiparty call, force update of callheld indicator to 2.
> ---
>  src/voicecall.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7905548938866665454==--

