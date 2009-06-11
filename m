Content-Type: multipart/mixed; boundary="===============0813789315150323286=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: failed to start ofonod....
Date: Thu, 11 Jun 2009 13:47:41 +0200
Message-ID: <1244720861.27363.11.camel@violet>
In-Reply-To: <9abb677a75928bf307cc854d4aabff72@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0813789315150323286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > *$ sudo ofonod  -n -d
> > ofonod[25234]: oFono version 0.0
> > ofonod[25234]: Unable to hop onto D-Bus: Connection ":1.646" is not
> allowed
> > to own the service "org.ofono" due to security policies in the
> > configuration
> > file
> > ofonod[25234]: Exit
> =

> Try:
> =

> $ sudo /etc/init.d/dbus reload

if you need that, then your system is messed up. D-Bus should use
inotify and auto-detect policy changes and reload them.

Regards

Marcel



--===============0813789315150323286==--

