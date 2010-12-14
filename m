Content-Type: multipart/mixed; boundary="===============2912294411175780577=="
MIME-Version: 1.0
From: Cahill, Ben M <ben.m.cahill@intel.com>
Subject: RE: Something wrong with PushNotification interface?
Date: Tue, 14 Dec 2010 10:24:59 -0800
Message-ID: <02B3067C068D0549A8CCFCB17D4D318BD26CCBA7@orsmsx502.amr.corp.intel.com>
In-Reply-To: <02B3067C068D0549A8CCFCB17D4D318BD26CCBA5@orsmsx502.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2912294411175780577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Never mind ... path needed to be formatted with slashes, like /org/xyz/Push=
NotificationAgent

Arggh.

-- Ben --

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] =

>On Behalf Of Cahill, Ben M
>Sent: Tuesday, December 14, 2010 11:17 AM
>To: ofono(a)ofono.org
>Subject: Something wrong with PushNotification interface?
>
>Trying to send DBUS message to ofono's PushNotification =

>interface is apparently crashing the DBUS connection for me.  =

>Even when trying to send message from d-feet, d-feet (the app =

>itself) shuts down instantly.  Can't find any error message =

>anywhere (not even from DBG statements that I added to ofono's =

>push_notification_register_agent() function ... message =

>apparently doesn't get that far).
>
>Anyone else see the same thing?
>
>I've seen in DBUS spec that DBUS should silently close the =

>connection if spec or protocol gets violated; wondering if =

>this is happening?
>
>I'm no DBUS expert, and have spent a couple days trying to =

>chase this down.  :-(
>
>
>Here's what I do to reproduce the problem (using phonesim):
>
># ofonod -n -d '*'
>$ src/phonesim -p 12345 -gui src/default.xml
># d-feet
>	Click on "org.ofono" in left window
>	navigate to /phonesim/org.ofono.Modem/Methods
>	SetProperty "Powered", True
>	SetProperty "Online", True
>
>(so far, so good)
>
>	Click again on "org.ofono" in left window to refresh =

>object path tree
>	navigate to =

>/phonesim/Interfaces/org.ofono.PushNotification/Methods
>	double-click "RegisterAgent"
>	RegisterAgent "/org.xyz/PushNotificationAgent"
>
>(d-feet GUI disappears, and new command line prompt appears)
>(if I were using the daemon I'm developing, it would report =

>"System bus has disconnected" and exit)
>
>Any ideas?
>
>-- Ben --
>
>
>	=

>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono
>
--===============2912294411175780577==--

