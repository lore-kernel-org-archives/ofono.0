Content-Type: multipart/mixed; boundary="===============8505002074033611838=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] cdma-netreg: Add various cdma-netreg watches
Date: Sun, 30 Oct 2011 02:18:05 -0500
Message-ID: <4EACFA2D.70902@gmail.com>
In-Reply-To: <1319125292-6204-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8505002074033611838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 10/20/2011 10:41 AM, Guillaume Zajac wrote:
> ---
>  include/cdma-netreg.h |    1 +
>  src/cdma-netreg.c     |   58 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/ofono.h           |   13 +++++++++++
>  3 files changed, 72 insertions(+), 0 deletions(-)
> =


Please follow patch submission guidelines outlined in HACKING.  Namely
the include/ changes should be in a separate patch.

I cherry picked the chunks dealing with ofono_cdma_netreg_get_status and
pushed them upstream.

Thanks,
-Denis

--===============8505002074033611838==--

