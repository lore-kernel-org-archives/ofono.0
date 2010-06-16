Content-Type: multipart/mixed; boundary="===============2578932910718440815=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: The error when run the /test/list-modems script
Date: Wed, 16 Jun 2010 17:44:28 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F483103@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A1539520AE9@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2578932910718440815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Ye,  =


First, please send plain text mail to oFono mailing list next time. Please =
see my reply below.

Regards,
Zhenhua

________________________________

	From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of Huang, Ye
	Sent: Monday, June 14, 2010 10:24 AM
	To: ofono(a)ofono.org
	Subject: The error when run the /test/list-modems script
	=

	=


	Hi,

	 =


	we meet the following problem when run ofonod

	 =


	[test environment]

	 OS: meego 0.90

	 ofonod ver: 0.18

	 modem : IFX6160

	 test board : Intel CDK QS

	 SIM card : 2g SIM card

	 =


	[operation step]

	1. power on test board(MRST CDK)

	2. check ofonod has been startuped by ps command

	3. run /usr/lib/ofono/test/list-modems test script

	4. find below error.

	 =


	could you help us analyze the possible reason of this problem?

	i

	 =


	=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=EF=BC=9D=
=EF=BC=9D=EF=BC=9D

	[root(a)localhost test]# ./list-modems

	[ /ifx_at ]

	    Powered =3D 1

	    Interfaces =3D org.ofono.DataConnectionManager org.ofono.Phonebook

	org.ofono.NetworkRegistration org.ofono.CallMeter org.o

	    Model =3D  XMM2130

	    Manufacturer =3D  Ehs2agrRel6

	    Serial =3D *359559020000412

	    Revision =3D  Undefined

	    [ org.ofono.DataConnectionManager ]

	        Status =3D registered

	        Powered =3D 1

	        Attached =3D 1

	        PrimaryContexts =3D /ifx_at/primarycontext1

	        RoamingAllowed =3D 1

	    [ org.ofono.Phonebook ]

	    [ org.ofono.NetworkRegistration ]

	        Status =3D registered

	        Strength =3D 87

	        LocationAreaCode =3D 4473

	        Mode =3D auto

	        Operator =3D CMCC

	        AvailableOperators =3D /ifx_at/operator/46000

	        Technology =3D GSM+EGPRS

	        CellId =3D 33258

	    [ org.ofono.CallMeter ]

[Zhenhua] It's clear that ofono meets some problems when get properties fro=
m CallMeter atom. Please kill ofonod and run 'OFONO_AT_DEBUG=3D1 ofonod -n =
-d '*'' to verbose ofono AT chat log. The log will help us to root cause th=
e problem. Thanks.


	Traceback (most recent call last):

	  File "./list-modems", line 30, in <module>

	    object =3D dbus.Interface(bus.get_object('org.ofono', path),

	  File "/usr/lib/python2.6/site-packages/dbus/bus.py", line 244, in

	get_object

	    follow_name_owner_changes=3Dfollow_name_owner_changes)

	  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 241, in

	__init__

	    self._named_service =3D conn.activate_name_owner(bus_name)

	  File "/usr/lib/python2.6/site-packages/dbus/bus.py", line 183, in

	activate_name_owner

	    self.start_service_by_name(bus_name)

	  File "/usr/lib/python2.6/site-packages/dbus/bus.py", line 281, in

	start_service_by_name

	    'su', (bus_name, flags)))

	  File "/usr/lib/python2.6/site-packages/dbus/connection.py", line 630, in

	call_blocking

	    message, timeout)

	 =


	 =


	Best regards,
	Ye =



--===============2578932910718440815==--

