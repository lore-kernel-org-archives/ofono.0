Content-Type: multipart/mixed; boundary="===============6934529195763162263=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: RE: ofono Digest, Vol 20, Issue 28
Date: Wed, 08 Dec 2010 17:37:17 +0530
Message-ID: <COL106-W42CDE0B3640629D4AE45EDF62D0@phx.gbl>
In-Reply-To: <mailman.3058.1291805729.10513.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6934529195763162263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello,
This is regarding driving ST-Ericsson Modem (which user CAIF protocol) usin=
g OFono framework.
Host: LinuxTarget : ST-Ericsson GSM ModemCommunication: RS232 cableDrivers:=
 VCP (virtual comport drivers from FTDI ftdi-elan.ko, ftdi_sio.ko)

We implemented CAIF protocol and able to drive ST-Ericsson Board using some=
 test Application.
We understand that CAIF is coming as kernel driver in linux 2.6.36. We are =
trying to write some test application which will make use of CAIF kernel dr=
iver to interact with ST-Ericsson Modem.
When we connect any modem how OFono recognizes it? Is it based on rule ment=
ioned in "97-ofono.rules"? or will it consider modem.conf file?
Please suggest us about the right kernel version we need to deal with  in o=
rder to get complete CAIF implementation.
Thank You,
Regards,Krishna










> From: ofono-request(a)ofono.org
> Subject: ofono Digest, Vol 20, Issue 28
> To: ofono(a)ofono.org
> Date: Wed, 8 Dec 2010 02:55:29 -0800
> =

> Send ofono mailing list submissions to
> 	ofono(a)ofono.org
> =

> To subscribe or unsubscribe via the World Wide Web, visit
> 	http://lists.ofono.org/listinfo/ofono
> or, via email, send a message with subject or body 'help' to
> 	ofono-request(a)ofono.org
> =

> You can reach the person managing the list at
> 	ofono-owner(a)ofono.org
> =

> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of ofono digest..."
> =

> =

> Today's Topics:
> =

>    1. [PATCH 4/4] scripts: Added init.rc script (Jessica Nilsson)
>    2. RE: [PATCH] stkutil: fix crash issue cause by null length of
>       text	string (Lucas, GuillaumeX)
>    3. Re: [PATCH 1/3] plugins: Implementation of Network Time
>       plugin (Marcel Holtmann)
>    4. Re: [PATCH 0/5] Call Counters (2nd) (Marcel Holtmann)
>    5. Re: [PATCH 1/3] plugins: Implementation of Network Time
>       plugin (Aki Niemi)
>    6. Re: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
>       (Marcel Holtmann)
>    7. Re: [PATCH 1/4] gisi: Changes to prepare for isimodem2.5
>       (Marcel Holtmann)
>    8. Re: [PATCH 0/5] Call Counters (2nd) (Aki Niemi)
>    9. Re: [RFC PATCH 2/4] modem: add EmergencyMode property
>       (Denis Kenzior)
> =

> =

> ----------------------------------------------------------------------
> =

> Message: 1
> Date: Wed,  8 Dec 2010 09:35:29 +0100
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
> To: ofono(a)ofono.org
> Cc: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
> Subject: [PATCH 4/4] scripts: Added init.rc script
> Message-ID:
> 	<1291797329-20592-1-git-send-email-jessica.j.nilsson@stericsson.com>
> =

> Updates in Makefile.am and the adding of an init file.
> =

> Regards,
> Jessica Nilsson
> =

> ---
>  Makefile.am    |   10 +++++++
>  scripts/ofonod |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 89 insertions(+), 0 deletions(-)
>  create mode 100755 scripts/ofonod
> =

> diff --git a/Makefile.am b/Makefile.am
> index a5c89f2..0e6b761 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -82,6 +82,10 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.=
c \
>  =

>  udev_files =3D plugins/ofono.rules
>  =

> +if ISIMODEM25
> +init_files =3D scripts/ofonod
> +endif
> +
>  if UDEV
>  builtin_modules +=3D udev
>  builtin_sources +=3D plugins/udev.c
> @@ -562,3 +566,9 @@ include/ofono/%.h: include/%.h
>  =

>  clean-local:
>  	@$(RM) -rf include/ofono
> +
> +if ISIMODEM25
> +init-scripts:
> +	$(AM_V_at)$(MKDIR_P) $(sysconfdir)/rc.d/init.d
> +	@install -m 755 $(init_files) $(sysconfdir)/rc.d/init.d/ofonod
> +endif
> diff --git a/scripts/ofonod b/scripts/ofonod
> new file mode 100755
> index 0000000..6f568e8
> --- /dev/null
> +++ b/scripts/ofonod
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +
> +# Init file for ofono daemon
> +
> +### BEGIN INIT INFO
> +# Provides: ofonod
> +# Required-Start: $local_fs cops msa
> +# Required-Stop:
> +# Default-Start:  2 3 4 5
> +# Default-Stop: 0 1 6
> +# chkconfig: 2345 99 01
> +# Short-Description: start and stop ofono
> +# Description: ofono
> +# Modem middleware for accessing the modem
> +# through phonet sockets.
> +### END INIT INFO
> +
> +progname=3Dofonod
> +execname=3D/usr/sbin/$progname
> +lockfile=3D/var/lock/subsys/$progname
> +options=3D""
> +
> +# Sanity check
> +[ -x $execname ] || exit 5
> +
> +# Source function library.
> +. /etc/init.d/functions
> +
> +RETVAL=3D0
> +
> +start() {
> +
> +        echo -n "Starting $progname: "
> +        /sbin/ifconfig shrm0 up
> +        daemon $execname $options
> +        RETVAL=3D$?
> +        [ $RETVAL -eq 0 ] && touch $lockfile
> +        echo
> +        return $RETVAL
> +}
> +
> +stop() {
> +        echo -n "Stopping $progname: "
> +        killproc $progname
> +        RETVAL=3D$?
> +        echo
> +        [ $RETVAL -eq 0 ] && rm -f $lockfile
> +        return $RETVAL
> +}
> +
> +case "$1" in
> +  start)
> +        start
> +        ;;
> +  stop)
> +        stop
> +        ;;
> +  reload)
> +  ;;
> +  restart|force-reload)
> +        stop
> +        start
> +        ;;
> +  status)
> +        status $progname
> +        RETVAL=3D$?
> +        ;;
> +  try-restart)
> +        if [ -f $lockfile ]; then
> +            stop
> +            start
> +        fi
> +        ;;
> +  *)
> +        echo $"Usage: $0 {start|stop|restart|try-restart|reload|force-re=
load|status}"
> +        RETVAL=3D$?
> +esac
> +
> +exit $RETVAL
> -- =

> 1.7.3.2
> =

> =

> =

> ------------------------------
> =

> Message: 2
> Date: Wed, 8 Dec 2010 08:37:19 +0000
> From: "Lucas, GuillaumeX" <guillaumex.lucas@intel.com>
> To: "ofono(a)ofono.org" <ofono@ofono.org>
> Subject: RE: [PATCH] stkutil: fix crash issue cause by null length of
> 	text	string
> Message-ID:
> 	<9F3EABD6E3419B4C81F34EAABB4D40188136D95D4B@irsmsx501.ger.corp.intel.c=
om>
> 	=

> Content-Type: text/plain; charset=3D"utf-8"
> =

> Hi
> =

> > =

> > On 7 December 2010 22:55,  <Jeevaka.Badrappan@elektrobit.com> wrote:
> > > Hi Guillaume,
> > >
> > >>
> > >> According to 3GPP TS 31.124 a null length for the text string
> > >> should be allowed. An empty string must be returned to the
> > >> user in this case.
> > >> ---
> > >> ?src/stkutil.c | ? ?6 ++++--
> > >> ?1 files changed, 4 insertions(+), 2 deletions(-)
> > >>
> > >
> > > Agree. As per the 3GPP TS 31.124 null text string will be indicated
> > with
> > > length 0.
> > > So, in first place if (text =3D=3D NULL) check in
> > handle_command_get_input,
> > > handle_command_get_inkey has to be removed. Removing this check will
> > > result
> > > in crash due to the fact that we are not handling this case properly
> > > neither
> > > in parse_dataobj_text nor in corresponding stkagent functions.
> > >
> > > There are 2ways to solve this issue:
> > >
> > > First option - Fix provided in the function parse_dataobj_text( e.g.
> > > *text =3D "")
> > > Second option - In all the stk_agent_ function which has this text
> > > string we
> > > ? ? ? ? ? ? ? ?need to check for NULL and assign it to empty string
> > if
> > > it is NULL.
> > >
> > > First option seems to be right and also better one.
> > =

> =

> Agree. It's why I've did this one :)
> I'll be more explicit in the description for my future patches. Especiall=
y for crash issue.
> =

> Regards,
> Guillaume
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> =

> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> =

> ------------------------------
> =

> Message: 3
> Date: Wed, 08 Dec 2010 09:44:12 +0100
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time
> 	plugin
> Message-ID: <1291797852.4795.137.camel@aeonflux>
> Content-Type: text/plain; charset=3D"UTF-8"
> =

> Hi Aki,
> =

> > > > where is this timed running? I prefer the plugin just send a D-Bus
> > > > message to the timed directly instead of a Get/Changed API kind of
> > > > thing.
> > > =

> > > AFAIK, timed is in system bus. However, I fail to see how you can make
> > > this any simpler. In the end, one of the two entities has to implement
> > > a service that the other one uses. There also needs to be some
> > > synchronization for when the entities start up. A getter/signal API is
> > > also what timed uses in Harmattan, but of course if you have a better
> > > idea, I'm all ears.
> > =

> > is timed actually open source and I can have a look at it?
> =

> so what about this? Where is the timed respository? I really wanna have
> a look at it and see what it is doing.
> =

> Regards
> =

> Marcel
> =

> =

> =

> =

> ------------------------------
> =

> Message: 4
> Date: Wed, 08 Dec 2010 10:03:04 +0100
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 0/5] Call Counters (2nd)
> Message-ID: <1291798984.4795.146.camel@aeonflux>
> Content-Type: text/plain; charset=3D"UTF-8"
> =

> Hi Aki,
> =

> > > Here a proposal for call counters implementation for keeping track
> > > of the total incoming and outgoing call duration counters. Each
> > > established call instance is contributing to either of the call
> > > duration counters. The 2 counters are updated periodically when
> > > there is an established call and the information is stored in
> > > a file. The bookkeeping of the call duration counters are per IMSI
> > > number.
> > > The implementation makes use of the history framework which had to be
> > > expanded with a function for marking the beginning of a voice call.
> > > There is a D-Bus interface to call counters for reading and clearing
> > > the counters.
> > =

> > This set looks good to me, and I believe you fixed the issues from
> > previous review comments. Denis, are you ok with this?
> =

> so Denis and I talked about this a little bit and I am not fine with
> this at all.
> =

> Lets take this one step and please explain to me what your requirements
> and objectives are. I also wanna see a top to bottom from UI down to the
> modem usage of this API.
> =

> My main concerns are here that we are waking up ofonod every 10 seconds
> and consuming heavy IO with writing this information to disk. In
> addition to that there is no clear UI usage for the getter API.
> =

> What are the granularity there. What is the expected user experience
> with this API. I don't see any clear usage model here.
> =

> In addition to that, what is the problem with just updating the stats
> after the call has ended?
> =

> Are you really expecting realtime updates of call time stats for some
> hidden UI stats menu? This would be a really expensive change for just
> doing that.
> =

> Has anybody looked at how we are doing realtime stats inside ConnMan?
> =

> Regards
> =

> Marcel
> =

> =

> =

> =

> ------------------------------
> =

> Message: 5
> Date: Wed, 8 Dec 2010 11:19:48 +0200
> From: Aki Niemi <aki@protocolpolice.com>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time
> 	plugin
> Message-ID:
> 	<AANLkTin6KXd0UMq8acZojmScyBPMssSWhH2+bNezgx8T@mail.gmail.com>
> Content-Type: text/plain; charset=3DUTF-8
> =

> Hi Marcel,
> =

> 2010/12/8 Marcel Holtmann <marcel@holtmann.org>:
> >> is timed actually open source and I can have a look at it?
> >
> > so what about this? Where is the timed respository? I really wanna have
> > a look at it and see what it is doing.
> =

> Knock yourself out:
> =

> http://meego.gitorious.org/meego-middleware/timed
> =

> Cheers,
> Aki
> =

> =

> ------------------------------
> =

> Message: 6
> Date: Wed, 08 Dec 2010 10:30:04 +0100
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Cc: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
> Subject: Re: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
> Message-ID: <1291800604.4795.151.camel@aeonflux>
> Content-Type: text/plain; charset=3D"UTF-8"
> =

> Hi Jessica,
> =

> > Updates in Makefile.am - adding of isimodem2.5
> > Adding of drivers/isimodem2.5/ files to fully listed functionality.
> > =

> > Regards,
> > Jessica Nilsson
> > =

