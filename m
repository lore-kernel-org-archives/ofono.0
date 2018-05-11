Content-Type: multipart/mixed; boundary="===============4299904845881386164=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Voice calls over qmi was Re: Incoming sms problem on Motorola Droid 4
Date: Sat, 12 May 2018 01:18:25 +0200
Message-ID: <20180511231825.GA8944@amd>
In-Reply-To: <D8F86CC7-9B4B-4F61-9808-CE8E6A79EBC0@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4299904845881386164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > More explanation needed it seems:
> > =

> > I can already do USB with AT commands, no multiplexer needed. We'd
> > actually prefer to go over serial (with multiplexer), because USB
> > needs to be powered down in idle, and you still need communication
> > ovre serial to know that wakeup of USB is needed.
> > =

> > Yes, it is complex :-(.
> =

> I missed the part that the weird serial multiplexer is wired independentl=
y. Then do everything via that serial multiplexer and never look back. Howe=
ver if that is as broken, then you will be really out of luck. Making this =
work reliable will be really hard.
> =

> While we have seen QMI protocol issues as well, but they have been less b=
ad than the bolted on AT commands. Manufactures always get AT commands wron=
g since they let humans test it and not a real telephony stack like oFono.
> =


Yes, I understand why AT commands are bad. IIRC messages should work
over qmi... but voice calls do not:

user(a)devuan:/my/ofono$ sudo python test/dial-number 604343103
Using modem /gobi_0
Traceback (most recent call last):
  File "test/dial-number", line 40, in <module>
      path =3D vcm.Dial(number, hide_callerid)
        File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line
	70, in __call__
	    return self._proxy_method(*args, **keywords)
 File "/usr/lib/python2.7/dist-packages/dbus/proxies.py",
 line 145, in __call__
 **keywords)
 File
 "/usr/lib/python2.7/dist-packages/dbus/connection.py",
 line 651, in call_blocking message, timeout) dbus.exceptions.DBusException:
 org.ofono.Error.NotImplemented: Implementation not provided
user(a)devuan:/my/ofono$
			=


Communication with modem is definitely happening:

ofonod[7881]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[7881]: drivers/qmimodem/network-registration.c:event_notify()
signal with 80%(-55 dBm) on 5
ofonod[7881]: src/network.c:ofono_netreg_strength_notify() strength 80
ofonod[7881]: drivers/qmimodem/network-registration.c:event_notify()
ofonod[7881]: drivers/qmimodem/network-registration.c:event_notify()
signal with 100%(-54 dBm) on 5

ofono supports voice calls over qmi, right? Is it possible that
mdm6600 does not support them?

qmicli has some voice options, but not option to do a call, either...

user(a)devuan:/my/ofono$ qmicli -d /dev/cdc-wdm0 --voice-get-config
error: couldn't open the QmiDevice: Cannot open device file '/dev/cdc-wdm0'=
: Permission denied
user(a)devuan:/my/ofono$ sudo qmicli -d /dev/cdc-wdm0 --voice-get-config
[/dev/cdc-wdm0] Successfully retrieved Voice configuration:
Current TTY mode: 'off'Current Preferred Voice SO:
	NAM ID: '0'
	EVRC capability: 'enabled'
	Home Page Voice SO: 'evrc'
	Home Origination Voice SO: 'evrc'
	Roaming Origination Voice SO: 'evrc'
AMR Status:
	GSM: 'enabled'
	WCDMA: 'not-supported, gsm-hr-amr' (0x0005)
Current Voice Privacy Preference: 'enhanced'
user(a)devuan:/my/ofono$ sudo qmicli -d /dev/cdc-wdm0 --voice-get-supported=
-messages
error: couldn't get supported VOICE messages: QMI protocol error (71): 'Inv=
alidQmiCommand'
user(a)devuan:/my/ofono$ =



Thanks,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4299904845881386164==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjJKTUVBQ2drUU1PZndhcFhiK3ZKeDdnQ2ZVdG1RV0pKYmtYbFUwcWxlL2dnV0MwNUsK
NGJRQW9NVGErZ2dkZ3N0UWJpZU1kd2NzQkRDeDJVZWoKPUFkNEkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4299904845881386164==--

