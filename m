Content-Type: multipart/mixed; boundary="===============0917392885888853696=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Mon, 14 May 2018 11:01:21 +0200
Message-ID: <20180514090121.GA30147@amd>
In-Reply-To: <20180511123926.GK77069@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0917392885888853696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri 2018-05-11 05:39:26, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180511 12:36]:
> > Is there way to power cycle the modem without reboot? That should make
> > the debugging... less bad.
> =

> Yeah you can currently do:
> =

> # rmmod ohci-platform
> # rmmod phy-mapphone-mdm6600
> # modprobe phy-mapphone-mdm6600
> # modprobe ohci-platform
> =

> Or rebind via sysfs. If the modem reboots, you should
> see the phy-mapphone-mdm6600 status interrupt trigger?

Rebind via sysfs works nicely. Note that rather long delay is needed,
otherwise modem is in state when it talks AT but is not fully ready.

Thanks!
									Pavel

	bus =3D "/sys/bus/platform/drivers/"
	phone =3D "phy-mapphone-mdm6600"
        ohci =3D "ohci-platform"
	os.system("sudo chown user "+bus+phone+"/unbind")
        os.system("sudo chown user "+bus+phone+"/bind")
        os.system("sudo chown user "+bus+ohci+"/unbind")
        os.system("sudo chown user "+bus+ohci+"/bind")
        os.system("echo 4a064800.ohci > "+bus+ohci+"/unbind")
        os.system("echo usb-phy(a)1 > "+bus+phone+"/unbind")
        os.system("echo usb-phy(a)1 > "+bus+phone+"/bind")
	os.system("echo 4a064800.ohci > "+bus+ohci+"/bind")
        # With sleep 3, modem is initialized, but +CSMS (etc) still fails  =
     =

        time.sleep(10)



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============0917392885888853696==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjVVR0VBQ2drUU1PZndhcFhiK3ZLZXhnQ2dobGNQTnBmeGZBR2RQUnI2RUZNR1FQNUUK
eGZRQW9NVFU4R2ZvU2R0YTNqQjYwT25xcWxzUGU0R2gKPWxtc1gKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============0917392885888853696==--

