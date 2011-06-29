Content-Type: multipart/mixed; boundary="===============3599327410033791326=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 0/4] ACFC and PFC options implementation
Date: Wed, 29 Jun 2011 05:15:43 -0500
Message-ID: <4E0AFB4F.3080801@gmail.com>
In-Reply-To: <1309335626-32202-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3599327410033791326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 06/29/2011 03:20 AM, Guillaume Zajac wrote:
> Hi,
> =

> Change log from v3:
> 	- Fix some style issues
> 	- update g_at_ppp_set_[acfc/pfc]_enabled() signatures
> 	- update lcp functions setting acfc/pfc options
> 	- we can now enable/disable ACFC or PFC to re-use the PPP object
> 	  with different parameters
> =

> Guillaume Zajac (4):
>   GAtPPP: Add ACFC option support
>   GAtPPP: Add PFC option support
>   emulator: Activate ACFC and PFC options onto GAtPPP object
>   gsmdial: Activate ACFC and PFC options on GAtPPP object
> =

>  gatchat/gatppp.c  |  155 +++++++++++++++++++++++++++++++++++++++++++++--=
------
>  gatchat/gatppp.h  |    3 +
>  gatchat/gsmdial.c |    3 +
>  gatchat/ppp.h     |   12 ++++
>  gatchat/ppp_lcp.c |   64 +++++++++++++++++++++-
>  src/emulator.c    |    3 +
>  6 files changed, 215 insertions(+), 25 deletions(-)
> =


I went ahead and applied all four patches, thanks.  I did do some minor
refactoring afterwards to optimize the rx & tx flow.  In my testing
everything seems to be working fine, but please stress test it again to
make sure.

I also went ahead and marked the PFC & ACFC tasks as done.

Regards,
-Denis

--===============3599327410033791326==--

