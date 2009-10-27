Content-Type: multipart/mixed; boundary="===============7398251705421960590=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RfC] Retry registering packet radio to home PLMN when available.
Date: Mon, 26 Oct 2009 19:06:58 -0500
Message-ID: <200910261906.58614.denkenz@gmail.com>
In-Reply-To: <1256577664-4459-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7398251705421960590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

So I took this patch and the two earlier patches and applied them.  Thanks.

> Instead of setting DataConnectionManager.Powered to false after
> failed attempts to register to home PLMN with packet radio when
> RoamingAllowed is false, wait for the home PLMN to become available
> retrying everytime the circuit switched radio manages to register
> to home PLMN.  The downside is if the circuit switched radio is off,
> we wait indefinitely.

So I decided to simplify things even further.  Before we can attach we must=
 be =

registered to the network (e.g. COPS issued), otherwise attach fails.  Sinc=
e =

we need netreg for this anyway, we might as well always rely on netreg's =

registration status to base our attach / detach decisions on.

To me this seems to be the most sensible way to approach this.  However, th=
is =

assumes that the modem can't be registered on netreg and roaming on gprs.

It also might break down in low-signal conditions where packet radio has =

signal but circuit-switched radio doesn't (which is interesting case where =

COPS reports an operator, CGREG shows registered, but CREG shows unregister=
ed)

Comments?

Regards,
-Denis

--===============7398251705421960590==--

