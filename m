Content-Type: multipart/mixed; boundary="===============1500624585804862695=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using ofono for location service
Date: Thu, 12 Mar 2015 09:45:09 -0500
Message-ID: <5501A675.9080002@gmail.com>
In-Reply-To: <50BCD3CCE3CFC54ABCADC6EDD7405570C55553@BGSMSX104.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1500624585804862695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

 > Kiran: I am facing problem while reading from the file descriptor I =

got from modem.request(). One observation is, I get
> "modem=3D/dev/ttyACM0 aux=3D/dev/ttyACM3 gps=3D/dev/ttyACM5" from ofonod =
logs, but /dev/ttyACM5 is not accepting AT commands when I try from minicom.
> Should I change gps port also to /dev/ttyACM3?

I'm not familiar with how GPS is setup on the he910.  From what I =

remember it is a dedicated port that is activated using $GPS* related =

commands.

The port must be dedicated (so not /dev/ttyACM3) since the file =

descriptor is being passed to an untrusted client.

Regards,
-Denis

--===============1500624585804862695==--

