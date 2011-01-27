Content-Type: multipart/mixed; boundary="===============6131738082659967306=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] bluetooth: use GSList instead of GHashTable to store
 adapter path/address
Date: Thu, 27 Jan 2011 16:24:34 +0100
Message-ID: <1296141874.1520.160.camel@aeonflux>
In-Reply-To: <4D418D9D.9080002@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6131738082659967306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> >>   plugins/bluetooth.c |   86 +++++++++++++++++++++++++++++++++++++++++=
++-------
> >>   1 files changed, 74 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> >> index e59bd31..4da662a 100644
> >> --- a/plugins/bluetooth.c
> >> +++ b/plugins/bluetooth.c
> >> @@ -39,9 +39,14 @@
> >>
> >>   static DBusConnection *connection;
> >>   static GHashTable *uuid_hash =3D NULL;
> >> -static GHashTable *adapter_address_hash =3D NULL;
> >> +static GSList *adapter_list =3D NULL;
> >>   static gint bluetooth_refcount;
> >>
> >> +struct adapter_address {
> >> +	char *adapter;
> >> +	char *address;
> >> +};
> >> +
> >
> > why are we doing this exactly with a list now instead of a hash table. I
> > don't see the point here.
> >
> =

> In patch 4, I need to find the adapter path (for the incoming =

> connection) from its address to call the authorization method.
> =

> So, this is why I change to GSList.

you can as easily walk a GHashTable than you can walk a GSList. So why
not do that instead of moving everything to a list.

Regards

Marcel



--===============6131738082659967306==--

