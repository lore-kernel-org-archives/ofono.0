Content-Type: multipart/mixed; boundary="===============2491878806678962639=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Make SPN change atomic for consumers
Date: Mon, 23 Jan 2012 10:58:40 -0600
Message-ID: <4F1D91C0.2010607@gmail.com>
In-Reply-To: <1327311696-11195-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2491878806678962639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 01/23/2012 03:41 AM, Oleg Zhurakivskyy wrote:
> Due to new spn watch semantics, ofono_sim_get_spn()
> will report the absence of SPN while reading it,
> which is probably incorrect.
> ---
>  src/sim.c |   30 +++++++++++++++---------------
>  1 files changed, 15 insertions(+), 15 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============2491878806678962639==--

