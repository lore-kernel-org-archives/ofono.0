Content-Type: multipart/mixed; boundary="===============6934047525151762701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue where a non-active context remains active
Date: Fri, 20 Sep 2019 10:41:06 -0500
Message-ID: <7a67c6d6-20f8-34e3-0fa9-e0f5b9e9e862@gmail.com>
In-Reply-To: <CAHB-Pjn5jTt8TK=3gLmLNSEW2tzC+--jpgquvqFasxk0i+Xm1A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6934047525151762701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/15/19 12:58 PM, Richard R=C3=B6jfors wrote:
> Hi,
> =

> I would like to discuss this issue before I try to fix it. I might not =

> have the full picture since I don't know how all modems work.
> =

> =

> The context 4 gets activated:
> Sep 15 16:06:00 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:ofono_gprs_cid_activated() cid 4
> Sep 15 16:06:00 daemon.debug ofonod[542]: =

> ../git/drivers/ubloxmodem/gprs-context.c:ublox_gprs_read_settings() cid 4

So it would seem you're on LTE and get a default bearer, right?

> Sep 15 16:06:00 daemon.debug ofonod[542]: =

> ../git/src/modem.c:get_modem_property() modem 0x1c7f9a0 property =

> NetworkInterface
> Sep 15 16:06:00 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:pri_read_settings_callback() 0x1c82280
> Sep 15 16:06:00 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 0 -> 1
> =

> ---- 8< ---
> =

> Things get shaky
> =

> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\n+CREG: 0\r\n

At some point the modem decides to roam and tells us its not connected =

to anything any more.  Am I right so far?

> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/network.c:ofono_netreg_status_notify() /ublox_0 status 0 tech =

> -1 lac -1 ci -1
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/network.c:current_operator_callback() 0x1c80408, 0x1c81e08
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 1
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 0
> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: > AT\r
> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\n+CIEV: 7,0\r\n
> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\nOK\r\n
> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: =

> Finally woke up the modem

This is weird that you're using gatchat wakeups, but okay...

> =

> We detach the drivers...
> =

> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: > =

> AT+CGATT=3D0\r
> Sep 15 16:18:39 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\n+CGREG: 4\r\n
> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status unknown (4)
> =


So we detach.  Which really we shouldn't be doing since depending on the =

firmware it might screw up the roam.  Also, I'm not seeing the actual =

response to CGATT.

> Gprs status becomes unknown. We are not considered attached anymore, we =

> call "release_active_contexts".
> That call clears the context but DO NOT signal any change on D-Bus so it =

> will be considered alive...

Shouldn't the logic in detach_shutdown deactivate all active contexts? =

A proper driver should be implementing that.

But again, we shouldn't even be detaching in the first place if we're on =

LTE and roaming.  This is where 27.007 really fails.

> =

> Sep 15 16:18:39 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 1 -> 0
> =

> ... But the connection manager gets the detached property changed so it =

> understands the context is not useful
> =

> ----- 8< -----
> =

> Things stabilises...
> =

> Sep 15 16:19:11 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\n+CGREG: 5,"4EE9","0000E06A",2,"01"\r\n
> Sep 15 16:19:11 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0 status roaming (5)
> Sep 15 16:19:11 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:gprs_set_attached_property() 0x1c7d500 0 -> 1
> =

> We are now considered attached.
> Remember that the context that was released internally above, but Active =

> was not signaled false on D-Bus,
> The connection manager believes we are attached AND the context its up.
> So its happy.=C2=A0 And actually the context is still up in the modem sin=
ce =

> we did not try to bring it down...
> But this is all unknown to ofono now since ofono forgot its cid above =

> when it was released...
> =


Ugh.  The connection manager should wipe everything out when Attached =

goes to false.  So that might be a bug or misunderstanding.  I suppose =

there's no harm in signaling the context as inactive on our side in this =

case.

> ----- 8< ----
> =

> Now the context goes down...
> =

> Sep 15 16:19:12 daemon.info <http://daemon.info> ofonod[542]: Aux: < =

> \r\n+CGEV: ME PDN DEACT 4\r\n
> Sep 15 16:19:12 daemon.debug ofonod[542]: =

> ../git/drivers/ubloxmodem/gprs-context.c:cgev_notify() cid 4, active cid:=
 4
> Sep 15 16:19:12 daemon.debug ofonod[542]: =

> ../git/src/gprs.c:ofono_gprs_context_deactivated() 0x1c5e8a0 0x1c7d500 4
> =

> It will not be found since the CID was lost when it was released. So =

> nothing is signalled on D-Bus. The connection manager
> still believes the context is up ... but its not.. we are screwed.
> =

> =

> =

> So to summarise we do release context when we decide to de-attach.
> We are then losing all information about the contexts, such as cid and =

> if its active.
> Its not signalled on D-Bus so the old state remains.
> =


Right

> Later on we attach again, the context is alive in the modem, but ofono =

> doesn't know. The connection manager
> believes the context is active all the time.=C2=A0 Then the modem deactiv=
ates =

> the context, ofono has no idea which
> context this is, and the connection manager will not get the information.
> =

> So how should we fix this without breaking anything..? :)
> =

> I was thinking:
> 1. when we do release_context we should update the Active property on D-B=
us.
> 2. When we are attached again, we could call a list_contexts in case =

> they "survived" from the modem point of view. And we will reinitialise =

> them on the ofono side.

I think 1 is the least invasive option for now, but really...

the question is whether IP details can change during a roam.  I suppose =

that they shouldn't, but I don't know that for sure.  Ideally we =

shouldn't even be messing with detaching or de-activating contexts on =

LTE devices as they manage this automagically for us.  So during a roam =

we just plain shouldn't do anything unless the modem sent us a CGEV =

telling the context has been deactivated.

Regards,
-Denis

--===============6934047525151762701==--

