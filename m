Content-Type: multipart/mixed; boundary="===============7008680547836638868=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins/ril: Move GPRS atom creating to 'post_online'
 state
Date: Fri, 22 Apr 2016 14:20:17 -0500
Message-ID: <571A7971.8030906@gmail.com>
In-Reply-To: <1461226534-1788-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7008680547836638868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 04/21/2016 03:15 AM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> At gprs atom 'probe' state, max cid query may fail due to rild
> status isn't RADIO_STATUS_ON. It causes gprs atom is removed, gprs
> feature is inavailable. Move gprs atom creating to 'post_online'
> state to make sure rild status is RADIO_STATUS_ON when query max
> cid.
> ---
>   plugins/ril.c | 36 +++++++++++++++++-------------------
>   1 file changed, 17 insertions(+), 19 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============7008680547836638868==--

