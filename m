Content-Type: multipart/mixed; boundary="===============8951731500267811581=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Fix the quirk handling of CPIN for Wavecom
Date: Thu, 01 Nov 2012 05:00:20 -0500
Message-ID: <50924834.4050504@gmail.com>
In-Reply-To: <1351760703-28090-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8951731500267811581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 11/01/2012 04:05 AM, Holger Hans Peter Freyther wrote:
> From: Holger Hans Peter Freyther<hfreyther@sysmocom.de>
>
> The Wavecom Q2XXX support broke in commit 72ce19bf3e87b5e73c053f7ea1.
> This is because at_cpin_cb called decode_at_error with final and not
> with OK. This lead to an error being set in the error variable and the
> new code returns early when an error is set.
>
> The addition of the terminator in at_sim_probe for Wavecom broke in
> git commit ac524be99f8c72a2593e4ffcecad8beea7679e55 because
> terminators can not be added on cloned chats.
>
> Move the addition of the terminator from the atmodem to the wavecom
> plugin. Use the same terminator for Q2XXX and the normal Wavecom
> class. The WAVECOM terminator has been tested on a Q2XXX modem.
>
> Apply the CPIN quirk for both WAVECOM and WAVECOM_Q2XXX inside the
> sim.c file. Introduce needs_wavecom_sim_quirk to handle it for
> WAVECOM and WAVECOM_Q2XXX.
> ---
>   drivers/atmodem/sim.c |   24 +++++++++---------------
>   plugins/wavecom.c     |    2 ++
>   2 files changed, 11 insertions(+), 15 deletions(-)
>

Patch has been applied, however I broke it up into two with accordance =

to our patch submission guidelines.  Please see HACKING 'Submitting =

patches' section.

Regards,
-Denis


--===============8951731500267811581==--

