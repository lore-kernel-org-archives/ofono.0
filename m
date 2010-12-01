Content-Type: multipart/mixed; boundary="===============9116672825985121244=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] HACKING: Add ofono.conf file copy command required
Date: Wed, 01 Dec 2010 11:20:29 +0100
Message-ID: <1291198829.4795.89.camel@aeonflux>
In-Reply-To: <20101201095558.GA7170@candlejack.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9116672825985121244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> > +  Copy configuration file which specifies the required security polici=
es
> > +    # sudo cp ./src/ofono.conf /etc/dbus-1/system.d/
> > +
> =

> Considered to add this too?
> =

> sudo killall -HUP dbus-daemon

that is actually a bad idea. I would not recommend it. The dbus-daemon
should be built with inotify support and if not, then reboot of the
system is a better idea.

Regards

Marcel



--===============9116672825985121244==--

