Content-Type: multipart/mixed; boundary="===============0221802839862794699=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 1/1] handle werid mbm card network name
Date: Wed, 04 Nov 2009 16:12:15 +0800
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D887A3B0D@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1257314078.3420.128.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0221802839862794699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Marcel Holtmann
> Sent: Wednesday, November 04, 2009 1:55 PM
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 1/1] handle werid mbm card network name
> =

> Hi Martin,
> =

> >  plugins/udev.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/plugins/udev.c b/plugins/udev.c
> > index c2e9c41..345613b 100644
> > --- a/plugins/udev.c
> > +++ b/plugins/udev.c
> > @@ -120,7 +120,8 @@ static void add_mbm(struct ofono_modem *modem,
> >  		devnode =3D udev_device_get_devnode(udev_device);
> >  		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
> >  	} else if (g_str_has_suffix(desc, "Minicard Network Adapter") ||
> > -			g_str_has_suffix(desc, "Broadband Network Adapter")) {
> > +			g_str_has_suffix(desc, "Broadband Network Adapter") ||
> > +				g_str_has_suffix(desc, "Minicard NetworkAdapter")) {
> >  		devnode =3D udev_device_get_property_value(udev_device,
> >  								"INTERFACE");
> >  		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
> =

> are you serious? They forgot the space in one of their USB interface
> descriptions.
Of course, I am serious.
It waste me almost half of morning to debug the weird issue. =

> Do me a favor and just add it between these two and don't bother with
> the extra indentation. Two are enough.
I cannot understand what your meaning exactly. Anyway I will send the modif=
ied patch, if it is not what you want, just replace it. ;-)
> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============0221802839862794699==--

