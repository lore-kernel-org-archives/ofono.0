Content-Type: multipart/mixed; boundary="===============0801089931128260106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Controlling GPRS connections through Ofono in the presence of
 Connman
Date: Tue, 15 Jul 2014 08:27:43 -0500
Message-ID: <53C52C4F.4010708@gmail.com>
In-Reply-To: <CAEM=xjhG8cOzfYJMPPegFD+15kVXtH1uUxzApXocqFCsNrdKvQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0801089931128260106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederik,

On 07/15/2014 02:03 AM, Frederik Lotter wrote:
> Hi,
> =

> I am working on uBlox support in Ofono. My aim is further than the
> traditional desktop type use case, so I am extending Ofono with a custom
> APN provisioning service.
> =

> I want to get some tips on how I should proceed because I do not wish to
> go into an unintentional direction.
> =

> We have 3rd party software that needs to finely control the GPRS
> session, constantly monitoring and switching APN's as the network changes=
. =

> =

> I need a way for our software to know when the context has successfully
> been activated, for example a post_context_activate() in the driver

The driver is already performing the "callback" into the core.  So what
you're looking for is probably something.  Perhaps something similar to
__ofono_netreg_add_status_watch.  Before you go there though...

> would be great, so that I could add a DBUS message in our custom driver
> which send states to our software in order to know when a socket could
> be opened (not only the post_context_activate() but I also need the
> other states the driver will enter). =


Since you are sending a D-Bus message anyway, is it not possible for the
3rd party software to monitor the oFono context state directly?  E.g.
the org.ofono.ConnectionContext.Active Property seems to do exactly what
you need.  What other states do you require?

> =

> Is there a better approach than adding a callback for successful context
> activation in the driver, in Ofono? I feel like Connman is too distant
> and unaware of detailed Ofono states to manage this on the Connman side. =

> =

> Secondly, I have tested changing states on the Ofono side with the
> Python scripts (enable -> online ) and visa versa and connman seems OK
> with me doing this. I plan to do this from my 3rd party application to
> manage APNs and sockets. Is this an acceptable use case with Connman, it
> seems like it has been designed so that Connman always gets updates on
> Ofono state changes.

All clients of oFono are notified of state changes regardless of which
client initiated a particular state change.  So ConnMan should be just
fine with you manipulating the context states from other clients.  You
might interfere with some auto-connect / reconnect behavior there, but
sounds like you don't want that behavior active anyway.

Regards,
-Denis

--===============0801089931128260106==--

