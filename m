Content-Type: multipart/mixed; boundary="===============8255920278785362424=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 06/12] gatchat: Add possibility to associate a
 diagnostic monitor to the AT-capable port
Date: Thu, 08 Dec 2011 17:17:03 +0200
Message-ID: <1323357423.1965.46.camel@aeonflux>
In-Reply-To: <4EE0E0D8.3000609@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8255920278785362424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> >>   gatchat/gatchat.c |   26 ++++++++++++++++++++++++++
> >>   gatchat/gatchat.h |    4 ++++
> >>   2 files changed, 30 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> >> index 7a0ef35..00e5fa8 100644
> >> --- a/gatchat/gatchat.c
> >> +++ b/gatchat/gatchat.c
> >> @@ -35,6 +35,7 @@
> >>   #include "ringbuffer.h"
> >>   #include "gatchat.h"
> >>   #include "gatio.h"
> >> +#include "gathdlc.h"
> >>
> >>   /* #define WRITE_SCHEDULER_DEBUG 1 */
> >>
> >> @@ -110,6 +111,7 @@ struct _GAtChat {
> >>   	struct at_chat *parent;
> >>   	guint group;
> >>   	GAtChat *slave;
> >> +	GAtHDLC	*diag_monitor;
> >>   };
> >
> > what is this for? I don't see this needed at all. You are not crossing
> > atom driver implementations anyway.
> =

> Here, the idea is to link one AT capable port to one Diagnostic port.
> Commonly, we are specifying only one AT capable channel (GAtChat) when =

> creating an atom.
> For cdma_netreg, I need both (AT and QCDM). Indeed, with some EV-DO =

> capable hardware, the result of some AT commands (like AT+CSS?) may be =

> wrong. That's why, I introduced the QCDM support. To retrieve the =

> GAtHDLC from the driver implementation, I chose to use a solution =

> similar to 'g_at_chat_get_slave'.

why both? Isn't QCDM only enough?

Regards

Marcel



--===============8255920278785362424==--

