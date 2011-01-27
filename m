Content-Type: multipart/mixed; boundary="===============9065027044738919744=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] bluetooth: only use bluetooth_refcount in
 bluetooth_ref/bluetooth_unref
Date: Thu, 27 Jan 2011 17:18:42 +0100
Message-ID: <1296145122.1520.161.camel@aeonflux>
In-Reply-To: <20110127161714.GB2163@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9065027044738919744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > >>   plugins/bluetooth.c |   14 +++++++++-----
> > >>   1 files changed, 9 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> > >> index 93dd7a1..e59bd31 100644
> > >> --- a/plugins/bluetooth.c
> > >> +++ b/plugins/bluetooth.c
> > >> @@ -505,7 +505,7 @@ static guint adapter_added_watch;
> > >>   static guint adapter_removed_watch;
> > >>   static guint property_watch;
> > >>
> > >> -static void bluetooth_ref(void)
> > >> +static int bluetooth_ref(void)
> > >>   {
> > >
> > > why are we now reverting something back that we already applied
> > > upstream. Something is wrong here.
> > =

> > I followed Padovan's comment on my first try for this patch :
> > "bluetooth_refcount can only be read/write by bluetooth_ref/unref"
> > which seems good to me
> =

> Yeah, but I'm now wondering why we merged a code access bluetooth_refcount
> directly.

that part is just fine. Don't worry about that.

Regards

Marcel




--===============9065027044738919744==--

