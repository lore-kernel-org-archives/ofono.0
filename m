Content-Type: multipart/mixed; boundary="===============3743920079166950060=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Mon, 06 Jun 2011 18:25:44 -0500
Message-ID: <4DED61F8.6090608@gmail.com>
In-Reply-To: <alpine.DEB.2.00.1106081719410.30119@entw48>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3743920079166950060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> Hi,
> I did not know how to better ask for some help so I sent this patch
> without being completely right.
> =

> I needed to move the ENV{OFONO_DRIVER}=3D"telit" to the end like the other
> modems do. Without the add_modem is called with different modem objects.
> =

> The problem about the current patch is:
> =

> ofonod[31654]: src/modem.c:ofono_modem_create() name: 000000000002,
> type: telit
> =

> I want to ask for some advice on how to best debug this problem. I tried
> it with a short PROGRAM=3D"/tmp/foo.pl" which prints the environment. If I
> add it to the
> =

> ATTRS{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit", PROGRAM=3D"/tmp=
/foo.pl"
> =

> line the environment for OFONO_DRIVER do not exist. If I add the same
> script to one of the lines at the first section I get the proper
> OFONO_DRIVER telit envirionment.
> =

> Thanks in advance for any hints :)
> =

> I was not able to hard code the interface number as novatel does it
> because the interfaces change on different telit modems. I used the
> huawai code as base.

So let me understand what you're trying to achieve, you want to set an
environment variable telling the driver that a particular model has a
GPS port?

From what I remember of the Telit modems, all ports are fully
functional, so the GPS port can be on any tty.  If this is the case,
then the way this can be accomplished is by querying the model /
revision of the modem during the enable() stage in the modem driver and
adding the appropriate atom as needed.

Regards,
-Denis

--===============3743920079166950060==--

