Content-Type: multipart/mixed; boundary="===============1189812482160078462=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/2] cbs: send topics one by one for ZTE modem.
Date: Mon, 01 Aug 2011 14:04:14 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893900616B@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312193580.8920.149.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1189812482160078462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > > +
> > > > +	if (send_by_one) {
> > > > +		gchar **topic_list =3D NULL;
> > > > +		gchar **topic_list_orig =3D NULL;
> > > > +
> > > > +		topic_list =3D topic_list_orig =3D g_strsplit_set(topics, ",",
> -1);
> > > > +
> > > > +		for (; *topic_list; topic_list++) {
> > > > +			struct cb_data *cbd =3D cb_data_new(cb, user_data);
> > > > +
> > > > +			buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"",
> *topic_list);
> > > >
> > > > -	id =3D g_at_chat_send(data->chat, buf, none_prefix,
> > > > +			id =3D g_at_chat_send(data->chat, buf, none_prefix,
> > > >  				at_cscb_set_cb, cbd, g_free);
> > >
> > > So this is not going to work out as nicely as you might think it woul=
d.
> > > You keep calling ofono_cbs_set_cb_t callback now for every single top=
ic
> > > you send. And also as a result, the D-Bus call returns successful aft=
er
> > > the first one.
> >
> > OK, I see.
> >
> > > You need to properly queue this and properly fail and roll back in ca=
se
> > > of a failure.
> >
> > Roll back? You means that if there is a failure in the middle of sendin=
g,
> you want to send AT command to remove the first topics?
> =

> at minimum clear all topics again.

Ok, I will do this.

> > > I addition to that, I would prefer to send as many topics at once as
> > > possible. So how many can ZTE set at once?
> >
> > I can do some test, but I think that it's not related to topics, but to=
 AT
> command length. And we cannot guaranty to find another model more restric=
tive.
> Sending one by one seems to be the 'safest' solution.
> =

> Please check this. And AT command length limitation would be funny. Not
> unlikely, but funny.
> =

> And while at it, please check if it is actually capable of handling any
> kind of topic ranges properly. You currently only split the topics, but
> have no special handling for ranges. So if the modem does not handle
> topic ranges, then you have a problem here.

Topic range is OK. You can have a look at the log.

ofonod[2040]: Aux: > AT+CSCB=3D0,"4352-4356"\r
ofonod[2040]: Aux: < \r\nOK\r\n

> For example if it can only set 10 topics at once, and you give 1-11. Is
> this 11 topics and the modem can handle it. Or it can handle only 10
> topics and would fail.
> =

> Another thing that came to mind, please check that it actually adds the
> topics and not just overwrites it. Some manufactures don't read the AT
> command specification carefully.

Seems to be fine.

So as you can see in the log, I have found the 'limit'.

at+cscb=3D0, "4352-4356,11000,10000,9000,8000,7000,6000,5000,1,2"

OK

at+cscb=3D0, "4352-4356,11000,10000,9000,8000,7000,6000,5000,1,21"

ERROR

50 characters inside the string is OK, but 51 not.

So do you prefer to use such limit, instead of sending one by one?

Regards,

Bertrand


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1189812482160078462==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="CBS.txt"

b2Zvbm9kWzIwNDBdOiBBdXg6ID4gQVQrQ1NDQj0xXHIKb2Zvbm9kWzIwNDBdOiBBdXg6IDwgXHJc
bk9LXHJcbgpvZm9ub2RbMjA0MF06IEF1eDogPiBBVCtDU0NCPTAsIjAiXHIKb2Zvbm9kWzIwNDBd
OiBBdXg6IDwgXHJcbk9LXHJcbgpvZm9ub2RbMjA0MF06IEF1eDogPiBBVCtDU0NCPTAsIjExIlxy
Cm9mb25vZFsyMDQwXTogQXV4OiA8IFxyXG5PS1xyXG4Kb2Zvbm9kWzIwNDBdOiBBdXg6ID4gQVQr
Q1NDQj0wLCIzMCJccgpvZm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQw
XTogQXV4OiA+IEFUK0NTQ0I9MCwiNTAiXHIKb2Zvbm9kWzIwNDBdOiBBdXg6IDwgXHJcbk9LXHJc
bgpvZm9ub2RbMjA0MF06IEF1eDogPiBBVCtDU0NCPTAsIjUzIlxyCm9mb25vZFsyMDQwXTogQXV4
OiA8IFxyXG5PS1xyXG4Kb2Zvbm9kWzIwNDBdOiBBdXg6ID4gQVQrQ1NDQj0wLCI5NyJccgpvZm9u
b2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9
MCwiMTAxIlxyCm9mb25vZFsyMDQwXTogQXV4OiA8IFxyXG5PS1xyXG4Kb2Zvbm9kWzIwNDBdOiBB
dXg6ID4gQVQrQ1NDQj0wLCIxMzAiXHIKb2Zvbm9kWzIwNDBdOiBBdXg6IDwgXHJcbk9LXHJcbgpv
Zm9ub2RbMjA0MF06IEF1eDogPiBBVCtDU0NCPTAsIjIzNyJccgpvZm9ub2RbMjA0MF06IEF1eDog
PCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9MCwiMjAwMCJccgpvZm9u
b2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9
MCwiMzAwMCJccgpvZm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTog
QXV4OiA+IEFUK0NTQ0I9MCwiNDAwMCJccgpvZm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxu
Cm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9MCwiNTAwMCJccgpvZm9ub2RbMjA0MF06IEF1
eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9MCwiNjAwMCJccgpv
Zm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NT
Q0I9MCwiNzAwMCJccgpvZm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQw
XTogQXV4OiA+IEFUK0NTQ0I9MCwiODAwMCJccgpvZm9ub2RbMjA0MF06IEF1eDogPCBcclxuT0tc
clxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9MCwiOTAwMCJccgpvZm9ub2RbMjA0MF06
IEF1eDogPCBcclxuT0tcclxuCm9mb25vZFsyMDQwXTogQXV4OiA+IEFUK0NTQ0I9MCwiMTAwMDAi
XHIKb2Zvbm9kWzIwNDBdOiBBdXg6IDwgXHJcbk9LXHJcbgpvZm9ub2RbMjA0MF06IEF1eDogPiBB
VCtDU0NCPTAsIjExMDAwIlxyCm9mb25vZFsyMDQwXTogQXV4OiA8IFxyXG5PS1xyXG4Kb2Zvbm9k
WzIwNDBdOiBBdXg6ID4gQVQrQ1NDQj0wLCI0MzUyLTQzNTYiXHIKb2Zvbm9kWzIwNDBdOiBBdXg6
IDwgXHJcbk9LXHJcbgoKVXNpbmcgbWluaWNvbToKCQphdCtjc2NiPwoKK0NTQ0I6IDAsICI0MzUy
LTQzNTYsMTEwMDAsMTAwMDAsOTAwMCw4MDAwLDcwMDAsNjAwMCw1MDAwLDQwMDAsMzAwMCwyMDAw
LDIzNywxMzAsMTAxLDk3LDUzLDUwLDMwLDExLDAiLCIiCgpPSwoKYXQrY3NjYj0wLCIxMDAwIgoK
T0sKYXQrY3NjYj8KCitDU0NCOiAwLCAiMTAwMCw0MzUyLTQzNTYsMTEwMDAsMTAwMDAsOTAwMCw4
MDAwLDcwMDAsNjAwMCw1MDAwLDQwMDAsMzAwMCwyMDAwLDIzNywxMzAsMTAxLDk3LDUzLDUwLDMw
LDExLDAiLCIiCgpPSwoKYXQrY3NjYj0xCgpPSwphdCtjc2NiPwoKK0NTQ0I6IDEsICIiLCIiCgpP
SwoKYXQrY3NjYj0wLCAiNDM1Mi00MzU2LDExMDAwLDEwMDAwLDkwMDAsODAwMCw3MDAwLDYwMDAi
CgpPSwphdCtjc2NiPTAsICI0MzUyLTQzNTYsMTEwMDAsMTAwMDAsOTAwMCw4MDAwLDcwMDAsNjAw
MCw1MDAwIgoKT0sKCmF0K2NzY2I9MCwgIjQzNTItNDM1NiwxMTAwMCwxMDAwMCw5MDAwLDgwMDAs
NzAwMCw2MDAwLDUwMDAsNDAwMCIKCkVSUk9SCgoKYXQrY3NjYj8KCitDU0NCOiAwLCAiIiwiIgoK
T0sKYXQrY3NjYj0wLCAiNDM1Mi00MzU2LDExMDAwLDEwMDAwLDkwMDAsODAwMCw3MDAwLDYwMDAs
NTAwMCwxIgoKT0sKCmF0K2NzY2I9MCwgIjQzNTItNDM1NiwxMTAwMCwxMDAwMCw5MDAwLDgwMDAs
NzAwMCw2MDAwLDUwMDAsMSwyIgoKT0sKCmF0K2NzY2I9MCwgIjQzNTItNDM1NiwxMTAwMCwxMDAw
MCw5MDAwLDgwMDAsNzAwMCw2MDAwLDUwMDAsMSwyMSIKCkVSUk9SCgoK

--===============1189812482160078462==--

