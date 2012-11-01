Content-Type: multipart/mixed; boundary="===============5780667037941007961=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: Re: [PATCH] sim: Fix the quirk handling of CPIN for Wavecom
Date: Thu, 01 Nov 2012 09:22:13 +0000
Message-ID: <loom.20121101T101932-157@post.gmane.org>
In-Reply-To: <1351760703-28090-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5780667037941007961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Holger Hans Peter Freyther <holger@...> writes:


> Apply the CPIN quirk for both WAVECOM and WAVECOM_Q2XXX inside the
> sim.c file. Introduce needs_wavecom_sim_quirk to handle it for
> WAVECOM and WAVECOM_Q2XXX.

The OFONO_VENDOR_WAVECOM_Q2XXX is now only used in the SMS code and I
assume we can simply turn this into OFONO_VENDOR_WAVECOM and remove
the _Q2XXX vendor.

This is mostly based on the assumption that plain wavecom has been
broken (adding a terminator on a cloned chat which will do nothing).

holger


--===============5780667037941007961==--

