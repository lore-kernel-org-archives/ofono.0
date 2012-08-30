Content-Type: multipart/mixed; boundary="===============5225284895241984861=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: enable extended sim status notification
Date: Thu, 30 Aug 2012 09:46:18 -0500
Message-ID: <503F7CBA.5010302@gmail.com>
In-Reply-To: <1346252469-29513-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5225284895241984861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/29/2012 10:01 AM, Christopher Vogl wrote:
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
>
> Move sms atom creation into switch_sim_state_status() and add creation
> of phonebook atom. These are created when QSS: 3 is received.
>
> Avoid a reset  when switching between online and offline (airplane)
> mode in telit_set_online(). +CFUN accepts a second parameter (0), which
> disables a reset: AT+CFUN=3Dx,0.
> ---
>   plugins/telit.c |   99 +++++++++++++++++++-----------------------------=
------
>   1 files changed, 35 insertions(+), 64 deletions(-)
>

Patch has been applied, however I broke it up into two.  One for the =

extra CFUN parameter changes and the rest.

Regards,
-Denis


--===============5225284895241984861==--

