Content-Type: multipart/mixed; boundary="===============8705689899189181290=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Re-activating a context.
Date: Thu, 12 Jul 2012 15:49:28 -0500
Message-ID: <4FFF3858.8000605@gmail.com>
In-Reply-To: <4FFEE449.7080902@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8705689899189181290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 07/12/2012 09:50 AM, Christopher Vogl wrote:
> Hello,
>
> I am trying to simulate a connection loss and after a valid ppp
> connection I disconnect the antenna to get detached from GPRS.
> After reconnecting the antenna everything seems to work fine just until
> activating the context.
>
> Ofono seems to get stuck in
> drivers/atmodem/gprs-context.c:at_gprs_activate_primary() and
> AT+CGDCONT=3D1 is missing on the debug output.
> When I retry to activate the context after some minutes with a dbus-send
> call, I receive an operation in progress error.
>
> Below I have attached ofono's debug output and dbus-send calls for
> important interfaces
> - before removing the antenna
> - after removing the antenna
> - after reconnecting the antenna
>
> Modem in use: Telit UC864-G
>
> connMan in the debug output is my own simple connection manger. I am not
> sure if I missed to set some ofono state or if there is a known issue.
> I really would appreciate a hint in this case.
>

To me it looks like your PPP connection has not been dropped when the =

antenna has been removed.  Today oFono assumes that the PPP connection =

will be dropped by the modem in this case, and your modem does not do =

this.  This leads to problems because the AT channel on which the PPP =

connection is being run can not accept additional commands.  This is why =

you're not seeing the CGDCONT.

A while ago Guillaume posted a patch to fix this problem (we saw this =

with Huawei PPP based devices).  The patch looked good to me but needed =

further testing (e.g. for regressions).  Can you dig the mailing =

archives and test that patch?

Or maybe Guillaume will be nice enough to repost it to the mailing list.

Regards,
-Denis

--===============8705689899189181290==--