> > ---
> >  Makefile.am                                |   36 +-
> >  drivers/isimodem2.5/call-barring.c         |  503 ++
> >  drivers/isimodem2.5/call-forwarding.c      |  613 +++
> >  drivers/isimodem2.5/call-settings.c        | 1093 +++++
> >  drivers/isimodem2.5/call.h                 |  237 +
> >  drivers/isimodem2.5/cbs.c                  |  433 ++
> >  drivers/isimodem2.5/checkpatch.pl          | 2789 ++++++++++++
> >  drivers/isimodem2.5/debug.c                |  694 +++
> >  drivers/isimodem2.5/debug.h                |   66 +
> >  drivers/isimodem2.5/devinfo.c              |  246 +
> >  drivers/isimodem2.5/gpds-context.c         |  788 ++++
> >  drivers/isimodem2.5/gpds.c                 |  395 ++
> >  drivers/isimodem2.5/gpds.h                 |  295 ++
> >  drivers/isimodem2.5/gss.h                  |   84 +
> >  drivers/isimodem2.5/info.h                 |   53 +
> >  drivers/isimodem2.5/isimodem.c             |  534 +++
> >  drivers/isimodem2.5/isimodem.h             |   69 +
> >  drivers/isimodem2.5/isiutil.h              |   64 +
> >  drivers/isimodem2.5/mce.h                  |   65 +
> >  drivers/isimodem2.5/network-registration.c | 1158 +++++
> >  drivers/isimodem2.5/network.h              |  257 ++
> >  drivers/isimodem2.5/phonebook.c            | 1320 ++++++
> >  drivers/isimodem2.5/radio-settings.c       |  313 ++
> >  drivers/isimodem2.5/simu_resps.h           | 6800 ++++++++++++++++++++=
++++++++
> >  drivers/isimodem2.5/sms.c                  |  869 ++++
> >  drivers/isimodem2.5/sms.h                  |  188 +
> >  drivers/isimodem2.5/ss.h                   |  174 +
> >  drivers/isimodem2.5/ssn.c                  |  456 ++
> >  drivers/isimodem2.5/timeout.h              |   33 +
> >  drivers/isimodem2.5/uicc.c                 | 3316 ++++++++++++++
> >  drivers/isimodem2.5/uicc.h                 |  253 ++
> >  drivers/isimodem2.5/uicc_interface.h       |   40 +
> >  drivers/isimodem2.5/ussd.c                 |  341 ++
> >  drivers/isimodem2.5/voicecall.c            | 1555 +++++++
> >  34 files changed, 26128 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/isimodem2.5/call-barring.c
> >  create mode 100644 drivers/isimodem2.5/call-forwarding.c
> >  create mode 100644 drivers/isimodem2.5/call-settings.c
> >  create mode 100644 drivers/isimodem2.5/call.h
> >  create mode 100644 drivers/isimodem2.5/cbs.c
> >  create mode 100755 drivers/isimodem2.5/checkpatch.pl
> >  create mode 100644 drivers/isimodem2.5/debug.c
> >  create mode 100644 drivers/isimodem2.5/debug.h
> >  create mode 100644 drivers/isimodem2.5/devinfo.c
> >  create mode 100644 drivers/isimodem2.5/gpds-context.c
> >  create mode 100644 drivers/isimodem2.5/gpds.c
> >  create mode 100644 drivers/isimodem2.5/gpds.h
> >  create mode 100644 drivers/isimodem2.5/gss.h
> >  create mode 100644 drivers/isimodem2.5/info.h
> >  create mode 100644 drivers/isimodem2.5/isimodem.c
> >  create mode 100644 drivers/isimodem2.5/isimodem.h
> >  create mode 100644 drivers/isimodem2.5/isiutil.h
> >  create mode 100644 drivers/isimodem2.5/mce.h
> >  create mode 100644 drivers/isimodem2.5/network-registration.c
> >  create mode 100644 drivers/isimodem2.5/network.h
> >  create mode 100644 drivers/isimodem2.5/phonebook.c
> >  create mode 100644 drivers/isimodem2.5/radio-settings.c
> >  create mode 100644 drivers/isimodem2.5/simu_resps.h
> >  create mode 100644 drivers/isimodem2.5/sms.c
> >  create mode 100644 drivers/isimodem2.5/sms.h
> >  create mode 100644 drivers/isimodem2.5/ss.h
> >  create mode 100644 drivers/isimodem2.5/ssn.c
> >  create mode 100644 drivers/isimodem2.5/timeout.h
> >  create mode 100644 drivers/isimodem2.5/uicc.c
> >  create mode 100644 drivers/isimodem2.5/uicc.h
> >  create mode 100644 drivers/isimodem2.5/uicc_interface.h
> >  create mode 100644 drivers/isimodem2.5/ussd.c
> >  create mode 100644 drivers/isimodem2.5/voicecall.c
> =

> this is not gonna work this way. No one can review such a massive patch.
> Actually Evolution even refused to format this for me.
> =

> So please split this into one patch per atom driver.
> =

> In addition, I don't a point in a filename. So isimodem25 or isimodem2
> or something like that please. I am open for proposals.
> =

> Regards
> =

> Marcel
> =

> =

> =

> =

> ------------------------------
> =

> Message: 7
> Date: Wed, 08 Dec 2010 10:31:35 +0100
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Cc: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
> Subject: Re: [PATCH 1/4] gisi: Changes to prepare for isimodem2.5
> Message-ID: <1291800695.4795.153.camel@aeonflux>
> Content-Type: text/plain; charset=3D"UTF-8"
> =

> Hi Jessica,
> =

> > This set of patches introduces the isimodem2.5.
> > =

> > WG2.5 (isimodem2.5) Supported features list:
> > =

> > General:
> > Online / Offline mode (RF on/off)
> > =

> > Voice call:
> > MO/MT call
> > Multiparty call (max 7 calls)
> > Transfer call
> > Swap calls
> > Hold calls
> > Hang up all
> > Hang up specific call
> > Disconnect reason (Network/local/remote)
> > Send DTMF tones
> > =

> > PS data:
> > Primary PDP context (IPv4 only)
> > APN: User name and password supported
> > Attach mode: Manual (Automatic works as well, but not activated)
> > Data flow control not activated (Not supported by Kernel)
> > =

> > SMS:
> > Send and receieve SMS
> > Concatenated messages supported (up to 255 messages)
> > Class 0
> > Delivery reports
> > Read / Write SMSC to SIM card
> > Bearer settings supported (CS or PS)
> > =

> > Supplementary Services:
> > Call Barring
> >      VoiceOutgoing
> >      VoiceIncoming
> > Call Settings
> >      CalledLineRestriction
> >      HideCallerId
> >      CallingLinePresentation
> >      CalledLinePresentation
> >      VoiceCallWaiting
> >      CallingLineRestriction
> > Call Forwarding
> >      Voice Not Reachable
> >      Voice Busy
> >      Voice No Reply
> >      Voice Unconditional
> > USSD
> >      MO USSD
> >      MT USSD NOT SUPPORTED
> > SSN
> > =

> > CS Network:
> > Network registration
> > Scanning available networks
> > Selecting automatically and manually the target network
> > Changing RAT between GSM/UMTS/ANY
> > Registration status: Cell ID, LAC, MNC, Current Technology (GSM, UMTS, =

> > EDGE, HSDPA, HSUPA, HSDPA&HSUPA)
> > Deregister
> > RSSI (%)
> > =

> > SIM:
> > Read IMSI
> > MSISDN (Subscriber numbers)
> > SDN (Service Dialing Numbers)
> > PIN/PIN2/PUK/PUK2 supported (reset/change/lock)
> > Read file info from SIM
> > Read FIle (Transparent, Linear & Cyclic) * Some functionalities flagged =

> > out as ofono core is not using these
> > Write File (Transparent, Linear & Cyclic) * Some functionalities flagge=
d =

> > out as ofono core is not using these
> > MCC & MNC
> > CardIdentifier
> > PreferredLanguages
> > =

> > Export contacts(SIM phonebook):
> > SIM and USIM cards supported
> > Name
> > Number (extension record supported)
> > Additional number
> > Email
> > No limitiation in amount of records read from SIM
> > =

> > CBS:
> > CBS reception in GSM
> > Subscribe Topics in range or specific value
> > =

> > Phone Info:
> > Revision of the modem SW
> > IMEI
> > =

> > This specific patch contains updates in Makefile.am, configure.ac and g=
isi to prepare the addition of isimodem2.5
> > Added 2 new files to gisi pipe_wg25.c and pipe_wg25.h, isimodem2.5 pipe=
 implementation due to pipe handler not on modem side.
> =

> this needs to be split into separate patches and the commit message
> needs to be a bit cleaner.
> =

> Also is this in sync with the GISI re-write Aki is doing?
> =

> Regards
> =

> Marcel
> =

> =

> =

> =

> ------------------------------
> =

> Message: 8
> Date: Wed, 8 Dec 2010 11:34:40 +0200
> From: Aki Niemi <aki@protocolpolice.com>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 0/5] Call Counters (2nd)
> Message-ID:
> 	<AANLkTinYryk1jdhdVRXh1RXn5CvwrD_A8y2GPBcP0ZsK@mail.gmail.com>
> Content-Type: text/plain; charset=3DUTF-8
> =

> Hi Marcel,
> =

> 2010/12/8 Marcel Holtmann <marcel@holtmann.org>:
> > so Denis and I talked about this a little bit and I am not fine with
> > this at all.
> =

> Next time, can you invite me to join your little talk?
> =

> > Lets take this one step and please explain to me what your requirements
> > and objectives are. I also wanna see a top to bottom from UI down to the
> > modem usage of this API.
> =

> We need a UI showing total MO and MT call times. They also need to be
> able to be reset, if the user so wishes. The data needs to be
> reasonably reliable.
> =

> > and consuming heavy IO with writing this information to disk. In
> > addition to that there is no clear UI usage for the getter API.
> =

> What do you mean? Do you mean your iPhone has no such UI?
> =

> The reason these are not properties is just because it makes no sense
> to update the counters "live". The UI can poll if it so wishes, but
> the poll interval is not something we want to decide.
> =

> > What are the granularity there. What is the expected user experience
> > with this API. I don't see any clear usage model here.
> >
> > In addition to that, what is the problem with just updating the stats
> > after the call has ended?
> =

> Because if your battery runs out in the middle of a 4 hour conference
> call, your timers are not updated and become worthless. Obviously,
> this is a compromise between how reliable the counters are and how
> many wakeups and IO we can bear.
> =

> Andras has some data on what reasonable reliability here means.
> =

> Cheers,
> Aki
> =

> =

> ------------------------------
> =

> Message: 9
> Date: Wed, 08 Dec 2010 04:55:21 -0600
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: [RFC PATCH 2/4] modem: add EmergencyMode property
> Message-ID: <4CFF6419.3090402@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
> =

> Hi Pekka,
> =

> >> So my only major concern left is here actually.  If we activate an
> >> emergency call and a set_property(Online, blah) is active, we get into
> >> some funny race conditions.  I mentioned these to Pekka on IRC.  But
> >> basically the worst one is if we have an Online=3DFalse operation pend=
ing.
> >>  In this case your call proceeds, but then gets terminated shortly
> >> thereafter by the offline procedure ;)
> > =

> > That is a tricky problem. I'd say the most straightforward way is to
> > return an error if there is a pending operation and push these
> > problems up the stack. In any case dialer has to retry ecall if user
> > tries to make the emergency call just after or before moving device to
> > offline / removing SIM card / etc. However, I'm not sure if we can
> > propagate the error in all cases where ofono_modem_inc_emergency()
> > gets called.
> =

> There's really no way for the voicecall atom to know that a modem is
> undergoing an online / offline transition..
> =

> > =

> > In order to manage the worst case in best possible manner, I'd check
> > for set_online in progress here. Return FALSE from
> > ofono_modem_get_online() immediately after the set_online(FALSE) call
> > is made. Also, check the emergency state again in after set_online
> > callback response. The online/offline watches should be called before
> > the set_online() call. (I have no idea what we will do should
> > set_online(FALSE) fail)?
> > =

> =

> So my thinking was essentially along the same lines.  We can check
> whether an Online change operation is in progress by peeking at the
> pending D-Bus message.  If we're going online, then not triggering
> another set_online call and waiting for the online_cb should be sufficien=
t.
> =

> If we're going offline, then returning FALSE from ofono_modem_get_online
> and re-checking the emergency counter in the offline_cb seems like the
> way to go.
> =

> I'd like to take care of this completely inside oFono and not bother the
> dialer with these details.  Thoughts?
> =

> Regards,
> -Denis
> =

> =

> =

> ------------------------------
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
> =

> =

> End of ofono Digest, Vol 20, Issue 28
> *************************************
 		 	   		 =20

