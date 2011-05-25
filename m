Content-Type: multipart/mixed; boundary="===============0368123954278417743=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 4/5] emulator: add request/release private network calls
Date: Wed, 25 May 2011 05:46:15 -0500
Message-ID: <4DDCDDF7.2020401@gmail.com>
In-Reply-To: <1305799112-14289-5-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0368123954278417743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/19/2011 04:58 AM, Guillaume Zajac wrote:
> ---
>  src/emulator.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++--=
-----
>  1 files changed, 65 insertions(+), 10 deletions(-)
> =


I applied this patch, but have done heavy refactoring afterwards.
Please review all my changes (~20 or so patches intermixed with yours)
and make sure everything makes sense.  I lightly tested this
functionality with gsmdial and everything seems to be performing well.

However, please test it really well yourself, use valgrind and try every
exceptional condition you can think of.

Regards,
-Denis

--===============0368123954278417743==--

