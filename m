Content-Type: multipart/mixed; boundary="===============3649371034364394589=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Fix: Avoid release dialing call when call is 0
Date: Mon, 16 Nov 2009 11:49:27 -0600
Message-ID: <200911161149.27268.denkenz@gmail.com>
In-Reply-To: <1258380741.5437.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3649371034364394589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> If +CIEV call goes to 0, we may have another dialing call. We
> should not release this dialing call when call=3D0.

Yes, you're absolutely correct.

I fixed it slightly differently.  The main issue was that it is possible to=
 have =

a dialing and a waiting call under some circumstances.  Neither the current =

code nor your fix handled that case.  The code is much simpler now as well.=
  =

Let me know if the issue persists.

Regards,
-Denis

--===============3649371034364394589==--

