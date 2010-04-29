Content-Type: multipart/mixed; boundary="===============8901826651693621181=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ppp: transition to dead when read io destroyed
Date: Thu, 29 Apr 2010 14:26:18 -0500
Message-ID: <201004291426.18416.denkenz@gmail.com>
In-Reply-To: <20100429110309.31165a8f@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8901826651693621181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> remove call to signal_close for lcp object, it is redundent.  If
> our io is destroyed we are dead, so transition the ppp phase to
> DEAD so our disconnect callback can be called.

This patch has been applied, thanks.

Regards,
-Denis

--===============8901826651693621181==--

