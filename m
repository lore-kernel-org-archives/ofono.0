Content-Type: multipart/mixed; boundary="===============1217228705994540945=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Wed, 27 Mar 2013 14:54:46 -0500
Message-ID: <51534E86.1040101@gmail.com>
In-Reply-To: <CAAs3wMjfWfeog=+ECLZZjYEMwNL6nh4fn=phARSwVs06dt9u5A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1217228705994540945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

>
>     enable -> pre_sim, sim_inserted -> post_sim, set_online ->
>     post_online.  Generally you do not call set_online before hitting
>     the post_sim state.
>
>
> could I don't  implement set_online if I don't need it?

That would work, if the modem driver does not implement set_online, =

oFono core automatically transitions to Online after CPIN returns 'READY'.

>
>     <snip>
>
>
>
>         I've managing vendor URC for sim detection right now but i have
>         problems.For instance if I remove it when ofonod is ready the Hil=
onc
>         sends an URC to notify sim status changed but after that it reboo=
ts
>         itself(2 sec later)... what i did is to notify the stack that
>         the SIM
>         has been removed and modem is powered off . I thought that after
>         calling
>         set_powered fnc the stack should have called my driver virtual
>         disable
>         function in order to properly close the MUX .. but it's not..
>
>
>     No, if you call ofono_modem_set_powered(modem, FALSE) it assumes
>     that the modem powered off due to an internally generated event
>     (e.g. not oFono's doing).  The driver has to clean up properly in
>     this case.  The driver disable() method is only called on oFono
>     initiated power down requests.
>
>
> mmh ok..so If the modem restarts it's my business to disable and enable
> again all the driver' stuff , right?
>

If the modem resets, then yes you need to call ofono_modem_set_powered =

to FALSE.  Booting it back up should not be done in the driver, unless =

your modem supports so called silent resets.  This is where the modem =

stack crashes but silently resets itself back to the previous state. =

(e.g. no PIN entry is required, initialization is very fast). In that =

case use ofono_modem_reset.

<snip>

Glad I could help ;)

Regards,
-Denis

--===============1217228705994540945==--

