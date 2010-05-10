Content-Type: multipart/mixed; boundary="===============6615043932957996333=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 13:33:30 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E79EE06@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <COL106-W144A139CEFE4D2FDFAC5A9F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6615043932957996333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

	From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of krishna k
	Sent: Monday, May 10, 2010 1:24 PM
	To: ofono(a)ofono.org
	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	Hi Yoon,
	=

	Thank very much for your guidance. I followed the same procedure ...
	=

	You already did following procedure.
	1. ofono-phonesim -p 12345 -gui ~/data/moblin.xml
	2. sudo ofonod -nd =

	=

	And then, you need to type following command to power up modem(phonesim).
	3. dbus-send --system --print-reply --dest=3Dorg.ofono / phonesim0 org.ofo=
no.Modem.SetProperty string:Powered variant:boolean:true

[Zhenhua] I guess there's no space '/'  and 'phonesim0'. Alternatively, You=
 can use 'test/list-modem' to get your modem name and then use 'test/enable=
-modem /phonesim0' to power on it.


	I got below response....
	=

	Must use org.mydomain.Interface.Method notation, no dot in "phonesim0"
	=

	Please see the ps ax | grep ofono*
	--------------------------------------------------------------------------=
-----------------------------------------------
	 1609 pts/0    S+     0:00 ofono-phonesim -p 12345 -gui /home/kandukis/dat=
a/moblin.xml
	 1654 pts/2    S+     0:00 ofonod -nd
	--------------------------------------------------------------------------=
----------------------------------------------
	=

	Can you please suggest  how to get-rid from this problem.
	=

	regards,
	Krishna K Kandula =

	=

________________________________

	Catch the changing security environment Get it now. <http://news.in.msn.co=
m/internalsecurity/>  =



--===============6615043932957996333==--

