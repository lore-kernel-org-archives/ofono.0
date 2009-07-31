Content-Type: multipart/mixed; boundary="===============3672995745487790532=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Fix possible memory leak on SIM reading error.
Date: Fri, 31 Jul 2009 10:09:44 -0500
Message-ID: <200907311009.45230.denkenz@gmail.com>
In-Reply-To: <1248941132-13206-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3672995745487790532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> This would also stall the SIM op queue if there's a read error for a reco=
rd
> other than the first.  The other solution would be "goto next;" (keep
> reading further records).

Patch has been applied.

This really shouldn't happen in practice, but if it does, we should also lo=
ok =

to see if the read callback functions don't cleanup or don't behave properl=
y =

as a result of an error mid-stream.  It looks like at least sim_msisdn_read=
_cb =

might be affected.  Could you check?

Regards,
-Denis

--===============3672995745487790532==--

