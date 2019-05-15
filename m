Content-Type: multipart/mixed; boundary="===============2049150603992742941=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Wed, 15 May 2019 22:07:50 +0200
Message-ID: <CAHB-PjmrG9QdsyX3dECdqkLw6e_ko4LFy5PPH8YMM=yU2kJr1w@mail.gmail.com>
In-Reply-To: <2bfc8999-e479-066f-0870-91ddacb80de1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2049150603992742941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tis 14 maj 2019 kl 21:44 skrev Denis Kenzior <denkenz@gmail.com>:
>
> Hi Richard,
>
> > Not sure we need to ;-) It seems to me like gatchat always does this
> > is the command list is empty, putting a single AT first..I didn't know
> > it was "optional".
>
> It is enabled only if you use g_at_chat_set_wakeup_command.  Looks like
> commit ae74d4ccd added this.  I no longer remember the details why.  It
> is a bit of a waste to keep this on after the modem is active though.
> The freerunner had an overly aggressive sleep mode where the TTY would
> sleep after 5 seconds of inactivity and eat the first command sent to it.
>
> >> My memory is fuzzy now, but I'm not sure if we ever put in the logic to
> >> attempt a re-attach in such a situation (e.g. we didn't request a
> >> detach).  For all devices we cared about the modem re-attached for us.
> >> It looks like there's still a TODO for this in src/gprs.c
> >
> > I guess the thing is that the modem has switched to 4G. Do we actually
> > need to care about re-attaching to gprs? I mean the modem
>
> Ah I think I see now....
>
> Btw, what does 4G mean? That is a marketing term, please use the
> technical terms ;)
>

Sorry about this :) I guess I mean LTE/EUTRAN

> So you mean it switched to LTE/EUTRAN and GPRS state went to state
> 'unknown'.  On EUTRAN we are always attached, so, no, we do not need to
> reattach.
>
> > automatically hand over to 4G and the context continues to work.
> > Wouldn't it make sense if gprs kept the "combined packet status"?
> > (combine CGREG, CEREG and whatever for 5G).
>
> Yes, it should.

So should we update gprs.c to hande c*reg?

>
> > The name GPRS would be confusing but it would keep the complete packet
> > switched status in one place.
> > In this case that could would not consider us being roaming instead of
> > unknown, since that whats CEREG reports.
>
> So I think there's a bug where we erroneously set the Attached property
> to False in this situation.  It doesn't look like we trigger an actual
> detach, but Attached should remain 'True' while CREG shows that we're on
> EUTRAN or any related tech.  Perhaps the logic in gprs_attached_update()
> needs to be updated.

We need to consider the "tricky" part that we consider us attached
first when the
 context is activated in EUTRAN. And we might be in a transition
(attaching flag).

I'm thinking if the "combined" state in gprs wouldn't be the least
intrusive update for this.

I think I saw a patch for using c*reg in atmodem/gprs.c, can we wake that u=
p?
Otherwise I can put some energy into this, if we decide which
direction to go first.

--Richard

--===============2049150603992742941==--

