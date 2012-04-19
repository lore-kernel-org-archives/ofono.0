Content-Type: multipart/mixed; boundary="===============6014092652078152133=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix release and answer existing call validation
Date: Thu, 19 Apr 2012 08:42:25 -0500
Message-ID: <4F901641.2020104@gmail.com>
In-Reply-To: <1334873443-21124-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6014092652078152133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 04/19/2012 05:10 PM, Mike Brudevold wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
> =

> Release and answer should be allowed when there are held calls as well as=
 the
> existing check for waiting calls.  Most implementations use AT+CHLD=3D1 w=
hich
> will resume the other call, be it waiting or held.  This follows the HFP,
> GSM 07.07 and 3GPP 27.007 specs.
> ---
>  src/voicecall.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =


This isn't really a bug, but an explicit choice we made with the API.
See the previous discussion here:
http://lists.ofono.org/pipermail/ofono/2011-January/008029.html.

For HFP this is further made funny by the fact that CHLD=3D1X is supposed
to retrieve the held call automatically for you by the AG according to
section 4.32.1, making CHLD=3D1 behavior in question somewhat redundant.

However, I do see that this could be useful, so I suggest we add a new
ReleaseAndSwap method.  I prefer this approach especially since the
current D-Bus API is frozen and I don't want to modify the behavior of
existing methods.

Regards,
-Denis

--===============6014092652078152133==--

