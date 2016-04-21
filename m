Content-Type: multipart/mixed; boundary="===============7716522716504988661=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix crash when PUK is required
Date: Wed, 20 Apr 2016 21:28:56 -0500
Message-ID: <57183AE8.8010008@gmail.com>
In-Reply-To: <1461139785-28790-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7716522716504988661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 04/20/2016 03:09 AM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> After input PIN wrong 3 times, sim main state (include spn_watches)
> is freed. but the watch id still be kept by other atoms (network and
> gprs), when remove the atom, it will try to remove the watch from
> spn_watches, ofono daemon will crash.
> ---
>   src/sim.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============7716522716504988661==--

