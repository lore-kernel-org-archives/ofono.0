Content-Type: multipart/mixed; boundary="===============8296396025931816754=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 2/3] Add dun_enable() function
Date: Tue, 03 Aug 2010 19:58:29 -0300
Message-ID: <20100803225829.GA28060@vigoh>
In-Reply-To: <33AB447FBD802F4E932063B962385B3528D48149@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8296396025931816754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

* Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-08-02 22:28:47 +0800]:

> Hi Padovan,
> =

> Gustavo F. Padovan wrote:
> > dun_enable() is called by setting the Powered property to true.
> > It creates a rfcomm link throught the BlueZ Serial API.
> > ---
> >  drivers/dunmodem/dunmodem.h |    1 +
> >  plugins/bluetooth.h         |    1 +
> >  plugins/dun.c               |   61
> >  +++++++++++++++++++++++++++++++++++++++++- 3 files changed, 61
> > insertions(+), 2 deletions(-) =

> > =

> > diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
> > index 6bbf7b9..16eb9e7 100644
> > --- a/drivers/dunmodem/dunmodem.h
> > +++ b/drivers/dunmodem/dunmodem.h
> > @@ -23,6 +23,7 @@
> > =

> >  struct dun_data {
> >  	char *dun_path;
> > +	const char *rfcomm;
> >  };
> > =

> >  #endif
> > diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
> > index 09e6efa..c20b36d 100644
> > --- a/plugins/bluetooth.h
> > +++ b/plugins/bluetooth.h
> > @@ -22,6 +22,7 @@
> >  #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
> >  #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
> >  #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> > +#define	BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
> > =

> >  #define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
> >  #define DUN_GW_UUID	"00001103-0000-1000-8000-00805F9B34FB"
> > diff --git a/plugins/dun.c b/plugins/dun.c
> > index 9b4288e..7dc8422 100644
> > --- a/plugins/dun.c
> > +++ b/plugins/dun.c
> > @@ -25,6 +25,7 @@
> >  #include <stdio.h>
> >  #include <string.h>
> >  #include <errno.h>
> > +#include <gdbus.h>
> >  #include <glib.h>
> >  #include <ofono.h>
> > =

> > @@ -138,10 +139,66 @@ static void dun_remove(struct ofono_modem
> >  	*modem) ofono_modem_set_data(modem, NULL);
> >  }
> > =

> > +static void dun_connect_reply(DBusPendingCall *call, gpointer
> > user_data) +{
> > +	struct ofono_modem *modem =3D user_data;
> > +	struct dun_data *data =3D ofono_modem_get_data(modem);
> > +	const char *dev;
> > +	DBusError derr;
> > +	DBusMessage *reply, *msg;
> > +
> > +	reply =3D dbus_pending_call_steal_reply(call);
> > +
> > +	if (ofono_modem_get_powered(modem))
> > +		goto done;
> > +
> > +	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &dev,
> > +				DBUS_TYPE_INVALID))
> > +		goto done;
> > +
> > +	data->rfcomm =3D dev;
> =

> One more comment here, I'd suggest to use g_strdup(dev). Because the devi=
ce
> String is from dbus reply and later we will unref the reply. What do you =
think?
> =


Thanks for all the comments, I fix the patches and resend them. ;)

-- =

Gustavo F. Padovan
http://padovan.org

--===============8296396025931816754==--

