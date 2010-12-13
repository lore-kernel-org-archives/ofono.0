Content-Type: multipart/mixed; boundary="===============6694447055449733806=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Mon, 13 Dec 2010 08:56:56 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D0963380@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <201012110157.04661.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6694447055449733806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 11 Dec 2010, Denis-Courmont Remi wrote:
>> let me repeat my question here. Does this suppose to be represent spent
>> time on calls (what I called talk time) or actual billing minutes.
> =

> As said earlier, this is about the talk time. The scenario is a user
> ejects the battery during an already long-standing call or gets the devic=
e =

> to crash or reset, gets billed, and comes and complain to its operator th=
at
> (s)he gets overcharged. The counters will be much more wrong if we do not =


I'm no longer sure what you guys mean with "billing minutes" and "talk
time" here, so maybe we should talk in terms of code. E.g. look
at the patches Andras sent to the list to see what is tracked and how:

- each call is tracked separately (e.g. counter still running for =

  held calls)
- tracking separately for MO/MT calls
- call starts when state goes to ACTIVE (from INCOMING/ALERTING/DIALING/WAI=
TING)
- call terminates to DISCONNECTED

In case of conflict, what's actually in Andras' patches =

overrides my interpretation above. ;)

This concept is already in oFono core (call->start_time is created
when calls start, and __ofono_history_call_ended is called when
calls end, matching the above).

> That said, I do believe the stored value has to be more precise than
> minutes.
> Otherwise per call "error" may add up far too quickly.

Yes, but I agree with Marcel that a 60sec update interval sounds
reasonable (so higher resolution for stored values, but updates
at e.g. every minute). Even better if the refresh rate can be tuned.


--===============6694447055449733806==--

