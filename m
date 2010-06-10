Content-Type: multipart/mixed; boundary="===============3129352595424057664=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Connman operator name empty with Huawei E1552
Date: Thu, 10 Jun 2010 07:27:16 -0700
Message-ID: <1276180036.2182.79.camel@localhost.localdomain>
In-Reply-To: <8739wvzaxz.fsf_-_@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3129352595424057664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> >>> But now connman doesn't show the operator name "Saunalahti" anymore, =
the
> >>> name property in connman Service is just empty:
> >>> =

> >>> ./cmcc show cellular_244053111242822_huawei0_primarycontext1
> >>> AutoConnect: true
> >>> Name: =

> >>> Nameservers: { 193.229.0.40 193.229.0.42 }
> >>> Proxy: { Method=3Ddirect }
> >>
> >> this might be a bug in the oFono plugin in ConnMan. I have encountered
> >> this as well. I think ConnMan forgets to listen to name changes and to
> >> update the name. Some times you get the name other times you don't.
> >
> > Thanks, that's good to know. I have been testing connman and ofono for
> > some time now, but I saw this problem first time only yesterday. But I
> > might have been just lucky earlier.
> =

> I did more testing now. I see this a lot now, at least 90% of the time
> operator name in connman is empty. Seems to be a race condition of some
> sort:
> =

> (I added extra debug messages)
> =

> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name()=
 path /huawei0
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() network 0x87d2b0
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() key Status
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() key Mode
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() key LocationAreaCode
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() key CellId
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() key Name
> Jun 10 08:43:44 tukki connmand[23976]: src/network.c:connman_network_set_=
name() network 0x87d2b0 name =

> Jun 10 08:43:44 tukki connmand[23976]: src/element.c:set_static_property(=
) element 0x87d2b0 name huawei0_primarycontext1
> Jun 10 08:43:44 tukki connmand[23976]: src/element.c:set_static_property(=
) name Name type 115 value 0x7fffc931f1e8
> Jun 10 08:43:44 tukki connmand[23976]: plugins/ofono.c:set_network_name_r=
eply() name ''
> =

> The last debug line is printed here:
> =

> 		if (g_str_equal(key, "Operator") =3D=3D TRUE ||
> 				g_str_equal(key, "Name") =3D=3D TRUE) {
> 			const char *name;
> =

> 			dbus_message_iter_get_basic(&value, &name);
> 			connman_network_set_name(network, name);
> 			DBG("name '%s'", name);
> 			create_service(network);
> 		}
> =

> And then a bit later in the log:
> =

> =

> Jun 10 08:43:44 tukki ofonod[23999]: Pcui:< \r\n+CRSM: 144,0,""\r\n\r\nOK=
\r\n
> Jun 10 08:43:44 tukki ofonod[23999]: drivers/atmodem/sim.c:at_crsm_info_c=
b() crsm_info_cb: 90, 00, 0
> Jun 10 08:43:44 tukki ofonod[23999]: Pcui:> AT+COPS=3D3,0\r
> Jun 10 08:43:44 tukki ofonod[23999]: Pcui:< \r\nOK\r\n
> Jun 10 08:43:44 tukki ofonod[23999]: Pcui:> AT+COPS?\r
> Jun 10 08:43:44 tukki ofonod[23999]: Pcui:< \r\n+COPS: 0,0,"Saunalahti",2=
\r\n\r\nOK\r\n
> Jun 10 08:43:44 tukki ofonod[23999]: drivers/atmodem/network-registration=
.c:cops_cb() cops_cb: Saunalahti, 244 05 2
> Jun 10 08:43:44 tukki ofonod[23999]: src/network.c:current_operator_callb=
ack() 0xaa5a50, (nil)
> Jun 10 08:43:44 tukki ofonod[23999]: src/gprs.c:netreg_status_changed() 1
> Jun 10 08:43:44 tukki ofonod[23999]: src/cbs.c:cbs_location_changed() 1, =
1450, 21880, -1, 24405
> Jun 10 08:43:44 tukki ofonod[23999]: src/cbs.c:cbs_location_changed() 1, =
0, 0
> =

> Then I run test/list-modems after initialisation, I did see the operator
> name correctly:
> =

>     [ org.ofono.NetworkRegistration ]
>         Status =3D registered
>         Strength =3D 67
>         Name =3D Saunalahti
> =

> So connman uses the Name property from org.ofono.NetworkRegistration
> even before ofono has set it and doesn't follow name changes.
> =

> Also CCed the connman list because I don't yet know which one is buggy,
> connman or ofono. I vote for connman's ofono plugin. Thoughts?

it is the ConnMan plugin. It needs to follow name changes. Especially
since the name can change at any time anyway. Most common case would
actually be roaming, but also operator names can be updates over the air
at any time (even if that happens rarely).

Regards

Marcel



--===============3129352595424057664==--

