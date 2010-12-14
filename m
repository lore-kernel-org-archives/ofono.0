Content-Type: multipart/mixed; boundary="===============7354730504245274179=="
MIME-Version: 1.0
From: Cahill, Ben M <ben.m.cahill@intel.com>
Subject: Something wrong with PushNotification interface?
Date: Tue, 14 Dec 2010 08:16:35 -0800
Message-ID: <02B3067C068D0549A8CCFCB17D4D318BD26CCBA5@orsmsx502.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7354730504245274179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Trying to send DBUS message to ofono's PushNotification interface is appare=
ntly crashing the DBUS connection for me.  Even when trying to send message=
 from d-feet, d-feet (the app itself) shuts down instantly.  Can't find any=
 error message anywhere (not even from DBG statements that I added to ofono=
's push_notification_register_agent() function ... message apparently doesn=
't get that far).

Anyone else see the same thing?

I've seen in DBUS spec that DBUS should silently close the connection if sp=
ec or protocol gets violated; wondering if this is happening?

I'm no DBUS expert, and have spent a couple days trying to chase this down.=
  :-(


Here's what I do to reproduce the problem (using phonesim):

# ofonod -n -d '*'
$ src/phonesim -p 12345 -gui src/default.xml
# d-feet
	Click on "org.ofono" in left window
	navigate to /phonesim/org.ofono.Modem/Methods
	SetProperty "Powered", True
	SetProperty "Online", True

(so far, so good)

	Click again on "org.ofono" in left window to refresh object path tree
	navigate to /phonesim/Interfaces/org.ofono.PushNotification/Methods
	double-click "RegisterAgent"
	RegisterAgent "/org.xyz/PushNotificationAgent"

(d-feet GUI disappears, and new command line prompt appears)
(if I were using the daemon I'm developing, it would report "System bus has=
 disconnected" and exit)

Any ideas?

-- Ben --


=09
--===============7354730504245274179==--

