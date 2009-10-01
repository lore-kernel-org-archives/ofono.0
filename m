Content-Type: multipart/mixed; boundary="===============8086669613953452844=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Using oFono on a G1 (with Debian)
Date: Thu, 01 Oct 2009 13:32:05 -0400
Message-ID: <20091001133205.7f74631c@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8086669613953452844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

It was pointed out that I never made this public, so I'm correcting
that now.  The hardest parts of this involve rooting the phone and
messing around with various images, but.. that's something you want to
do anyways, right? :)

First, the bootstrap steps:

1. Root your phone (if you've purchased an ADP phone, you can skip
this).  Instructions are here:
http://androidcommunity.com/forums/f12/rooting-your-g1-made-easy-11825/

2. Install a decent image on the phone.  I'm using TF 1.5 for this:
http://jf.andblogs.net/2009/05/24/jfv151-images-are-out/.

3. If you've upgraded from an older image, you'll probably want to reset
the data back to factory defaults, otherwise you'll waste a few days
flailing at random things that don't work as expected, or regularly
crash (*cough*).  This can be done via
Settings -> SD card &  phone storage -> Factory data reset.

4. Next, install a Debian chroot (http://www.saurik.com/id/10).  The
unionfs overlay stuff is completely optional; I didn't bother.
Instead, I just chroot into the proper directory on a regular basis.
Enter the chroot, set a password ("passwd").  Install dbus, ssh, and
oFono ("apt-get install openssh-server dbus ofono").

5. Edit /etc/ofono/modem.conf, uncommenting out the G1 lines.  It
should look something like this:

# Sample for Android/HTC G1
[g1]
Driver=3Dg1
Device=3D/dev/smd0


The following steps need to be run after every reboot of the phone:

6. /dev/smd0 is the serial device that oFono will use.  However,
Android's rild needs to not use it at the same time, otherwise the
phone will crash hard.  So, run "stop ril-daemon".  "ps |grep ril"
should not show rild running.

7. Get the phone connected to wireless (Settings -> Wireless
controls).  Android on the G1 regularly disconnects from wireless when
idle to save power; this is pretty damned annoying if you're ssh'd in.
I run Sipdroid on the phone precisely to work around this, as it keeps
the wifi enabled even when the phone is idle.  Sipdroid can be
installed via market, if you find the wireless power save feature as
irritating as I did.

8. Enter your Debian chroot.  Start sshd ("/etc/init.d/ssh
start").  Check the phone's IP address ("/sbin/ifconfig tiwlan0").
Start dbus ("/etc/init.d/dbus start").

9. You should now be able ssh into the phone (which will deposit you
into the Debian chroot, with a sane TERM and various other settings).
If you don't care to see the oFono debugging stuff, just start oFono
normally ("/etc/init.d/ofono start").  If you do want to see debugging
information, start it with the appropriate arguments and variables
("OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n -d").  The modem's path should
be "/g10".

10. Power up the modem:

dbus-send --system --type=3Dmethod_call --print-reply \
--dest=3Dorg.ofono  /g10 org.ofono.Modem.SetProperty string:"Powered" \
variant:boolean:true

11. Send an SMS:

dbus-send --system --print-reply --dest=3Dorg.ofono /g10 \
org.ofono.SmsManager.SendMessage array:string:"6175010000" \
string:"Moooooooooo"

12. Place a voice call:

dbus-send --system --print-reply --dest=3Dorg.ofono /g10 \
org.ofono.VoiceCallManager.Dial string:"6175010000" \
string:"default"



Note that ril initialization is still required for the modem; I haven't
tried completely getting rid of rild.  At some point it would be good
to try it and reverse engineer the binary ril blob to get a completely
free gsm stack, but that's not yet a priority of mine.



--===============8086669613953452844==--

