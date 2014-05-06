Content-Type: multipart/mixed; boundary="===============4249093026903207573=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] he910: set modem unpowered after IO disconnect
Date: Tue, 06 May 2014 08:38:36 -0500
Message-ID: <5368E5DC.1040409@gmail.com>
In-Reply-To: <1399040139-30253-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4249093026903207573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 05/02/2014 09:15 AM, Jonas Bonn wrote:
> This patch address an issue with SIM hotplug.  If the SIM card is removed
> while there is an active connection then the io_disconnect function
> of gatchat.c pulls the rug out from under us by cleaning up the modem
> chat that we hold a reference to.

So what actually happens when the SIM is pulled?  This seems to imply
that the modem port at least sends a HUP and is no longer usable.  Is
the control port also HUPed?

> =

> This patch addresses this by hooking into the notification from
> io_disconnect and setting the modem to 'unpowered' state in order to force
> a reinitialization when the SIM is reinserted.
> =

> The modem is not actually powered off as that would turn off SIM detection
> as well.

Are you able to at least turn off radio circuits, e.g. via CFUN=3D4?

> =

> With this patch, SIM hotplug works reliably.

When the modem is turned off, the application really has no idea why it
was turned off (whether due to an administrative action or due to SIM
being removed).   So the proposed patch is not a good implementation of
'SIM hotplug'.  One should implement this via
ofono_sim_inserted_notify().  Any reason why this can't be done?

Regards,
-Denis

--===============4249093026903207573==--

