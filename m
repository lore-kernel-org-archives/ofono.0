Content-Type: multipart/mixed; boundary="===============8971258181318692959=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: sim status notification without polling
Date: Thu, 23 Aug 2012 09:21:33 -0500
Message-ID: <50363C6D.3090509@gmail.com>
In-Reply-To: <1345645446-3387-2-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8971258181318692959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/22/2012 09:24 AM, Christopher Vogl wrote:
> Use AT#QSS=3D2 instead of AT#QSS=3D1 to get an URC when the SIM is not on=
ly
> inserted but also when PIN is unlocked and when SMS + phonebook are
> ready to be used.
>
> Disable sim state notification in telit_enable() so that we sure get a
> notification when we enable it later again. This way we don't have to
> query the state the first time. Without this the Telit modem does not
> always send an URC when AT#QSS=3D2 is sent.
>
> Remove sim_inserted_source and sim_inserted_timeout_cb which are not
> needed anymore as a consequence.
> By the way the 1 second timeout was an ugly hack.
>
> Don't query current SIM status in cfun_enable_cb() as the SIM is
> disabled due to prior AT+CFUN=3D4.
>
> Register '#QSS:' before enabling sim state notifications.
>
> Remove telit_qss_cb() which was used as a callback for querying the
> current SIM status.
> ---
>   plugins/telit.c |   96 +++++++++++++++++++-----------------------------=
------
>   1 files changed, 34 insertions(+), 62 deletions(-)
>

Patch looks good to me overall, however:

cc1: warnings being treated as errors
plugins/telit.c: In function =E2=80=98switch_sim_state_status=E2=80=99:
plugins/telit.c:226:4: error: statement with no effect
plugins/telit.c:240:4: error: statement with no effect
plugins/telit.c: At top level:
plugins/telit.c:64:20: error: =E2=80=98qss_prefix=E2=80=99 defined but not =
used

Also, one other thing I'm concerned about is the CFUN=3D4 usage when we =

try to set the modem offline.  Your comments indicate that the Telit =

modem resets the SIM when we issue CFUN=3D4.  Going from Online True -> =

False we don't actually want to reset the SIM.  Does CFUN take an extra =

parameter to turn SIM reset off by any chance?

Regards,
-Denis

--===============8971258181318692959==--

