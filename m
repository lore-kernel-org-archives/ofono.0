Content-Type: multipart/mixed; boundary="===============7296525666079056007=="
MIME-Version: 1.0
From: Nicolas ADELL <nicolas.adell@actia.fr>
Subject: Problem setting up the context
Date: Thu, 16 Nov 2017 09:27:50 +0000
Message-ID: <VI1PR0102MB35993442B4E04D2D62FED03A852E0@VI1PR0102MB3599.eurprd01.prod.exchangelabs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7296525666079056007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm facing an issue with oFono when the application is trying to establish =
a ppp data connection.

The context is firstly activated by the application and kept until oFono ge=
ts an 'NW DETACH' event.

ofonod[758]: App: < \r\n+CGEV: NW DETACH\r\n
ofonod[758]: gprs.c:cgev_notify() event: NW DETACH
ofonod[758]: gprs.c:ofono_gprs_detached_notify()
ofonod[758]: gprs-context.c:at_gprs_detach_shutdown() cid 1

At that time, oFono attempts to close the link properly.

However, it takes few seconds before getting the state notified as 'CLOSED'=
 and the 'pppcp_this_layer_finished()' function called.

During this interval, the Packet Domain network registration status is repo=
rted as registered:

ofonod[758]: gprs.c:cgreg_notify() 5
ofonod[758]: gprs.c:ofono_gprs_status_notify()

The 'ppp_disconnect()' function is not triggered yet, but the application a=
ttempts to re-activate the context anyway because the 'Attached' gprs prope=
rty has been updated and signaled as TRUE.

Then 'ppp_disconnect()' is triggered.

ofonod[758]: gatppp.c:ppp_dead()
ofonod[758]: gprs-context.c:ppp_disconnect() Reason: 6
ofonod[758]: gprs.c:pri_activate_callback() 0x5508c8
ofonod[758]: gprs.c:pri_activate_callback() Activating context failed with =
error: Unknown error type

At this time the gprs context state equals to "Enabling", due to the latest=
 appliction request =3D> the 'pri_activate_callback()' callback is executed.

oFono gets a "NO CARRIER" from the modem, but it trigges the 'at_cgdcont_cb=
()' with error.

=3D> The pri_activate_callback() is called twice with error

ofonod[758]: gprs-context.c:ppp_disconnect()
ofonod[758]: gprs.c:pri_activate_callback() 0x19b7978
ofonod[758]: gprs.c:pri_activate_callback() Activating context failed with =
error: Unknown error type
ofonod[758]: gprs-context.c:at_cgdcont_cb() ok 0
ofonod[758]: gprs.c:pri_activate_callback() 0x19b7978
ofonod[758]: gprs.c:pri_activate_callback() Activating context failed with =
error: Unknown error type

Because the 'DBusMessage' has been already freed, oFono aborts.

Is there a proper way to prevent this unexpected situation ?

It already tried to catch the 'NO CARRIER' final response without sucess.

Regards,
Nicolas.
--===============7296525666079056007==--

