Content-Type: multipart/mixed; boundary="===============9110162085393605336=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-ussd: USSD request is optional to monitor SS
 interface
Date: Sun, 24 Jun 2012 16:51:30 -0500
Message-ID: <4FE78BE2.2030903@gmail.com>
In-Reply-To: <1340810814-27481-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9110162085393605336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/27/2012 10:26 AM, Philippe Nunes wrote:
> ---
>   test/test-ussd |   60 ++++++++++++++++++++++++++++++++++++++-----------=
-------
>   1 file changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/test/test-ussd b/test/test-ussd
> index c21f5e3..c8099b0 100755
> --- a/test/test-ussd
> +++ b/test/test-ussd
> @@ -9,12 +9,28 @@ import dbus.mainloop.glib
>
>   state =3D None
>
> +def clear_screen(numlines=3D100):
> +	import os
> +	if os.name =3D=3D "posix":
> +		os.system('clear')
> +
> +	elif os.name in ("nt", "dos", "ce"):
> +		os.system('CLS')
> +
> +	else:
> +		print '\n' * numlines
> +
> +def print_menu():
> +	if state =3D=3D "user-response":
> +		print "Enter response (c for cancel - x for exit):"
> +	elif state =3D=3D "idle":
> +		print "Enter USSD request (x for exit):"
> +
>   def ussd_notification_received(content):
>   	print("Network sent a Notification: " + content)
>
>   def ussd_request_received(content):
>   	print("Network sent a Request: " + content)
> -	ss.Cancel()
>
>   def ussd_property_changed(name, value):
>   	global state
> @@ -23,23 +39,27 @@ def ussd_property_changed(name, value):
>   	print("USSD session state is " + value)
>   	state =3D str(value)
>
> +	print_menu()
> +
>   def stdin_handler(fd, condition):
> -	s =3D os.read(fd.fileno(), 160).rstrip()
> -	if not s:
> -		ss.Cancel()
> +	s =3D os.read(fd.fileno(), 182).rstrip()
> +
> +	if s =3D=3D 'c':
> +		if state =3D=3D "user-response" or state =3D=3D 'active':
> +			clear_screen
> +			ss.Cancel()
> +	elif s =3D=3D 'x':
> +		sys.exit(1)
>   	elif state =3D=3D "user-response":
> +		clear_screen()
>   		print ss.Respond(s, timeout =3D 100)
>   	elif state =3D=3D "idle":
> +		clear_screen()
>   		print ss.Initiate(s, timeout =3D 100)
> -	else:
> -		print "Invalid state", state
> +
>   	return True
>
>   if __name__ =3D=3D "__main__":
> -	if (len(sys.argv)<  2):
> -		print "Usage: %s [modem]<ussd-string>" % (sys.argv[0])
> -		sys.exit(1)
> -

Why are you removing this?  The script should still be printing a basic =

usage help script even if you are adding new semantics to it.

>   	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
>
>   	bus =3D dbus.SystemBus()
> @@ -50,24 +70,26 @@ if __name__ =3D=3D "__main__":
>   	modems =3D manager.GetModems()
>   	modem =3D modems[0][0]
>
> -	if (len(sys.argv) =3D=3D 2):
> -		ussd =3D sys.argv[1]
> -	else:
> +	if (len(sys.argv) =3D=3D 3):
>   		modem =3D sys.argv[1]
> -		ussd =3D sys.argv[2]
>
>   	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
>   					'org.ofono.SupplementaryServices')
>
> -	props =3D ss.GetProperties()
> -	for p in props:
> -		ussd_property_changed(p, props[p])
> -
>   	ss.connect_to_signal("NotificationReceived", ussd_notification_receive=
d)
>   	ss.connect_to_signal("RequestReceived", ussd_request_received)
>   	ss.connect_to_signal("PropertyChanged", ussd_property_changed)
>
> -	print ss.Initiate(ussd, timeout=3D100)
> +	if (len(sys.argv)>  1):
> +		if (len(sys.argv) =3D=3D 2):
> +			ussd =3D sys.argv[1]
> +		elif (len(sys.argv) =3D=3D 3):
> +			ussd =3D sys.argv[2]
> +		print ss.Initiate(ussd, timeout=3D100)
> +	else:
> +		props =3D ss.GetProperties()
> +		for p in props:
> +			ussd_property_changed(p, props[p])

What exactly are you getting out of the else clause that isn't already =

handled by list-modems and monitor-ofono scripts?

>
>   	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
>

Regards,
-Denis

--===============9110162085393605336==--

