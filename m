Content-Type: multipart/mixed; boundary="===============7512125296432435703=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: dbus error while trying to enable hfp connection with smartphone
Date: Thu, 09 Feb 2012 18:19:30 -0600
Message-ID: <4F346292.4010103@gmail.com>
In-Reply-To: <1328829952.14709.6.camel@Ostrea-Edulis.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7512125296432435703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/09/2012 05:25 PM, Robyn Minkler wrote:
> Hi Denis,
> =

> ofonod is throwing this error when I run enable-modem:
> =

> ofonod[17676]: plugins/hfp_hf.c:hfp_connect_reply() Connect reply:
> Method "Connect" with signature "" on interface
> "org.bluez.HandsfreeGateway" doesn't exist
> =

> Is this helpful?
> =


Sounds like your BlueZ is not configured properly.  Try adding
Enable=3DGateway to the [General] section of your /etc/bluetooth/audio.conf.

Regards,
-Denis

--===============7512125296432435703==--

