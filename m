Content-Type: multipart/mixed; boundary="===============3088128009061904889=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Mon, 17 Jan 2011 12:37:04 -0600
Message-ID: <4D348C50.4070409@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC18BCEA@008-AM1MPN1-006.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3088128009061904889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> So these are redundant, unless the whole thing is rewritten as:
> =

> 	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.SimToo=
lkitAgent"/>
> 	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.PushNo=
tificationAgent"/>
> 	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.SmartM=
essagingAgent"/>
> =


The agents are registered by the application, not ofono.  So the
destination is in fact not org.ofono but a system bus connection owned
by the application.  Hence the need to punch holes here.

Regards,
-Denis

--===============3088128009061904889==--