--===============6934529195763162263==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpU
YWhvbWEKfQotLT48L3N0eWxlPgo8L2hlYWQ+Cjxib2R5IGNsYXNzPSdobW1lc3NhZ2UnPgpIZWxs
byw8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgaXMgcmVnYXJkaW5nIGRyaXZpbmcgU1QtRXJpY3Nz
b24gTW9kZW0gKHdoaWNoIHVzZXIgQ0FJRiBwcm90b2NvbCkgdXNpbmcgT0Zvbm8gZnJhbWV3b3Jr
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SG9zdDogTGludXg8L2Rpdj48ZGl2PlRhcmdldCA6
IFNULUVyaWNzc29uIEdTTSBNb2RlbTwvZGl2PjxkaXY+Q29tbXVuaWNhdGlvbjogUlMyMzIgY2Fi
bGU8L2Rpdj48ZGl2PkRyaXZlcnM6IFZDUCAodmlydHVhbCBjb21wb3J0IGRyaXZlcnMgZnJvbSBG
VERJJm5ic3A7ZnRkaS1lbGFuLmtvLCZuYnNwO2Z0ZGlfc2lvLmtvKTwvZGl2PjxtZXRhIGh0dHAt
ZXF1aXY9ImNvbnRlbnQtdHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij48
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIGltcGxlbWVudGVkIENBSUYgcHJv
dG9jb2wgYW5kIGFibGUgdG8gZHJpdmUgU1QtRXJpY3Nzb24gQm9hcmQgdXNpbmcgc29tZSB0ZXN0
IEFwcGxpY2F0aW9uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgdW5kZXJzdGFuZCB0aGF0
IENBSUYgaXMgY29taW5nIGFzIGtlcm5lbCBkcml2ZXIgaW4gbGludXggMi42LjM2LiBXZSBhcmUg
dHJ5aW5nIHRvIHdyaXRlIHNvbWUgdGVzdCBhcHBsaWNhdGlvbiB3aGljaCB3aWxsIG1ha2UgdXNl
IG9mIENBSUYga2VybmVsIGRyaXZlciB0byBpbnRlcmFjdCB3aXRoIFNULUVyaWNzc29uIE1vZGVt
LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hlbiB3ZSBjb25uZWN0IGFueSBtb2RlbSBob3cg
T0Zvbm8gcmVjb2duaXplcyBpdD8gSXMgaXQgYmFzZWQgb24gcnVsZSBtZW50aW9uZWQgaW4gIjk3
LW9mb25vLnJ1bGVzIj8gb3Igd2lsbCBpdCBjb25zaWRlciBtb2RlbS5jb25mIGZpbGU/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2Ugc3VnZ2VzdCB1cyBhYm91dCB0aGUgcmlnaHQga2Vy
bmVsIHZlcnNpb24gd2UgbmVlZCB0byBkZWFsIHdpdGggJm5ic3A7aW4gb3JkZXIgdG8gZ2V0IGNv
bXBsZXRlIENBSUYgaW1wbGVtZW50YXRpb24uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFu
ayBZb3UsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+S3Jpc2hu
YTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjxicj4mZ3Q7IEZyb206IG9mb25v
LXJlcXVlc3RAb2Zvbm8ub3JnPGJyPiZndDsgU3ViamVjdDogb2Zvbm8gRGlnZXN0LCBWb2wgMjAs
IElzc3VlIDI4PGJyPiZndDsgVG86IG9mb25vQG9mb25vLm9yZzxicj4mZ3Q7IERhdGU6IFdlZCwg
OCBEZWMgMjAxMCAwMjo1NToyOSAtMDgwMDxicj4mZ3Q7IDxicj4mZ3Q7IFNlbmQgb2Zvbm8gbWFp
bGluZyBsaXN0IHN1Ym1pc3Npb25zIHRvPGJyPiZndDsgCW9mb25vQG9mb25vLm9yZzxicj4mZ3Q7
IDxicj4mZ3Q7IFRvIHN1YnNjcmliZSBvciB1bnN1YnNjcmliZSB2aWEgdGhlIFdvcmxkIFdpZGUg
V2ViLCB2aXNpdDxicj4mZ3Q7IAlodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25v
PGJyPiZndDsgb3IsIHZpYSBlbWFpbCwgc2VuZCBhIG1lc3NhZ2Ugd2l0aCBzdWJqZWN0IG9yIGJv
ZHkgJ2hlbHAnIHRvPGJyPiZndDsgCW9mb25vLXJlcXVlc3RAb2Zvbm8ub3JnPGJyPiZndDsgPGJy
PiZndDsgWW91IGNhbiByZWFjaCB0aGUgcGVyc29uIG1hbmFnaW5nIHRoZSBsaXN0IGF0PGJyPiZn
dDsgCW9mb25vLW93bmVyQG9mb25vLm9yZzxicj4mZ3Q7IDxicj4mZ3Q7IFdoZW4gcmVwbHlpbmcs
IHBsZWFzZSBlZGl0IHlvdXIgU3ViamVjdCBsaW5lIHNvIGl0IGlzIG1vcmUgc3BlY2lmaWM8YnI+
Jmd0OyB0aGFuICJSZTogQ29udGVudHMgb2Ygb2Zvbm8gZGlnZXN0Li4uIjxicj4mZ3Q7IDxicj4m
Z3Q7IDxicj4mZ3Q7IFRvZGF5J3MgVG9waWNzOjxicj4mZ3Q7IDxicj4mZ3Q7ICAgIDEuIFtQQVRD
SCA0LzRdIHNjcmlwdHM6IEFkZGVkIGluaXQucmMgc2NyaXB0IChKZXNzaWNhIE5pbHNzb24pPGJy
PiZndDsgICAgMi4gUkU6IFtQQVRDSF0gc3RrdXRpbDogZml4IGNyYXNoIGlzc3VlIGNhdXNlIGJ5
IG51bGwgbGVuZ3RoIG9mPGJyPiZndDsgICAgICAgdGV4dAlzdHJpbmcgKEx1Y2FzLCBHdWlsbGF1
bWVYKTxicj4mZ3Q7ICAgIDMuIFJlOiBbUEFUQ0ggMS8zXSBwbHVnaW5zOiBJbXBsZW1lbnRhdGlv
biBvZiBOZXR3b3JrIFRpbWU8YnI+Jmd0OyAgICAgICBwbHVnaW4gKE1hcmNlbCBIb2x0bWFubik8
YnI+Jmd0OyAgICA0LiBSZTogW1BBVENIIDAvNV0gQ2FsbCBDb3VudGVycyAoMm5kKSAoTWFyY2Vs
IEhvbHRtYW5uKTxicj4mZ3Q7ICAgIDUuIFJlOiBbUEFUQ0ggMS8zXSBwbHVnaW5zOiBJbXBsZW1l
bnRhdGlvbiBvZiBOZXR3b3JrIFRpbWU8YnI+Jmd0OyAgICAgICBwbHVnaW4gKEFraSBOaWVtaSk8
YnI+Jmd0OyAgICA2LiBSZTogW1BBVENIIDMvNF0gaXNpbW9kZW0yLjU6IENoYW5nZXMgdG8gYWRk
IGlzaW1vZGVtMi41PGJyPiZndDsgICAgICAgKE1hcmNlbCBIb2x0bWFubik8YnI+Jmd0OyAgICA3
LiBSZTogW1BBVENIIDEvNF0gZ2lzaTogQ2hhbmdlcyB0byBwcmVwYXJlIGZvciBpc2ltb2RlbTIu
NTxicj4mZ3Q7ICAgICAgIChNYXJjZWwgSG9sdG1hbm4pPGJyPiZndDsgICAgOC4gUmU6IFtQQVRD
SCAwLzVdIENhbGwgQ291bnRlcnMgKDJuZCkgKEFraSBOaWVtaSk8YnI+Jmd0OyAgICA5LiBSZTog
W1JGQyBQQVRDSCAyLzRdIG1vZGVtOiBhZGQgRW1lcmdlbmN5TW9kZSBwcm9wZXJ0eTxicj4mZ3Q7
ICAgICAgIChEZW5pcyBLZW56aW9yKTxicj4mZ3Q7IDxicj4mZ3Q7IDxicj4mZ3Q7IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS08YnI+Jmd0OyA8YnI+Jmd0OyBNZXNzYWdlOiAxPGJyPiZndDsgRGF0ZTogV2VkLCAgOCBE
ZWMgMjAxMCAwOTozNToyOSArMDEwMDxicj4mZ3Q7IEZyb206IEplc3NpY2EgTmlsc3NvbiAmbHQ7
amVzc2ljYS5qLm5pbHNzb25Ac3Rlcmljc3Nvbi5jb20mZ3Q7PGJyPiZndDsgVG86IG9mb25vQG9m
b25vLm9yZzxicj4mZ3Q7IENjOiBKZXNzaWNhIE5pbHNzb24gJmx0O2plc3NpY2Euai5uaWxzc29u
QHN0ZXJpY3Nzb24uY29tJmd0Ozxicj4mZ3Q7IFN1YmplY3Q6IFtQQVRDSCA0LzRdIHNjcmlwdHM6
IEFkZGVkIGluaXQucmMgc2NyaXB0PGJyPiZndDsgTWVzc2FnZS1JRDo8YnI+Jmd0OyAJJmx0OzEy
OTE3OTczMjktMjA1OTItMS1naXQtc2VuZC1lbWFpbC1qZXNzaWNhLmoubmlsc3NvbkBzdGVyaWNz
c29uLmNvbSZndDs8YnI+Jmd0OyA8YnI+Jmd0OyBVcGRhdGVzIGluIE1ha2VmaWxlLmFtIGFuZCB0
aGUgYWRkaW5nIG9mIGFuIGluaXQgZmlsZS48YnI+Jmd0OyA8YnI+Jmd0OyBSZWdhcmRzLDxicj4m
Z3Q7IEplc3NpY2EgTmlsc3Nvbjxicj4mZ3Q7IDxicj4mZ3Q7IC0tLTxicj4mZ3Q7ICBNYWtlZmls
ZS5hbSAgICB8ICAgMTAgKysrKysrKzxicj4mZ3Q7ICBzY3JpcHRzL29mb25vZCB8ICAgNzkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+
Jmd0OyAgMiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKTxi
cj4mZ3Q7ICBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9vZm9ub2Q8YnI+Jmd0OyA8YnI+Jmd0
OyBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5hbTxicj4mZ3Q7IGluZGV4IGE1
Yzg5ZjIuLjBlNmI3NjEgMTAwNjQ0PGJyPiZndDsgLS0tIGEvTWFrZWZpbGUuYW08YnI+Jmd0OyAr
KysgYi9NYWtlZmlsZS5hbTxicj4mZ3Q7IEBAIC04Miw2ICs4MiwxMCBAQCBnYXRjaGF0X3NvdXJj
ZXMgPSBnYXRjaGF0L2dhdGNoYXQuaCBnYXRjaGF0L2dhdGNoYXQuYyBcPGJyPiZndDsgIDxicj4m
Z3Q7ICB1ZGV2X2ZpbGVzID0gcGx1Z2lucy9vZm9uby5ydWxlczxicj4mZ3Q7ICA8YnI+Jmd0OyAr
aWYgSVNJTU9ERU0yNTxicj4mZ3Q7ICtpbml0X2ZpbGVzID0gc2NyaXB0cy9vZm9ub2Q8YnI+Jmd0
OyArZW5kaWY8YnI+Jmd0OyArPGJyPiZndDsgIGlmIFVERVY8YnI+Jmd0OyAgYnVpbHRpbl9tb2R1
bGVzICs9IHVkZXY8YnI+Jmd0OyAgYnVpbHRpbl9zb3VyY2VzICs9IHBsdWdpbnMvdWRldi5jPGJy
PiZndDsgQEAgLTU2MiwzICs1NjYsOSBAQCBpbmNsdWRlL29mb25vLyUuaDogaW5jbHVkZS8lLmg8
YnI+Jmd0OyAgPGJyPiZndDsgIGNsZWFuLWxvY2FsOjxicj4mZ3Q7ICAJQCQoUk0pIC1yZiBpbmNs
dWRlL29mb25vPGJyPiZndDsgKzxicj4mZ3Q7ICtpZiBJU0lNT0RFTTI1PGJyPiZndDsgK2luaXQt
c2NyaXB0czo8YnI+Jmd0OyArCSQoQU1fVl9hdCkkKE1LRElSX1ApICQoc3lzY29uZmRpcikvcmMu
ZC9pbml0LmQ8YnI+Jmd0OyArCUBpbnN0YWxsIC1tIDc1NSAkKGluaXRfZmlsZXMpICQoc3lzY29u
ZmRpcikvcmMuZC9pbml0LmQvb2Zvbm9kPGJyPiZndDsgK2VuZGlmPGJyPiZndDsgZGlmZiAtLWdp
dCBhL3NjcmlwdHMvb2Zvbm9kIGIvc2NyaXB0cy9vZm9ub2Q8YnI+Jmd0OyBuZXcgZmlsZSBtb2Rl
IDEwMDc1NTxicj4mZ3Q7IGluZGV4IDAwMDAwMDAuLjZmNTY4ZTg8YnI+Jmd0OyAtLS0gL2Rldi9u
dWxsPGJyPiZndDsgKysrIGIvc2NyaXB0cy9vZm9ub2Q8YnI+Jmd0OyBAQCAtMCwwICsxLDc5IEBA
PGJyPiZndDsgKyMhL2Jpbi9zaDxicj4mZ3Q7ICs8YnI+Jmd0OyArIyBJbml0IGZpbGUgZm9yIG9m
b25vIGRhZW1vbjxicj4mZ3Q7ICs8YnI+Jmd0OyArIyMjIEJFR0lOIElOSVQgSU5GTzxicj4mZ3Q7
ICsjIFByb3ZpZGVzOiBvZm9ub2Q8YnI+Jmd0OyArIyBSZXF1aXJlZC1TdGFydDogJGxvY2FsX2Zz
IGNvcHMgbXNhPGJyPiZndDsgKyMgUmVxdWlyZWQtU3RvcDo8YnI+Jmd0OyArIyBEZWZhdWx0LVN0
YXJ0OiAgMiAzIDQgNTxicj4mZ3Q7ICsjIERlZmF1bHQtU3RvcDogMCAxIDY8YnI+Jmd0OyArIyBj
aGtjb25maWc6IDIzNDUgOTkgMDE8YnI+Jmd0OyArIyBTaG9ydC1EZXNjcmlwdGlvbjogc3RhcnQg
YW5kIHN0b3Agb2Zvbm88YnI+Jmd0OyArIyBEZXNjcmlwdGlvbjogb2Zvbm88YnI+Jmd0OyArIyBN
b2RlbSBtaWRkbGV3YXJlIGZvciBhY2Nlc3NpbmcgdGhlIG1vZGVtPGJyPiZndDsgKyMgdGhyb3Vn
aCBwaG9uZXQgc29ja2V0cy48YnI+Jmd0OyArIyMjIEVORCBJTklUIElORk88YnI+Jmd0OyArPGJy
PiZndDsgK3Byb2duYW1lPW9mb25vZDxicj4mZ3Q7ICtleGVjbmFtZT0vdXNyL3NiaW4vJHByb2du
YW1lPGJyPiZndDsgK2xvY2tmaWxlPS92YXIvbG9jay9zdWJzeXMvJHByb2duYW1lPGJyPiZndDsg
K29wdGlvbnM9IiI8YnI+Jmd0OyArPGJyPiZndDsgKyMgU2FuaXR5IGNoZWNrPGJyPiZndDsgK1sg
LXggJGV4ZWNuYW1lIF0gfHwgZXhpdCA1PGJyPiZndDsgKzxicj4mZ3Q7ICsjIFNvdXJjZSBmdW5j
dGlvbiBsaWJyYXJ5Ljxicj4mZ3Q7ICsuIC9ldGMvaW5pdC5kL2Z1bmN0aW9uczxicj4mZ3Q7ICs8
YnI+Jmd0OyArUkVUVkFMPTA8YnI+Jmd0OyArPGJyPiZndDsgK3N0YXJ0KCkgezxicj4mZ3Q7ICs8
YnI+Jmd0OyArICAgICAgICBlY2hvIC1uICJTdGFydGluZyAkcHJvZ25hbWU6ICI8YnI+Jmd0OyAr
ICAgICAgICAvc2Jpbi9pZmNvbmZpZyBzaHJtMCB1cDxicj4mZ3Q7ICsgICAgICAgIGRhZW1vbiAk
ZXhlY25hbWUgJG9wdGlvbnM8YnI+Jmd0OyArICAgICAgICBSRVRWQUw9JD88YnI+Jmd0OyArICAg
ICAgICBbICRSRVRWQUwgLWVxIDAgXSAmYW1wOyZhbXA7IHRvdWNoICRsb2NrZmlsZTxicj4mZ3Q7
ICsgICAgICAgIGVjaG88YnI+Jmd0OyArICAgICAgICByZXR1cm4gJFJFVFZBTDxicj4mZ3Q7ICt9
PGJyPiZndDsgKzxicj4mZ3Q7ICtzdG9wKCkgezxicj4mZ3Q7ICsgICAgICAgIGVjaG8gLW4gIlN0
b3BwaW5nICRwcm9nbmFtZTogIjxicj4mZ3Q7ICsgICAgICAgIGtpbGxwcm9jICRwcm9nbmFtZTxi
cj4mZ3Q7ICsgICAgICAgIFJFVFZBTD0kPzxicj4mZ3Q7ICsgICAgICAgIGVjaG88YnI+Jmd0OyAr
ICAgICAgICBbICRSRVRWQUwgLWVxIDAgXSAmYW1wOyZhbXA7IHJtIC1mICRsb2NrZmlsZTxicj4m
Z3Q7ICsgICAgICAgIHJldHVybiAkUkVUVkFMPGJyPiZndDsgK308YnI+Jmd0OyArPGJyPiZndDsg
K2Nhc2UgIiQxIiBpbjxicj4mZ3Q7ICsgIHN0YXJ0KTxicj4mZ3Q7ICsgICAgICAgIHN0YXJ0PGJy
PiZndDsgKyAgICAgICAgOzs8YnI+Jmd0OyArICBzdG9wKTxicj4mZ3Q7ICsgICAgICAgIHN0b3A8
YnI+Jmd0OyArICAgICAgICA7Ozxicj4mZ3Q7ICsgIHJlbG9hZCk8YnI+Jmd0OyArICA7Ozxicj4m
Z3Q7ICsgIHJlc3RhcnR8Zm9yY2UtcmVsb2FkKTxicj4mZ3Q7ICsgICAgICAgIHN0b3A8YnI+Jmd0
OyArICAgICAgICBzdGFydDxicj4mZ3Q7ICsgICAgICAgIDs7PGJyPiZndDsgKyAgc3RhdHVzKTxi
cj4mZ3Q7ICsgICAgICAgIHN0YXR1cyAkcHJvZ25hbWU8YnI+Jmd0OyArICAgICAgICBSRVRWQUw9
JD88YnI+Jmd0OyArICAgICAgICA7Ozxicj4mZ3Q7ICsgIHRyeS1yZXN0YXJ0KTxicj4mZ3Q7ICsg
ICAgICAgIGlmIFsgLWYgJGxvY2tmaWxlIF07IHRoZW48YnI+Jmd0OyArICAgICAgICAgICAgc3Rv
cDxicj4mZ3Q7ICsgICAgICAgICAgICBzdGFydDxicj4mZ3Q7ICsgICAgICAgIGZpPGJyPiZndDsg
KyAgICAgICAgOzs8YnI+Jmd0OyArICAqKTxicj4mZ3Q7ICsgICAgICAgIGVjaG8gJCJVc2FnZTog
JDAge3N0YXJ0fHN0b3B8cmVzdGFydHx0cnktcmVzdGFydHxyZWxvYWR8Zm9yY2UtcmVsb2FkfHN0
YXR1c30iPGJyPiZndDsgKyAgICAgICAgUkVUVkFMPSQ/PGJyPiZndDsgK2VzYWM8YnI+Jmd0OyAr
PGJyPiZndDsgK2V4aXQgJFJFVFZBTDxicj4mZ3Q7IC0tIDxicj4mZ3Q7IDEuNy4zLjI8YnI+Jmd0
OyA8YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+Jmd0OyA8YnI+Jmd0OyBNZXNzYWdlOiAyPGJyPiZndDsgRGF0ZTogV2VkLCA4IERlYyAy
MDEwIDA4OjM3OjE5ICswMDAwPGJyPiZndDsgRnJvbTogIkx1Y2FzLCBHdWlsbGF1bWVYIiAmbHQ7
Z3VpbGxhdW1leC5sdWNhc0BpbnRlbC5jb20mZ3Q7PGJyPiZndDsgVG86ICJvZm9ub0BvZm9uby5v
cmciICZsdDtvZm9ub0BvZm9uby5vcmcmZ3Q7PGJyPiZndDsgU3ViamVjdDogUkU6IFtQQVRDSF0g
c3RrdXRpbDogZml4IGNyYXNoIGlzc3VlIGNhdXNlIGJ5IG51bGwgbGVuZ3RoIG9mPGJyPiZndDsg
CXRleHQJc3RyaW5nPGJyPiZndDsgTWVzc2FnZS1JRDo8YnI+Jmd0OyAJJmx0OzlGM0VBQkQ2RTM0
MTlCNEM4MUYzNEVBQUJCNEQ0MDE4ODEzNkQ5NUQ0QkBpcnNtc3g1MDEuZ2VyLmNvcnAuaW50ZWwu
Y29tJmd0Ozxicj4mZ3Q7IAk8YnI+Jmd0OyBDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9InV0Zi04Ijxicj4mZ3Q7IDxicj4mZ3Q7IEhpPGJyPiZndDsgPGJyPiZndDsgJmd0OyA8YnI+
Jmd0OyAmZ3Q7IE9uIDcgRGVjZW1iZXIgMjAxMCAyMjo1NSwgICZsdDtKZWV2YWthLkJhZHJhcHBh
bkBlbGVrdHJvYml0LmNvbSZndDsgd3JvdGU6PGJyPiZndDsgJmd0OyAmZ3Q7IEhpIEd1aWxsYXVt
ZSw8YnI+Jmd0OyAmZ3Q7ICZndDs8YnI+Jmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPiZndDsgJmd0OyAm
Z3Q7Jmd0OyBBY2NvcmRpbmcgdG8gM0dQUCBUUyAzMS4xMjQgYSBudWxsIGxlbmd0aCBmb3IgdGhl
IHRleHQgc3RyaW5nPGJyPiZndDsgJmd0OyAmZ3Q7Jmd0OyBzaG91bGQgYmUgYWxsb3dlZC4gQW4g
ZW1wdHkgc3RyaW5nIG11c3QgYmUgcmV0dXJuZWQgdG8gdGhlPGJyPiZndDsgJmd0OyAmZ3Q7Jmd0
OyB1c2VyIGluIHRoaXMgY2FzZS48YnI+Jmd0OyAmZ3Q7ICZndDsmZ3Q7IC0tLTxicj4mZ3Q7ICZn
dDsgJmd0OyZndDsgP3NyYy9zdGt1dGlsLmMgfCA/ID82ICsrKystLTxicj4mZ3Q7ICZndDsgJmd0
OyZndDsgPzEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxi
cj4mZ3Q7ICZndDsgJmd0OyZndDs8YnI+Jmd0OyAmZ3Q7ICZndDs8YnI+Jmd0OyAmZ3Q7ICZndDsg
QWdyZWUuIEFzIHBlciB0aGUgM0dQUCBUUyAzMS4xMjQgbnVsbCB0ZXh0IHN0cmluZyB3aWxsIGJl
IGluZGljYXRlZDxicj4mZ3Q7ICZndDsgd2l0aDxicj4mZ3Q7ICZndDsgJmd0OyBsZW5ndGggMC48
YnI+Jmd0OyAmZ3Q7ICZndDsgU28sIGluIGZpcnN0IHBsYWNlIGlmICh0ZXh0ID09IE5VTEwpIGNo
ZWNrIGluPGJyPiZndDsgJmd0OyBoYW5kbGVfY29tbWFuZF9nZXRfaW5wdXQsPGJyPiZndDsgJmd0
OyAmZ3Q7IGhhbmRsZV9jb21tYW5kX2dldF9pbmtleSBoYXMgdG8gYmUgcmVtb3ZlZC4gUmVtb3Zp
bmcgdGhpcyBjaGVjayB3aWxsPGJyPiZndDsgJmd0OyAmZ3Q7IHJlc3VsdDxicj4mZ3Q7ICZndDsg
Jmd0OyBpbiBjcmFzaCBkdWUgdG8gdGhlIGZhY3QgdGhhdCB3ZSBhcmUgbm90IGhhbmRsaW5nIHRo
aXMgY2FzZSBwcm9wZXJseTxicj4mZ3Q7ICZndDsgJmd0OyBuZWl0aGVyPGJyPiZndDsgJmd0OyAm
Z3Q7IGluIHBhcnNlX2RhdGFvYmpfdGV4dCBub3IgaW4gY29ycmVzcG9uZGluZyBzdGthZ2VudCBm
dW5jdGlvbnMuPGJyPiZndDsgJmd0OyAmZ3Q7PGJyPiZndDsgJmd0OyAmZ3Q7IFRoZXJlIGFyZSAy
d2F5cyB0byBzb2x2ZSB0aGlzIGlzc3VlOjxicj4mZ3Q7ICZndDsgJmd0Ozxicj4mZ3Q7ICZndDsg
Jmd0OyBGaXJzdCBvcHRpb24gLSBGaXggcHJvdmlkZWQgaW4gdGhlIGZ1bmN0aW9uIHBhcnNlX2Rh
dGFvYmpfdGV4dCggZS5nLjxicj4mZ3Q7ICZndDsgJmd0OyAqdGV4dCA9ICIiKTxicj4mZ3Q7ICZn
dDsgJmd0OyBTZWNvbmQgb3B0aW9uIC0gSW4gYWxsIHRoZSBzdGtfYWdlbnRfIGZ1bmN0aW9uIHdo
aWNoIGhhcyB0aGlzIHRleHQ8YnI+Jmd0OyAmZ3Q7ICZndDsgc3RyaW5nIHdlPGJyPiZndDsgJmd0
OyAmZ3Q7ID8gPyA/ID8gPyA/ID8gP25lZWQgdG8gY2hlY2sgZm9yIE5VTEwgYW5kIGFzc2lnbiBp
dCB0byBlbXB0eSBzdHJpbmc8YnI+Jmd0OyAmZ3Q7IGlmPGJyPiZndDsgJmd0OyAmZ3Q7IGl0IGlz
IE5VTEwuPGJyPiZndDsgJmd0OyAmZ3Q7PGJyPiZndDsgJmd0OyAmZ3Q7IEZpcnN0IG9wdGlvbiBz
ZWVtcyB0byBiZSByaWdodCBhbmQgYWxzbyBiZXR0ZXIgb25lLjxicj4mZ3Q7ICZndDsgPGJyPiZn
dDsgPGJyPiZndDsgQWdyZWUuIEl0J3Mgd2h5IEkndmUgZGlkIHRoaXMgb25lIDopPGJyPiZndDsg
SSdsbCBiZSBtb3JlIGV4cGxpY2l0IGluIHRoZSBkZXNjcmlwdGlvbiBmb3IgbXkgZnV0dXJlIHBh
dGNoZXMuIEVzcGVjaWFsbHkgZm9yIGNyYXNoIGlzc3VlLjxicj4mZ3Q7IDxicj4mZ3Q7IFJlZ2Fy
ZHMsPGJyPiZndDsgR3VpbGxhdW1lPGJyPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgSW50ZWwg
Q29ycG9yYXRpb24gU0FTIChGcmVuY2ggc2ltcGxpZmllZCBqb2ludCBzdG9jayBjb21wYW55KTxi
cj4mZ3Q7IFJlZ2lzdGVyZWQgaGVhZHF1YXJ0ZXJzOiAiTGVzIE1vbnRhbGV0cyItIDIsIHJ1ZSBk
ZSBQYXJpcywgPGJyPiZndDsgOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2U8YnI+Jmd0OyBSZWdp
c3RyYXRpb24gTnVtYmVyOiAgMzAyIDQ1NiAxOTkgUi5DLlMuIE5BTlRFUlJFPGJyPiZndDsgQ2Fw
aXRhbDogNCw1NzIsMDAwIEV1cm9zPGJyPiZndDsgPGJyPiZndDsgVGhpcyBlLW1haWwgYW5kIGFu
eSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yPGJyPiZn
dDsgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcg
b3IgZGlzdHJpYnV0aW9uPGJyPiZndDsgYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZDxicj4mZ3Q7IHJlY2lwaWVudCwgcGxlYXNlIGNv
bnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuPGJyPiZndDsgPGJyPiZndDsg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJyPiZndDsgTWVzc2FnZTog
Mzxicj4mZ3Q7IERhdGU6IFdlZCwgMDggRGVjIDIwMTAgMDk6NDQ6MTIgKzAxMDA8YnI+Jmd0OyBG
cm9tOiBNYXJjZWwgSG9sdG1hbm4gJmx0O21hcmNlbEBob2x0bWFubi5vcmcmZ3Q7PGJyPiZndDsg
VG86IG9mb25vQG9mb25vLm9yZzxicj4mZ3Q7IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBwbHVn
aW5zOiBJbXBsZW1lbnRhdGlvbiBvZiBOZXR3b3JrIFRpbWU8YnI+Jmd0OyAJcGx1Z2luPGJyPiZn
dDsgTWVzc2FnZS1JRDogJmx0OzEyOTE3OTc4NTIuNDc5NS4xMzcuY2FtZWxAYWVvbmZsdXgmZ3Q7
PGJyPiZndDsgQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PSJVVEYtOCI8YnI+Jmd0
OyA8YnI+Jmd0OyBIaSBBa2ksPGJyPiZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgd2hlcmUg
aXMgdGhpcyB0aW1lZCBydW5uaW5nPyBJIHByZWZlciB0aGUgcGx1Z2luIGp1c3Qgc2VuZCBhIEQt
QnVzPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgbWVzc2FnZSB0byB0aGUgdGltZWQgZGlyZWN0bHkg
aW5zdGVhZCBvZiBhIEdldC9DaGFuZ2VkIEFQSSBraW5kIG9mPGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgdGhpbmcuPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyBBRkFJSywgdGlt
ZWQgaXMgaW4gc3lzdGVtIGJ1cy4gSG93ZXZlciwgSSBmYWlsIHRvIHNlZSBob3cgeW91IGNhbiBt
YWtlPGJyPiZndDsgJmd0OyAmZ3Q7IHRoaXMgYW55IHNpbXBsZXIuIEluIHRoZSBlbmQsIG9uZSBv
ZiB0aGUgdHdvIGVudGl0aWVzIGhhcyB0byBpbXBsZW1lbnQ8YnI+Jmd0OyAmZ3Q7ICZndDsgYSBz
ZXJ2aWNlIHRoYXQgdGhlIG90aGVyIG9uZSB1c2VzLiBUaGVyZSBhbHNvIG5lZWRzIHRvIGJlIHNv
bWU8YnI+Jmd0OyAmZ3Q7ICZndDsgc3luY2hyb25pemF0aW9uIGZvciB3aGVuIHRoZSBlbnRpdGll
cyBzdGFydCB1cC4gQSBnZXR0ZXIvc2lnbmFsIEFQSSBpczxicj4mZ3Q7ICZndDsgJmd0OyBhbHNv
IHdoYXQgdGltZWQgdXNlcyBpbiBIYXJtYXR0YW4sIGJ1dCBvZiBjb3Vyc2UgaWYgeW91IGhhdmUg
YSBiZXR0ZXI8YnI+Jmd0OyAmZ3Q7ICZndDsgaWRlYSwgSSdtIGFsbCBlYXJzLjxicj4mZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyBpcyB0aW1lZCBhY3R1YWxseSBvcGVuIHNvdXJjZSBhbmQgSSBjYW4g
aGF2ZSBhIGxvb2sgYXQgaXQ/PGJyPiZndDsgPGJyPiZndDsgc28gd2hhdCBhYm91dCB0aGlzPyBX
aGVyZSBpcyB0aGUgdGltZWQgcmVzcG9zaXRvcnk/IEkgcmVhbGx5IHdhbm5hIGhhdmU8YnI+Jmd0
OyBhIGxvb2sgYXQgaXQgYW5kIHNlZSB3aGF0IGl0IGlzIGRvaW5nLjxicj4mZ3Q7IDxicj4mZ3Q7
IFJlZ2FyZHM8YnI+Jmd0OyA8YnI+Jmd0OyBNYXJjZWw8YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0
OyA8YnI+Jmd0OyA8YnI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Jmd0
OyA8YnI+Jmd0OyBNZXNzYWdlOiA0PGJyPiZndDsgRGF0ZTogV2VkLCAwOCBEZWMgMjAxMCAxMDow
MzowNCArMDEwMDxicj4mZ3Q7IEZyb206IE1hcmNlbCBIb2x0bWFubiAmbHQ7bWFyY2VsQGhvbHRt
YW5uLm9yZyZndDs8YnI+Jmd0OyBUbzogb2Zvbm9Ab2Zvbm8ub3JnPGJyPiZndDsgU3ViamVjdDog
UmU6IFtQQVRDSCAwLzVdIENhbGwgQ291bnRlcnMgKDJuZCk8YnI+Jmd0OyBNZXNzYWdlLUlEOiAm
bHQ7MTI5MTc5ODk4NC40Nzk1LjE0Ni5jYW1lbEBhZW9uZmx1eCZndDs8YnI+Jmd0OyBDb250ZW50
LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9IlVURi04Ijxicj4mZ3Q7IDxicj4mZ3Q7IEhpIEFr
aSw8YnI+Jmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgSGVyZSBhIHByb3Bvc2FsIGZvciBjYWxsIGNv
dW50ZXJzIGltcGxlbWVudGF0aW9uIGZvciBrZWVwaW5nIHRyYWNrPGJyPiZndDsgJmd0OyAmZ3Q7
IG9mIHRoZSB0b3RhbCBpbmNvbWluZyBhbmQgb3V0Z29pbmcgY2FsbCBkdXJhdGlvbiBjb3VudGVy
cy4gRWFjaDxicj4mZ3Q7ICZndDsgJmd0OyBlc3RhYmxpc2hlZCBjYWxsIGluc3RhbmNlIGlzIGNv
bnRyaWJ1dGluZyB0byBlaXRoZXIgb2YgdGhlIGNhbGw8YnI+Jmd0OyAmZ3Q7ICZndDsgZHVyYXRp
b24gY291bnRlcnMuIFRoZSAyIGNvdW50ZXJzIGFyZSB1cGRhdGVkIHBlcmlvZGljYWxseSB3aGVu
PGJyPiZndDsgJmd0OyAmZ3Q7IHRoZXJlIGlzIGFuIGVzdGFibGlzaGVkIGNhbGwgYW5kIHRoZSBp
bmZvcm1hdGlvbiBpcyBzdG9yZWQgaW48YnI+Jmd0OyAmZ3Q7ICZndDsgYSBmaWxlLiBUaGUgYm9v
a2tlZXBpbmcgb2YgdGhlIGNhbGwgZHVyYXRpb24gY291bnRlcnMgYXJlIHBlciBJTVNJPGJyPiZn
dDsgJmd0OyAmZ3Q7IG51bWJlci48YnI+Jmd0OyAmZ3Q7ICZndDsgVGhlIGltcGxlbWVudGF0aW9u
IG1ha2VzIHVzZSBvZiB0aGUgaGlzdG9yeSBmcmFtZXdvcmsgd2hpY2ggaGFkIHRvIGJlPGJyPiZn
dDsgJmd0OyAmZ3Q7IGV4cGFuZGVkIHdpdGggYSBmdW5jdGlvbiBmb3IgbWFya2luZyB0aGUgYmVn
aW5uaW5nIG9mIGEgdm9pY2UgY2FsbC48YnI+Jmd0OyAmZ3Q7ICZndDsgVGhlcmUgaXMgYSBELUJ1
cyBpbnRlcmZhY2UgdG8gY2FsbCBjb3VudGVycyBmb3IgcmVhZGluZyBhbmQgY2xlYXJpbmc8YnI+
Jmd0OyAmZ3Q7ICZndDsgdGhlIGNvdW50ZXJzLjxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyBU
aGlzIHNldCBsb29rcyBnb29kIHRvIG1lLCBhbmQgSSBiZWxpZXZlIHlvdSBmaXhlZCB0aGUgaXNz
dWVzIGZyb208YnI+Jmd0OyAmZ3Q7IHByZXZpb3VzIHJldmlldyBjb21tZW50cy4gRGVuaXMsIGFy
ZSB5b3Ugb2sgd2l0aCB0aGlzPzxicj4mZ3Q7IDxicj4mZ3Q7IHNvIERlbmlzIGFuZCBJIHRhbGtl
ZCBhYm91dCB0aGlzIGEgbGl0dGxlIGJpdCBhbmQgSSBhbSBub3QgZmluZSB3aXRoPGJyPiZndDsg
dGhpcyBhdCBhbGwuPGJyPiZndDsgPGJyPiZndDsgTGV0cyB0YWtlIHRoaXMgb25lIHN0ZXAgYW5k
IHBsZWFzZSBleHBsYWluIHRvIG1lIHdoYXQgeW91ciByZXF1aXJlbWVudHM8YnI+Jmd0OyBhbmQg
b2JqZWN0aXZlcyBhcmUuIEkgYWxzbyB3YW5uYSBzZWUgYSB0b3AgdG8gYm90dG9tIGZyb20gVUkg
ZG93biB0byB0aGU8YnI+Jmd0OyBtb2RlbSB1c2FnZSBvZiB0aGlzIEFQSS48YnI+Jmd0OyA8YnI+
Jmd0OyBNeSBtYWluIGNvbmNlcm5zIGFyZSBoZXJlIHRoYXQgd2UgYXJlIHdha2luZyB1cCBvZm9u
b2QgZXZlcnkgMTAgc2Vjb25kczxicj4mZ3Q7IGFuZCBjb25zdW1pbmcgaGVhdnkgSU8gd2l0aCB3
cml0aW5nIHRoaXMgaW5mb3JtYXRpb24gdG8gZGlzay4gSW48YnI+Jmd0OyBhZGRpdGlvbiB0byB0
aGF0IHRoZXJlIGlzIG5vIGNsZWFyIFVJIHVzYWdlIGZvciB0aGUgZ2V0dGVyIEFQSS48YnI+Jmd0
OyA8YnI+Jmd0OyBXaGF0IGFyZSB0aGUgZ3JhbnVsYXJpdHkgdGhlcmUuIFdoYXQgaXMgdGhlIGV4
cGVjdGVkIHVzZXIgZXhwZXJpZW5jZTxicj4mZ3Q7IHdpdGggdGhpcyBBUEkuIEkgZG9uJ3Qgc2Vl
IGFueSBjbGVhciB1c2FnZSBtb2RlbCBoZXJlLjxicj4mZ3Q7IDxicj4mZ3Q7IEluIGFkZGl0aW9u
IHRvIHRoYXQsIHdoYXQgaXMgdGhlIHByb2JsZW0gd2l0aCBqdXN0IHVwZGF0aW5nIHRoZSBzdGF0
czxicj4mZ3Q7IGFmdGVyIHRoZSBjYWxsIGhhcyBlbmRlZD88YnI+Jmd0OyA8YnI+Jmd0OyBBcmUg
eW91IHJlYWxseSBleHBlY3RpbmcgcmVhbHRpbWUgdXBkYXRlcyBvZiBjYWxsIHRpbWUgc3RhdHMg
Zm9yIHNvbWU8YnI+Jmd0OyBoaWRkZW4gVUkgc3RhdHMgbWVudT8gVGhpcyB3b3VsZCBiZSBhIHJl
YWxseSBleHBlbnNpdmUgY2hhbmdlIGZvciBqdXN0PGJyPiZndDsgZG9pbmcgdGhhdC48YnI+Jmd0
OyA8YnI+Jmd0OyBIYXMgYW55Ym9keSBsb29rZWQgYXQgaG93IHdlIGFyZSBkb2luZyByZWFsdGlt
ZSBzdGF0cyBpbnNpZGUgQ29ubk1hbj88YnI+Jmd0OyA8YnI+Jmd0OyBSZWdhcmRzPGJyPiZndDsg
PGJyPiZndDsgTWFyY2VsPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZn
dDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJyPiZndDsgTWVzc2Fn
ZTogNTxicj4mZ3Q7IERhdGU6IFdlZCwgOCBEZWMgMjAxMCAxMToxOTo0OCArMDIwMDxicj4mZ3Q7
IEZyb206IEFraSBOaWVtaSAmbHQ7YWtpQHByb3RvY29scG9saWNlLmNvbSZndDs8YnI+Jmd0OyBU
bzogb2Zvbm9Ab2Zvbm8ub3JnPGJyPiZndDsgU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIHBsdWdp
bnM6IEltcGxlbWVudGF0aW9uIG9mIE5ldHdvcmsgVGltZTxicj4mZ3Q7IAlwbHVnaW48YnI+Jmd0
OyBNZXNzYWdlLUlEOjxicj4mZ3Q7IAkmbHQ7QUFOTGtUaW42S1hkMFVNcThhY1pvam1TY3lCUE1z
c1NXaEgyK2JOZXpneDhUQG1haWwuZ21haWwuY29tJmd0Ozxicj4mZ3Q7IENvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtODxicj4mZ3Q7IDxicj4mZ3Q7IEhpIE1hcmNlbCw8YnI+
Jmd0OyA8YnI+Jmd0OyAyMDEwLzEyLzggTWFyY2VsIEhvbHRtYW5uICZsdDttYXJjZWxAaG9sdG1h
bm4ub3JnJmd0Ozo8YnI+Jmd0OyAmZ3Q7Jmd0OyBpcyB0aW1lZCBhY3R1YWxseSBvcGVuIHNvdXJj
ZSBhbmQgSSBjYW4gaGF2ZSBhIGxvb2sgYXQgaXQ/PGJyPiZndDsgJmd0Ozxicj4mZ3Q7ICZndDsg
c28gd2hhdCBhYm91dCB0aGlzPyBXaGVyZSBpcyB0aGUgdGltZWQgcmVzcG9zaXRvcnk/IEkgcmVh
bGx5IHdhbm5hIGhhdmU8YnI+Jmd0OyAmZ3Q7IGEgbG9vayBhdCBpdCBhbmQgc2VlIHdoYXQgaXQg
aXMgZG9pbmcuPGJyPiZndDsgPGJyPiZndDsgS25vY2sgeW91cnNlbGYgb3V0Ojxicj4mZ3Q7IDxi
cj4mZ3Q7IGh0dHA6Ly9tZWVnby5naXRvcmlvdXMub3JnL21lZWdvLW1pZGRsZXdhcmUvdGltZWQ8
YnI+Jmd0OyA8YnI+Jmd0OyBDaGVlcnMsPGJyPiZndDsgQWtpPGJyPiZndDsgPGJyPiZndDsgPGJy
PiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJyPiZndDsgTWVz
c2FnZTogNjxicj4mZ3Q7IERhdGU6IFdlZCwgMDggRGVjIDIwMTAgMTA6MzA6MDQgKzAxMDA8YnI+
Jmd0OyBGcm9tOiBNYXJjZWwgSG9sdG1hbm4gJmx0O21hcmNlbEBob2x0bWFubi5vcmcmZ3Q7PGJy
PiZndDsgVG86IG9mb25vQG9mb25vLm9yZzxicj4mZ3Q7IENjOiBKZXNzaWNhIE5pbHNzb24gJmx0
O2plc3NpY2Euai5uaWxzc29uQHN0ZXJpY3Nzb24uY29tJmd0Ozxicj4mZ3Q7IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMy80XSBpc2ltb2RlbTIuNTogQ2hhbmdlcyB0byBhZGQgaXNpbW9kZW0yLjU8YnI+
Jmd0OyBNZXNzYWdlLUlEOiAmbHQ7MTI5MTgwMDYwNC40Nzk1LjE1MS5jYW1lbEBhZW9uZmx1eCZn
dDs8YnI+Jmd0OyBDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9IlVURi04Ijxicj4m
Z3Q7IDxicj4mZ3Q7IEhpIEplc3NpY2EsPGJyPiZndDsgPGJyPiZndDsgJmd0OyBVcGRhdGVzIGlu
IE1ha2VmaWxlLmFtIC0gYWRkaW5nIG9mIGlzaW1vZGVtMi41PGJyPiZndDsgJmd0OyBBZGRpbmcg
b2YgZHJpdmVycy9pc2ltb2RlbTIuNS8gZmlsZXMgdG8gZnVsbHkgbGlzdGVkIGZ1bmN0aW9uYWxp
dHkuPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IFJlZ2FyZHMsPGJyPiZndDsgJmd0OyBKZXNz
aWNhIE5pbHNzb248YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgLS0tPGJyPiZndDsgJmd0OyAg
TWFrZWZpbGUuYW0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzNiArLTxicj4m
Z3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvY2FsbC1iYXJyaW5nLmMgICAgICAgICB8ICA1
MDMgKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L2NhbGwtZm9yd2FyZGluZy5j
ICAgICAgfCAgNjEzICsrKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvY2FsbC1z
ZXR0aW5ncy5jICAgICAgICB8IDEwOTMgKysrKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1v
ZGVtMi41L2NhbGwuaCAgICAgICAgICAgICAgICAgfCAgMjM3ICs8YnI+Jmd0OyAmZ3Q7ICBkcml2
ZXJzL2lzaW1vZGVtMi41L2Nicy5jICAgICAgICAgICAgICAgICAgfCAgNDMzICsrPGJyPiZndDsg
Jmd0OyAgZHJpdmVycy9pc2ltb2RlbTIuNS9jaGVja3BhdGNoLnBsICAgICAgICAgIHwgMjc4OSAr
KysrKysrKysrKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L2RlYnVnLmMgICAg
ICAgICAgICAgICAgfCAgNjk0ICsrKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUv
ZGVidWcuaCAgICAgICAgICAgICAgICB8ICAgNjYgKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNp
bW9kZW0yLjUvZGV2aW5mby5jICAgICAgICAgICAgICB8ICAyNDYgKzxicj4mZ3Q7ICZndDsgIGRy
aXZlcnMvaXNpbW9kZW0yLjUvZ3Bkcy1jb250ZXh0LmMgICAgICAgICB8ICA3ODggKysrKzxicj4m
Z3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvZ3Bkcy5jICAgICAgICAgICAgICAgICB8ICAz
OTUgKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L2dwZHMuaCAgICAgICAgICAg
ICAgICAgfCAgMjk1ICsrPGJyPiZndDsgJmd0OyAgZHJpdmVycy9pc2ltb2RlbTIuNS9nc3MuaCAg
ICAgICAgICAgICAgICAgIHwgICA4NCArPGJyPiZndDsgJmd0OyAgZHJpdmVycy9pc2ltb2RlbTIu
NS9pbmZvLmggICAgICAgICAgICAgICAgIHwgICA1MyArPGJyPiZndDsgJmd0OyAgZHJpdmVycy9p
c2ltb2RlbTIuNS9pc2ltb2RlbS5jICAgICAgICAgICAgIHwgIDUzNCArKys8YnI+Jmd0OyAmZ3Q7
ICBkcml2ZXJzL2lzaW1vZGVtMi41L2lzaW1vZGVtLmggICAgICAgICAgICAgfCAgIDY5ICs8YnI+
Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L2lzaXV0aWwuaCAgICAgICAgICAgICAgfCAg
IDY0ICs8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L21jZS5oICAgICAgICAgICAg
ICAgICAgfCAgIDY1ICs8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41L25ldHdvcmst
cmVnaXN0cmF0aW9uLmMgfCAxMTU4ICsrKysrPGJyPiZndDsgJmd0OyAgZHJpdmVycy9pc2ltb2Rl
bTIuNS9uZXR3b3JrLmggICAgICAgICAgICAgIHwgIDI1NyArKzxicj4mZ3Q7ICZndDsgIGRyaXZl
cnMvaXNpbW9kZW0yLjUvcGhvbmVib29rLmMgICAgICAgICAgICB8IDEzMjAgKysrKysrPGJyPiZn
dDsgJmd0OyAgZHJpdmVycy9pc2ltb2RlbTIuNS9yYWRpby1zZXR0aW5ncy5jICAgICAgIHwgIDMx
MyArKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvc2ltdV9yZXNwcy5oICAgICAg
ICAgICB8IDY4MDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4mZ3Q7ICZndDsgIGRy
aXZlcnMvaXNpbW9kZW0yLjUvc21zLmMgICAgICAgICAgICAgICAgICB8ICA4NjkgKysrKzxicj4m
Z3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvc21zLmggICAgICAgICAgICAgICAgICB8ICAx
ODggKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvc3MuaCAgICAgICAgICAgICAg
ICAgICB8ICAxNzQgKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvc3NuLmMgICAg
ICAgICAgICAgICAgICB8ICA0NTYgKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVtMi41
L3RpbWVvdXQuaCAgICAgICAgICAgICAgfCAgIDMzICs8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lz
aW1vZGVtMi41L3VpY2MuYyAgICAgICAgICAgICAgICAgfCAzMzE2ICsrKysrKysrKysrKysrPGJy
PiZndDsgJmd0OyAgZHJpdmVycy9pc2ltb2RlbTIuNS91aWNjLmggICAgICAgICAgICAgICAgIHwg
IDI1MyArKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvdWljY19pbnRlcmZhY2Uu
aCAgICAgICB8ICAgNDAgKzxicj4mZ3Q7ICZndDsgIGRyaXZlcnMvaXNpbW9kZW0yLjUvdXNzZC5j
ICAgICAgICAgICAgICAgICB8ICAzNDEgKys8YnI+Jmd0OyAmZ3Q7ICBkcml2ZXJzL2lzaW1vZGVt
Mi41L3ZvaWNlY2FsbC5jICAgICAgICAgICAgfCAxNTU1ICsrKysrKys8YnI+Jmd0OyAmZ3Q7ICAz
NCBmaWxlcyBjaGFuZ2VkLCAyNjEyOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKTxicj4m
Z3Q7ICZndDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L2NhbGwtYmFy
cmluZy5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0y
LjUvY2FsbC1mb3J3YXJkaW5nLmM8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9pc2ltb2RlbTIuNS9jYWxsLXNldHRpbmdzLmM8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS9jYWxsLmg8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS9jYnMuYzxicj4mZ3Q7ICZndDsgIGNyZWF0
ZSBtb2RlIDEwMDc1NSBkcml2ZXJzL2lzaW1vZGVtMi41L2NoZWNrcGF0Y2gucGw8YnI+Jmd0OyAm
Z3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS9kZWJ1Zy5jPGJyPiZn
dDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0yLjUvZGVidWcuaDxi
cj4mZ3Q7ICZndDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L2Rldmlu
Zm8uYzxicj4mZ3Q7ICZndDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41
L2dwZHMtY29udGV4dC5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
aXNpbW9kZW0yLjUvZ3Bkcy5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvaXNpbW9kZW0yLjUvZ3Bkcy5oPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvaXNpbW9kZW0yLjUvZ3NzLmg8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9pc2ltb2RlbTIuNS9pbmZvLmg8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9pc2ltb2RlbTIuNS9pc2ltb2RlbS5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0yLjUvaXNpbW9kZW0uaDxicj4mZ3Q7ICZndDsgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L2lzaXV0aWwuaDxicj4mZ3Q7ICZn
dDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L21jZS5oPGJyPiZndDsg
Jmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0yLjUvbmV0d29yay1yZWdp
c3RyYXRpb24uYzxicj4mZ3Q7ICZndDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1v
ZGVtMi41L25ldHdvcmsuaDxicj4mZ3Q7ICZndDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2lzaW1vZGVtMi41L3Bob25lYm9vay5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvaXNpbW9kZW0yLjUvcmFkaW8tc2V0dGluZ3MuYzxicj4mZ3Q7ICZndDsgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L3NpbXVfcmVzcHMuaDxicj4mZ3Q7ICZn
dDsgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lzaW1vZGVtMi41L3Ntcy5jPGJyPiZndDsg
Jmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0yLjUvc21zLmg8YnI+Jmd0
OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS9zcy5oPGJyPiZn
dDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXNpbW9kZW0yLjUvc3NuLmM8YnI+
Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS90aW1lb3V0
Lmg8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIuNS91
aWNjLmM8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2RlbTIu
NS91aWNjLmg8YnI+Jmd0OyAmZ3Q7ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pc2ltb2Rl
bTIuNS91aWNjX2ludGVyZmFjZS5oPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvaXNpbW9kZW0yLjUvdXNzZC5jPGJyPiZndDsgJmd0OyAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvaXNpbW9kZW0yLjUvdm9pY2VjYWxsLmM8YnI+Jmd0OyA8YnI+Jmd0OyB0aGlzIGlz
IG5vdCBnb25uYSB3b3JrIHRoaXMgd2F5LiBObyBvbmUgY2FuIHJldmlldyBzdWNoIGEgbWFzc2l2
ZSBwYXRjaC48YnI+Jmd0OyBBY3R1YWxseSBFdm9sdXRpb24gZXZlbiByZWZ1c2VkIHRvIGZvcm1h
dCB0aGlzIGZvciBtZS48YnI+Jmd0OyA8YnI+Jmd0OyBTbyBwbGVhc2Ugc3BsaXQgdGhpcyBpbnRv
IG9uZSBwYXRjaCBwZXIgYXRvbSBkcml2ZXIuPGJyPiZndDsgPGJyPiZndDsgSW4gYWRkaXRpb24s
IEkgZG9uJ3QgYSBwb2ludCBpbiBhIGZpbGVuYW1lLiBTbyBpc2ltb2RlbTI1IG9yIGlzaW1vZGVt
Mjxicj4mZ3Q7IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQgcGxlYXNlLiBJIGFtIG9wZW4gZm9yIHBy
b3Bvc2Fscy48YnI+Jmd0OyA8YnI+Jmd0OyBSZWdhcmRzPGJyPiZndDsgPGJyPiZndDsgTWFyY2Vs
PGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJyPiZndDsgTWVzc2FnZTogNzxicj4mZ3Q7IERh
dGU6IFdlZCwgMDggRGVjIDIwMTAgMTA6MzE6MzUgKzAxMDA8YnI+Jmd0OyBGcm9tOiBNYXJjZWwg
SG9sdG1hbm4gJmx0O21hcmNlbEBob2x0bWFubi5vcmcmZ3Q7PGJyPiZndDsgVG86IG9mb25vQG9m
b25vLm9yZzxicj4mZ3Q7IENjOiBKZXNzaWNhIE5pbHNzb24gJmx0O2plc3NpY2Euai5uaWxzc29u
QHN0ZXJpY3Nzb24uY29tJmd0Ozxicj4mZ3Q7IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBnaXNp
OiBDaGFuZ2VzIHRvIHByZXBhcmUgZm9yIGlzaW1vZGVtMi41PGJyPiZndDsgTWVzc2FnZS1JRDog
Jmx0OzEyOTE4MDA2OTUuNDc5NS4xNTMuY2FtZWxAYWVvbmZsdXgmZ3Q7PGJyPiZndDsgQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PSJVVEYtOCI8YnI+Jmd0OyA8YnI+Jmd0OyBIaSBK
ZXNzaWNhLDxicj4mZ3Q7IDxicj4mZ3Q7ICZndDsgVGhpcyBzZXQgb2YgcGF0Y2hlcyBpbnRyb2R1
Y2VzIHRoZSBpc2ltb2RlbTIuNS48YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgV0cyLjUgKGlz
aW1vZGVtMi41KSBTdXBwb3J0ZWQgZmVhdHVyZXMgbGlzdDo8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7
ICZndDsgR2VuZXJhbDo8YnI+Jmd0OyAmZ3Q7IE9ubGluZSAvIE9mZmxpbmUgbW9kZSAoUkYgb24v
b2ZmKTxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyBWb2ljZSBjYWxsOjxicj4mZ3Q7ICZndDsg
TU8vTVQgY2FsbDxicj4mZ3Q7ICZndDsgTXVsdGlwYXJ0eSBjYWxsIChtYXggNyBjYWxscyk8YnI+
Jmd0OyAmZ3Q7IFRyYW5zZmVyIGNhbGw8YnI+Jmd0OyAmZ3Q7IFN3YXAgY2FsbHM8YnI+Jmd0OyAm
Z3Q7IEhvbGQgY2FsbHM8YnI+Jmd0OyAmZ3Q7IEhhbmcgdXAgYWxsPGJyPiZndDsgJmd0OyBIYW5n
IHVwIHNwZWNpZmljIGNhbGw8YnI+Jmd0OyAmZ3Q7IERpc2Nvbm5lY3QgcmVhc29uIChOZXR3b3Jr
L2xvY2FsL3JlbW90ZSk8YnI+Jmd0OyAmZ3Q7IFNlbmQgRFRNRiB0b25lczxicj4mZ3Q7ICZndDsg
PGJyPiZndDsgJmd0OyBQUyBkYXRhOjxicj4mZ3Q7ICZndDsgUHJpbWFyeSBQRFAgY29udGV4dCAo
SVB2NCBvbmx5KTxicj4mZ3Q7ICZndDsgQVBOOiBVc2VyIG5hbWUgYW5kIHBhc3N3b3JkIHN1cHBv
cnRlZDxicj4mZ3Q7ICZndDsgQXR0YWNoIG1vZGU6IE1hbnVhbCAoQXV0b21hdGljIHdvcmtzIGFz
IHdlbGwsIGJ1dCBub3QgYWN0aXZhdGVkKTxicj4mZ3Q7ICZndDsgRGF0YSBmbG93IGNvbnRyb2wg
bm90IGFjdGl2YXRlZCAoTm90IHN1cHBvcnRlZCBieSBLZXJuZWwpPGJyPiZndDsgJmd0OyA8YnI+
Jmd0OyAmZ3Q7IFNNUzo8YnI+Jmd0OyAmZ3Q7IFNlbmQgYW5kIHJlY2VpZXZlIFNNUzxicj4mZ3Q7
ICZndDsgQ29uY2F0ZW5hdGVkIG1lc3NhZ2VzIHN1cHBvcnRlZCAodXAgdG8gMjU1IG1lc3NhZ2Vz
KTxicj4mZ3Q7ICZndDsgQ2xhc3MgMDxicj4mZ3Q7ICZndDsgRGVsaXZlcnkgcmVwb3J0czxicj4m
Z3Q7ICZndDsgUmVhZCAvIFdyaXRlIFNNU0MgdG8gU0lNIGNhcmQ8YnI+Jmd0OyAmZ3Q7IEJlYXJl
ciBzZXR0aW5ncyBzdXBwb3J0ZWQgKENTIG9yIFBTKTxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0
OyBTdXBwbGVtZW50YXJ5IFNlcnZpY2VzOjxicj4mZ3Q7ICZndDsgQ2FsbCBCYXJyaW5nPGJyPiZn
dDsgJmd0OyAgICAgIFZvaWNlT3V0Z29pbmc8YnI+Jmd0OyAmZ3Q7ICAgICAgVm9pY2VJbmNvbWlu
Zzxicj4mZ3Q7ICZndDsgQ2FsbCBTZXR0aW5nczxicj4mZ3Q7ICZndDsgICAgICBDYWxsZWRMaW5l
UmVzdHJpY3Rpb248YnI+Jmd0OyAmZ3Q7ICAgICAgSGlkZUNhbGxlcklkPGJyPiZndDsgJmd0OyAg
ICAgIENhbGxpbmdMaW5lUHJlc2VudGF0aW9uPGJyPiZndDsgJmd0OyAgICAgIENhbGxlZExpbmVQ
cmVzZW50YXRpb248YnI+Jmd0OyAmZ3Q7ICAgICAgVm9pY2VDYWxsV2FpdGluZzxicj4mZ3Q7ICZn
dDsgICAgICBDYWxsaW5nTGluZVJlc3RyaWN0aW9uPGJyPiZndDsgJmd0OyBDYWxsIEZvcndhcmRp
bmc8YnI+Jmd0OyAmZ3Q7ICAgICAgVm9pY2UgTm90IFJlYWNoYWJsZTxicj4mZ3Q7ICZndDsgICAg
ICBWb2ljZSBCdXN5PGJyPiZndDsgJmd0OyAgICAgIFZvaWNlIE5vIFJlcGx5PGJyPiZndDsgJmd0
OyAgICAgIFZvaWNlIFVuY29uZGl0aW9uYWw8YnI+Jmd0OyAmZ3Q7IFVTU0Q8YnI+Jmd0OyAmZ3Q7
ICAgICAgTU8gVVNTRDxicj4mZ3Q7ICZndDsgICAgICBNVCBVU1NEIE5PVCBTVVBQT1JURUQ8YnI+
Jmd0OyAmZ3Q7IFNTTjxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyBDUyBOZXR3b3JrOjxicj4m
Z3Q7ICZndDsgTmV0d29yayByZWdpc3RyYXRpb248YnI+Jmd0OyAmZ3Q7IFNjYW5uaW5nIGF2YWls
YWJsZSBuZXR3b3Jrczxicj4mZ3Q7ICZndDsgU2VsZWN0aW5nIGF1dG9tYXRpY2FsbHkgYW5kIG1h
bnVhbGx5IHRoZSB0YXJnZXQgbmV0d29yazxicj4mZ3Q7ICZndDsgQ2hhbmdpbmcgUkFUIGJldHdl
ZW4gR1NNL1VNVFMvQU5ZPGJyPiZndDsgJmd0OyBSZWdpc3RyYXRpb24gc3RhdHVzOiBDZWxsIElE
LCBMQUMsIE1OQywgQ3VycmVudCBUZWNobm9sb2d5IChHU00sIFVNVFMsIDxicj4mZ3Q7ICZndDsg
RURHRSwgSFNEUEEsIEhTVVBBLCBIU0RQQSZhbXA7SFNVUEEpPGJyPiZndDsgJmd0OyBEZXJlZ2lz
dGVyPGJyPiZndDsgJmd0OyBSU1NJICglKTxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyBTSU06
PGJyPiZndDsgJmd0OyBSZWFkIElNU0k8YnI+Jmd0OyAmZ3Q7IE1TSVNETiAoU3Vic2NyaWJlciBu
dW1iZXJzKTxicj4mZ3Q7ICZndDsgU0ROIChTZXJ2aWNlIERpYWxpbmcgTnVtYmVycyk8YnI+Jmd0
OyAmZ3Q7IFBJTi9QSU4yL1BVSy9QVUsyIHN1cHBvcnRlZCAocmVzZXQvY2hhbmdlL2xvY2spPGJy
PiZndDsgJmd0OyBSZWFkIGZpbGUgaW5mbyBmcm9tIFNJTTxicj4mZ3Q7ICZndDsgUmVhZCBGSWxl
IChUcmFuc3BhcmVudCwgTGluZWFyICZhbXA7IEN5Y2xpYykgKiBTb21lIGZ1bmN0aW9uYWxpdGll
cyBmbGFnZ2VkIDxicj4mZ3Q7ICZndDsgb3V0IGFzIG9mb25vIGNvcmUgaXMgbm90IHVzaW5nIHRo
ZXNlPGJyPiZndDsgJmd0OyBXcml0ZSBGaWxlIChUcmFuc3BhcmVudCwgTGluZWFyICZhbXA7IEN5
Y2xpYykgKiBTb21lIGZ1bmN0aW9uYWxpdGllcyBmbGFnZ2VkIDxicj4mZ3Q7ICZndDsgb3V0IGFz
IG9mb25vIGNvcmUgaXMgbm90IHVzaW5nIHRoZXNlPGJyPiZndDsgJmd0OyBNQ0MgJmFtcDsgTU5D
PGJyPiZndDsgJmd0OyBDYXJkSWRlbnRpZmllcjxicj4mZ3Q7ICZndDsgUHJlZmVycmVkTGFuZ3Vh
Z2VzPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IEV4cG9ydCBjb250YWN0cyhTSU0gcGhvbmVi
b29rKTo8YnI+Jmd0OyAmZ3Q7IFNJTSBhbmQgVVNJTSBjYXJkcyBzdXBwb3J0ZWQ8YnI+Jmd0OyAm
Z3Q7IE5hbWU8YnI+Jmd0OyAmZ3Q7IE51bWJlciAoZXh0ZW5zaW9uIHJlY29yZCBzdXBwb3J0ZWQp
PGJyPiZndDsgJmd0OyBBZGRpdGlvbmFsIG51bWJlcjxicj4mZ3Q7ICZndDsgRW1haWw8YnI+Jmd0
OyAmZ3Q7IE5vIGxpbWl0aWF0aW9uIGluIGFtb3VudCBvZiByZWNvcmRzIHJlYWQgZnJvbSBTSU08
YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgQ0JTOjxicj4mZ3Q7ICZndDsgQ0JTIHJlY2VwdGlv
biBpbiBHU008YnI+Jmd0OyAmZ3Q7IFN1YnNjcmliZSBUb3BpY3MgaW4gcmFuZ2Ugb3Igc3BlY2lm
aWMgdmFsdWU8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgUGhvbmUgSW5mbzo8YnI+Jmd0OyAm
Z3Q7IFJldmlzaW9uIG9mIHRoZSBtb2RlbSBTVzxicj4mZ3Q7ICZndDsgSU1FSTxicj4mZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyBUaGlzIHNwZWNpZmljIHBhdGNoIGNvbnRhaW5zIHVwZGF0ZXMgaW4g
TWFrZWZpbGUuYW0sIGNvbmZpZ3VyZS5hYyBhbmQgZ2lzaSB0byBwcmVwYXJlIHRoZSBhZGRpdGlv
biBvZiBpc2ltb2RlbTIuNTxicj4mZ3Q7ICZndDsgQWRkZWQgMiBuZXcgZmlsZXMgdG8gZ2lzaSBw
aXBlX3dnMjUuYyBhbmQgcGlwZV93ZzI1LmgsIGlzaW1vZGVtMi41IHBpcGUgaW1wbGVtZW50YXRp
b24gZHVlIHRvIHBpcGUgaGFuZGxlciBub3Qgb24gbW9kZW0gc2lkZS48YnI+Jmd0OyA8YnI+Jmd0
OyB0aGlzIG5lZWRzIHRvIGJlIHNwbGl0IGludG8gc2VwYXJhdGUgcGF0Y2hlcyBhbmQgdGhlIGNv
bW1pdCBtZXNzYWdlPGJyPiZndDsgbmVlZHMgdG8gYmUgYSBiaXQgY2xlYW5lci48YnI+Jmd0OyA8
YnI+Jmd0OyBBbHNvIGlzIHRoaXMgaW4gc3luYyB3aXRoIHRoZSBHSVNJIHJlLXdyaXRlIEFraSBp
cyBkb2luZz88YnI+Jmd0OyA8YnI+Jmd0OyBSZWdhcmRzPGJyPiZndDsgPGJyPiZndDsgTWFyY2Vs
PGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgPGJyPiZndDsgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJyPiZndDsgTWVzc2FnZTogODxicj4mZ3Q7IERh
dGU6IFdlZCwgOCBEZWMgMjAxMCAxMTozNDo0MCArMDIwMDxicj4mZ3Q7IEZyb206IEFraSBOaWVt
aSAmbHQ7YWtpQHByb3RvY29scG9saWNlLmNvbSZndDs8YnI+Jmd0OyBUbzogb2Zvbm9Ab2Zvbm8u
b3JnPGJyPiZndDsgU3ViamVjdDogUmU6IFtQQVRDSCAwLzVdIENhbGwgQ291bnRlcnMgKDJuZCk8
YnI+Jmd0OyBNZXNzYWdlLUlEOjxicj4mZ3Q7IAkmbHQ7QUFOTGtUaW5ZcnlrMWpkaGRWUlhoMVJY
bjVDdndyRF9BOHkyR1BCY1AwWnNLQG1haWwuZ21haWwuY29tJmd0Ozxicj4mZ3Q7IENvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtODxicj4mZ3Q7IDxicj4mZ3Q7IEhpIE1hcmNl
bCw8YnI+Jmd0OyA8YnI+Jmd0OyAyMDEwLzEyLzggTWFyY2VsIEhvbHRtYW5uICZsdDttYXJjZWxA
aG9sdG1hbm4ub3JnJmd0Ozo8YnI+Jmd0OyAmZ3Q7IHNvIERlbmlzIGFuZCBJIHRhbGtlZCBhYm91
dCB0aGlzIGEgbGl0dGxlIGJpdCBhbmQgSSBhbSBub3QgZmluZSB3aXRoPGJyPiZndDsgJmd0OyB0
aGlzIGF0IGFsbC48YnI+Jmd0OyA8YnI+Jmd0OyBOZXh0IHRpbWUsIGNhbiB5b3UgaW52aXRlIG1l
IHRvIGpvaW4geW91ciBsaXR0bGUgdGFsaz88YnI+Jmd0OyA8YnI+Jmd0OyAmZ3Q7IExldHMgdGFr
ZSB0aGlzIG9uZSBzdGVwIGFuZCBwbGVhc2UgZXhwbGFpbiB0byBtZSB3aGF0IHlvdXIgcmVxdWly
ZW1lbnRzPGJyPiZndDsgJmd0OyBhbmQgb2JqZWN0aXZlcyBhcmUuIEkgYWxzbyB3YW5uYSBzZWUg
YSB0b3AgdG8gYm90dG9tIGZyb20gVUkgZG93biB0byB0aGU8YnI+Jmd0OyAmZ3Q7IG1vZGVtIHVz
YWdlIG9mIHRoaXMgQVBJLjxicj4mZ3Q7IDxicj4mZ3Q7IFdlIG5lZWQgYSBVSSBzaG93aW5nIHRv
dGFsIE1PIGFuZCBNVCBjYWxsIHRpbWVzLiBUaGV5IGFsc28gbmVlZCB0byBiZTxicj4mZ3Q7IGFi
bGUgdG8gYmUgcmVzZXQsIGlmIHRoZSB1c2VyIHNvIHdpc2hlcy4gVGhlIGRhdGEgbmVlZHMgdG8g
YmU8YnI+Jmd0OyByZWFzb25hYmx5IHJlbGlhYmxlLjxicj4mZ3Q7IDxicj4mZ3Q7ICZndDsgYW5k
IGNvbnN1bWluZyBoZWF2eSBJTyB3aXRoIHdyaXRpbmcgdGhpcyBpbmZvcm1hdGlvbiB0byBkaXNr
LiBJbjxicj4mZ3Q7ICZndDsgYWRkaXRpb24gdG8gdGhhdCB0aGVyZSBpcyBubyBjbGVhciBVSSB1
c2FnZSBmb3IgdGhlIGdldHRlciBBUEkuPGJyPiZndDsgPGJyPiZndDsgV2hhdCBkbyB5b3UgbWVh
bj8gRG8geW91IG1lYW4geW91ciBpUGhvbmUgaGFzIG5vIHN1Y2ggVUk/PGJyPiZndDsgPGJyPiZn
dDsgVGhlIHJlYXNvbiB0aGVzZSBhcmUgbm90IHByb3BlcnRpZXMgaXMganVzdCBiZWNhdXNlIGl0
IG1ha2VzIG5vIHNlbnNlPGJyPiZndDsgdG8gdXBkYXRlIHRoZSBjb3VudGVycyAibGl2ZSIuIFRo
ZSBVSSBjYW4gcG9sbCBpZiBpdCBzbyB3aXNoZXMsIGJ1dDxicj4mZ3Q7IHRoZSBwb2xsIGludGVy
dmFsIGlzIG5vdCBzb21ldGhpbmcgd2Ugd2FudCB0byBkZWNpZGUuPGJyPiZndDsgPGJyPiZndDsg
Jmd0OyBXaGF0IGFyZSB0aGUgZ3JhbnVsYXJpdHkgdGhlcmUuIFdoYXQgaXMgdGhlIGV4cGVjdGVk
IHVzZXIgZXhwZXJpZW5jZTxicj4mZ3Q7ICZndDsgd2l0aCB0aGlzIEFQSS4gSSBkb24ndCBzZWUg
YW55IGNsZWFyIHVzYWdlIG1vZGVsIGhlcmUuPGJyPiZndDsgJmd0Ozxicj4mZ3Q7ICZndDsgSW4g
YWRkaXRpb24gdG8gdGhhdCwgd2hhdCBpcyB0aGUgcHJvYmxlbSB3aXRoIGp1c3QgdXBkYXRpbmcg
dGhlIHN0YXRzPGJyPiZndDsgJmd0OyBhZnRlciB0aGUgY2FsbCBoYXMgZW5kZWQ/PGJyPiZndDsg
PGJyPiZndDsgQmVjYXVzZSBpZiB5b3VyIGJhdHRlcnkgcnVucyBvdXQgaW4gdGhlIG1pZGRsZSBv
ZiBhIDQgaG91ciBjb25mZXJlbmNlPGJyPiZndDsgY2FsbCwgeW91ciB0aW1lcnMgYXJlIG5vdCB1
cGRhdGVkIGFuZCBiZWNvbWUgd29ydGhsZXNzLiBPYnZpb3VzbHksPGJyPiZndDsgdGhpcyBpcyBh
IGNvbXByb21pc2UgYmV0d2VlbiBob3cgcmVsaWFibGUgdGhlIGNvdW50ZXJzIGFyZSBhbmQgaG93
PGJyPiZndDsgbWFueSB3YWtldXBzIGFuZCBJTyB3ZSBjYW4gYmVhci48YnI+Jmd0OyA8YnI+Jmd0
OyBBbmRyYXMgaGFzIHNvbWUgZGF0YSBvbiB3aGF0IHJlYXNvbmFibGUgcmVsaWFiaWxpdHkgaGVy
ZSBtZWFucy48YnI+Jmd0OyA8YnI+Jmd0OyBDaGVlcnMsPGJyPiZndDsgQWtpPGJyPiZndDsgPGJy
PiZndDsgPGJyPiZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPiZndDsgPGJy
PiZndDsgTWVzc2FnZTogOTxicj4mZ3Q7IERhdGU6IFdlZCwgMDggRGVjIDIwMTAgMDQ6NTU6MjEg
LTA2MDA8YnI+Jmd0OyBGcm9tOiBEZW5pcyBLZW56aW9yICZsdDtkZW5rZW56QGdtYWlsLmNvbSZn
dDs8YnI+Jmd0OyBUbzogb2Zvbm9Ab2Zvbm8ub3JnPGJyPiZndDsgU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggMi80XSBtb2RlbTogYWRkIEVtZXJnZW5jeU1vZGUgcHJvcGVydHk8YnI+Jmd0OyBNZXNz
YWdlLUlEOiAmbHQ7NENGRjY0MTkuMzA5MDQwMkBnbWFpbC5jb20mZ3Q7PGJyPiZndDsgQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PUlTTy04ODU5LTE8YnI+Jmd0OyA8YnI+Jmd0OyBI
aSBQZWtrYSw8YnI+Jmd0OyA8YnI+Jmd0OyAmZ3Q7Jmd0OyBTbyBteSBvbmx5IG1ham9yIGNvbmNl
cm4gbGVmdCBpcyBoZXJlIGFjdHVhbGx5LiAgSWYgd2UgYWN0aXZhdGUgYW48YnI+Jmd0OyAmZ3Q7
Jmd0OyBlbWVyZ2VuY3kgY2FsbCBhbmQgYSBzZXRfcHJvcGVydHkoT25saW5lLCBibGFoKSBpcyBh
Y3RpdmUsIHdlIGdldCBpbnRvPGJyPiZndDsgJmd0OyZndDsgc29tZSBmdW5ueSByYWNlIGNvbmRp
dGlvbnMuICBJIG1lbnRpb25lZCB0aGVzZSB0byBQZWtrYSBvbiBJUkMuICBCdXQ8YnI+Jmd0OyAm
Z3Q7Jmd0OyBiYXNpY2FsbHkgdGhlIHdvcnN0IG9uZSBpcyBpZiB3ZSBoYXZlIGFuIE9ubGluZT1G
YWxzZSBvcGVyYXRpb24gcGVuZGluZy48YnI+Jmd0OyAmZ3Q7Jmd0OyAgSW4gdGhpcyBjYXNlIHlv
dXIgY2FsbCBwcm9jZWVkcywgYnV0IHRoZW4gZ2V0cyB0ZXJtaW5hdGVkIHNob3J0bHk8YnI+Jmd0
OyAmZ3Q7Jmd0OyB0aGVyZWFmdGVyIGJ5IHRoZSBvZmZsaW5lIHByb2NlZHVyZSA7KTxicj4mZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyBUaGF0IGlzIGEgdHJpY2t5IHByb2JsZW0uIEknZCBzYXkgdGhl
IG1vc3Qgc3RyYWlnaHRmb3J3YXJkIHdheSBpcyB0bzxicj4mZ3Q7ICZndDsgcmV0dXJuIGFuIGVy
cm9yIGlmIHRoZXJlIGlzIGEgcGVuZGluZyBvcGVyYXRpb24gYW5kIHB1c2ggdGhlc2U8YnI+Jmd0
OyAmZ3Q7IHByb2JsZW1zIHVwIHRoZSBzdGFjay4gSW4gYW55IGNhc2UgZGlhbGVyIGhhcyB0byBy
ZXRyeSBlY2FsbCBpZiB1c2VyPGJyPiZndDsgJmd0OyB0cmllcyB0byBtYWtlIHRoZSBlbWVyZ2Vu
Y3kgY2FsbCBqdXN0IGFmdGVyIG9yIGJlZm9yZSBtb3ZpbmcgZGV2aWNlIHRvPGJyPiZndDsgJmd0
OyBvZmZsaW5lIC8gcmVtb3ZpbmcgU0lNIGNhcmQgLyBldGMuIEhvd2V2ZXIsIEknbSBub3Qgc3Vy
ZSBpZiB3ZSBjYW48YnI+Jmd0OyAmZ3Q7IHByb3BhZ2F0ZSB0aGUgZXJyb3IgaW4gYWxsIGNhc2Vz
IHdoZXJlIG9mb25vX21vZGVtX2luY19lbWVyZ2VuY3koKTxicj4mZ3Q7ICZndDsgZ2V0cyBjYWxs
ZWQuPGJyPiZndDsgPGJyPiZndDsgVGhlcmUncyByZWFsbHkgbm8gd2F5IGZvciB0aGUgdm9pY2Vj
YWxsIGF0b20gdG8ga25vdyB0aGF0IGEgbW9kZW0gaXM8YnI+Jmd0OyB1bmRlcmdvaW5nIGFuIG9u
bGluZSAvIG9mZmxpbmUgdHJhbnNpdGlvbi4uPGJyPiZndDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7IEluIG9yZGVyIHRvIG1hbmFnZSB0aGUgd29yc3QgY2FzZSBpbiBiZXN0IHBvc3NpYmxl
IG1hbm5lciwgSSdkIGNoZWNrPGJyPiZndDsgJmd0OyBmb3Igc2V0X29ubGluZSBpbiBwcm9ncmVz
cyBoZXJlLiBSZXR1cm4gRkFMU0UgZnJvbTxicj4mZ3Q7ICZndDsgb2Zvbm9fbW9kZW1fZ2V0X29u
bGluZSgpIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBzZXRfb25saW5lKEZBTFNFKSBjYWxsPGJyPiZn
dDsgJmd0OyBpcyBtYWRlLiBBbHNvLCBjaGVjayB0aGUgZW1lcmdlbmN5IHN0YXRlIGFnYWluIGlu
IGFmdGVyIHNldF9vbmxpbmU8YnI+Jmd0OyAmZ3Q7IGNhbGxiYWNrIHJlc3BvbnNlLiBUaGUgb25s
aW5lL29mZmxpbmUgd2F0Y2hlcyBzaG91bGQgYmUgY2FsbGVkIGJlZm9yZTxicj4mZ3Q7ICZndDsg
dGhlIHNldF9vbmxpbmUoKSBjYWxsLiAoSSBoYXZlIG5vIGlkZWEgd2hhdCB3ZSB3aWxsIGRvIHNo
b3VsZDxicj4mZ3Q7ICZndDsgc2V0X29ubGluZShGQUxTRSkgZmFpbCk/PGJyPiZndDsgJmd0OyA8
YnI+Jmd0OyA8YnI+Jmd0OyBTbyBteSB0aGlua2luZyB3YXMgZXNzZW50aWFsbHkgYWxvbmcgdGhl
IHNhbWUgbGluZXMuICBXZSBjYW4gY2hlY2s8YnI+Jmd0OyB3aGV0aGVyIGFuIE9ubGluZSBjaGFu
Z2Ugb3BlcmF0aW9uIGlzIGluIHByb2dyZXNzIGJ5IHBlZWtpbmcgYXQgdGhlPGJyPiZndDsgcGVu
ZGluZyBELUJ1cyBtZXNzYWdlLiAgSWYgd2UncmUgZ29pbmcgb25saW5lLCB0aGVuIG5vdCB0cmln
Z2VyaW5nPGJyPiZndDsgYW5vdGhlciBzZXRfb25saW5lIGNhbGwgYW5kIHdhaXRpbmcgZm9yIHRo
ZSBvbmxpbmVfY2Igc2hvdWxkIGJlIHN1ZmZpY2llbnQuPGJyPiZndDsgPGJyPiZndDsgSWYgd2Un
cmUgZ29pbmcgb2ZmbGluZSwgdGhlbiByZXR1cm5pbmcgRkFMU0UgZnJvbSBvZm9ub19tb2RlbV9n
ZXRfb25saW5lPGJyPiZndDsgYW5kIHJlLWNoZWNraW5nIHRoZSBlbWVyZ2VuY3kgY291bnRlciBp
biB0aGUgb2ZmbGluZV9jYiBzZWVtcyBsaWtlIHRoZTxicj4mZ3Q7IHdheSB0byBnby48YnI+Jmd0
OyA8YnI+Jmd0OyBJJ2QgbGlrZSB0byB0YWtlIGNhcmUgb2YgdGhpcyBjb21wbGV0ZWx5IGluc2lk
ZSBvRm9ubyBhbmQgbm90IGJvdGhlciB0aGU8YnI+Jmd0OyBkaWFsZXIgd2l0aCB0aGVzZSBkZXRh
aWxzLiAgVGhvdWdodHM/PGJyPiZndDsgPGJyPiZndDsgUmVnYXJkcyw8YnI+Jmd0OyAtRGVuaXM8
YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS08YnI+Jmd0OyA8YnI+Jmd0OyBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXzxicj4mZ3Q7IG9mb25vIG1haWxpbmcgbGlzdDxicj4mZ3Q7IG9mb25v
QG9mb25vLm9yZzxicj4mZ3Q7IGh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88
YnI+Jmd0OyA8YnI+Jmd0OyA8YnI+Jmd0OyBFbmQgb2Ygb2Zvbm8gRGlnZXN0LCBWb2wgMjAsIElz
c3VlIDI4PGJyPiZndDsgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjxicj48
L2Rpdj4gCQkgCSAgIAkJICA8L2JvZHk+CjwvaHRtbD4=
--===============6934529195763162263==--

