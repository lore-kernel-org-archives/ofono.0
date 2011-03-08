Content-Type: multipart/mixed; boundary="===============6446802453786274909=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test/test-message-waiting: Add a new test file to
 validate org.ofono.MessageWaiting
Date: Tue, 08 Mar 2011 13:38:29 -0600
Message-ID: <4D7685B5.8000808@gmail.com>
In-Reply-To: <1299601667-7099-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6446802453786274909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 03/08/2011 10:27 AM, Bertrand Aygon wrote:
> ---
>  test/test-message-waiting |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100755 test/test-message-waiting

Please also add this to Makefile.am

> =

> diff --git a/test/test-message-waiting b/test/test-message-waiting
> new file mode 100755
> index 0000000..79fe810
> --- /dev/null
> +++ b/test/test-message-waiting
> @@ -0,0 +1,36 @@
> +#!/usr/bin/python
> +
> +import gobject
> +import sys
> +import dbus
> +import dbus.mainloop.glib
> +
> +def mw_property_changed(name, value):
> +  	if name =3D=3D 'VoicemailMessageCount':

There is a mix of tabs and spaces here.

> +		print "MessageWaiting property: '%s' changed to '%d'" % (name, value)
> +	else:
> +		print "MessageWaiting property: '%s' changed to '%s'" % (name, value)
> +

Can you rewrite the code to not go over 80 characters per line?  Even in
our test scripts we try to stick to that rule.

> +if __name__ =3D=3D "__main__":
> +	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +	bus =3D dbus.SystemBus()
> +
> +	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +			'org.ofono.Manager')
> +
> +	modems =3D manager.GetModems()
> +
> +	mw =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
> +			'org.ofono.MessageWaiting')
> +
> +	mw.connect_to_signal("PropertyChanged", mw_property_changed)
> +
> +	properties =3D mw.GetProperties()
> +
> +	print "Voicemail waiting: %s" % (properties['VoicemailWaiting'])
> +	print "Voicemail message count: %d" % (properties['VoicemailMessageCoun=
t'])
> +	print "Voicemail mailbox number: %s" % (properties['VoicemailMailboxNum=
ber'])
> +
> +	mainloop =3D gobject.MainLoop()
> +	mainloop.run()

Regards,
-Denis

--===============6446802453786274909==--

