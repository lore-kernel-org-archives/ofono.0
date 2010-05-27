Content-Type: multipart/mixed; boundary="===============0053774372016477518=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Accept opaque data in EF_ICCID.
Date: Thu, 27 May 2010 15:39:14 -0500
Message-ID: <201005271539.14240.denkenz@gmail.com>
In-Reply-To: <1274457395-14574-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0053774372016477518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  src/sim.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)

So I looked at the behavior of a few smartphones and they use ICCID as a BC=
D =

format, not opaque.  This is specified in the 2G and 3G version of the =

standards going back to 11.11.

I'm now leaning towards keeping the present behavior unless there are some =

good arguments for why we want this to be opaque.  Either way we don't sati=
sfy =

someone and I'd rather be standards compliant.

Regards,
-Denis

--===============0053774372016477518==--

