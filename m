Content-Type: multipart/mixed; boundary="===============3776984902618752215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test: Adapt test scripts to multi-modem scenarios
Date: Mon, 09 Jun 2014 13:10:16 -0500
Message-ID: <5395F888.2030808@gmail.com>
In-Reply-To: <1402302145-12943-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3776984902618752215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 06/09/2014 03:22 AM, Alfonso Sanchez-Beato wrote:
> Some tests scripts were not ready to handle situations with more than
> one modem present. This change fixes some of these scripts.
> ---

I think this is useful, thanks for doing this.

>  test/activate-context   | 61 +++++++++++++++++++++++++----------------
>  test/create-multiparty  | 12 ++++----
>  test/deactivate-context | 73 +++++++++++++++++++++++++++++--------------=
------
>  test/hangup-active      | 10 +++++--
>  test/private-chat       | 17 ++++++------
>  test/release-and-answer | 29 ++++++++++++++------
>  test/release-and-swap   | 29 ++++++++++++++------
>  7 files changed, 144 insertions(+), 87 deletions(-)
> =


It might be easier to separate the changes into multiple patches next
time.  That way I can take the non-controversial ones right away.

> diff --git a/test/activate-context b/test/activate-context
> index 22ad173..816de86 100755
> --- a/test/activate-context
> +++ b/test/activate-context
> @@ -5,36 +5,49 @@ import dbus
>  =

>  bus =3D dbus.SystemBus()
>  =

> -manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> -						'org.ofono.Manager')
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.=
Manager')
>  =

> -modems =3D manager.GetModems()
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]
> +	context_idx =3D 0

Can you preserve the current behavior for this case?  e.g. with no
arguments we find the first modem with the ConnectionManager interface
and activate the context.

> +elif (len(sys.argv) =3D=3D 2):
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]
> +	context_idx =3D int(sys.argv[1]) - 1
> +elif (len(sys.argv) =3D=3D 3):
> +	modem =3D sys.argv[1]
> +	context_idx =3D int(sys.argv[2]) - 1
> +else:
> +	print("Usage: %s [modem] [context_number]" % (sys.argv[0]))
> +	sys.exit(1)
>  =

> -for path, properties in modems:
> -	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
> -		continue
> +modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofo=
no.Modem')
> +properties =3D modemapi.GetProperties()
>  =

> -	connman =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.ConnectionManager')
> +if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
> +	print("org.ofono.ConnectionManager not found")
> +	exit(2)
>  =

> -	contexts =3D connman.GetContexts()
> +connman =3D dbus.Interface(bus.get_object('org.ofono', modem),
> +				'org.ofono.ConnectionManager')
>  =

> -	if (len(contexts) =3D=3D 0):
> -		print("No context available")
> -		sys.exit(1)
> +contexts =3D connman.GetContexts()
>  =

> -	connman.SetProperty("Powered", dbus.Boolean(1))
> +if (len(contexts) =3D=3D 0):
> +	print("No context available")
> +	sys.exit(1)
>  =

> -	if len(sys.argv) > 1:
> -		path =3D contexts[int(sys.argv[1])][0]
> -	else:
> -		path =3D contexts[0][0]
> +connman.SetProperty("Powered", dbus.Boolean(1))
>  =

> -	context =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.ConnectionContext')
> +path =3D contexts[context_idx][0]
> +
> +context =3D dbus.Interface(bus.get_object('org.ofono', path),
> +				'org.ofono.ConnectionContext')
> +
> +try:
> +	context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
> +except dbus.DBusException as e:
> +	print("Error activating %s: %s" % (path, str(e)))
> +	exit(2)
>  =

> -	try:
> -		context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
> -	except dbus.DBusException as e:
> -		print("Error activating %s: %s" % (path, str(e)))
> -		exit(2)
> diff --git a/test/create-multiparty b/test/create-multiparty
> index b6395e8..1b76010 100755
> --- a/test/create-multiparty
> +++ b/test/create-multiparty
> @@ -8,12 +8,14 @@ bus =3D dbus.SystemBus()
>  manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>  						'org.ofono.Manager')
>  =

> -modems =3D manager.GetModems()
> -
> -path =3D modems[0][0]
> -
> -if (len(sys.argv) =3D=3D 2):
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	path =3D modems[0][0]
> +elif (len(sys.argv) =3D=3D 2):
>  	path =3D sys.argv[1]
> +else:
> +	print("Usage: %s [modem]" % (sys.argv[0]))
> +	sys.exit(1)
>  =


This part looks fine to me

>  manager =3D dbus.Interface(bus.get_object('org.ofono', path),
>  						'org.ofono.VoiceCallManager')
> diff --git a/test/deactivate-context b/test/deactivate-context
> index bc2ffd3..6a5164a 100755
> --- a/test/deactivate-context
> +++ b/test/deactivate-context
> @@ -5,34 +5,47 @@ import dbus
>  =

>  bus =3D dbus.SystemBus()
>  =

> -manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> -						'org.ofono.Manager')
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.=
Manager')
> +
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]
> +	context_idx =3D 0

Same as above, can we preserve the current behavior here?

> +elif (len(sys.argv) =3D=3D 2):
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]
> +	context_idx =3D int(sys.argv[1]) - 1
> +elif (len(sys.argv) =3D=3D 3):
> +	modem =3D sys.argv[1]
> +	context_idx =3D int(sys.argv[2]) - 1
> +else:
> +	print("Usage: %s [modem] [context_number]" % (sys.argv[0]))
> +	sys.exit(1)
> +
> +modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofo=
no.Modem')
> +properties =3D modemapi.GetProperties()
> +
> +if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
> +	print("org.ofono.ConnectionManager not found")
> +	exit(2)
> +
> +connman =3D dbus.Interface(bus.get_object('org.ofono', modem),
> +				'org.ofono.ConnectionManager')
> +
> +contexts =3D connman.GetContexts()
> +
> +if (len(contexts) =3D=3D 0):
> +	print("No context available")
> +	sys.exit(1)
> +
> +path =3D contexts[context_idx][0]
> +
> +context =3D dbus.Interface(bus.get_object('org.ofono', path),
> +				'org.ofono.ConnectionContext')
> +
> +try:
> +	context.SetProperty("Active", dbus.Boolean(0))
> +except dbus.DBusException as e:
> +	print("Error deactivating %s: %s" % (path, str(e)))
> +	exit(2)
>  =

> -modems =3D manager.GetModems()
> -
> -for path, properties in modems:
> -	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
> -		continue
> -
> -	connman =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.ConnectionManager')
> -
> -	contexts =3D connman.GetContexts()
> -
> -	if (len(contexts) =3D=3D 0):
> -		print("No context available")
> -		sys.exit(1)
> -
> -	if len(sys.argv) > 1:
> -		path =3D contexts[int(sys.argv[1])][0]
> -	else:
> -		path =3D contexts[0][0]
> -
> -	context =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.ConnectionContext')
> -
> -	try:
> -		context.SetProperty("Active", dbus.Boolean(0))
> -	except dbus.DBusException as e:
> -		print("Error activating %s: %s" % (path, str(e)))
> -		exit(2)
> diff --git a/test/hangup-active b/test/hangup-active
> index 8e65bc4..82e0eb0 100755
> --- a/test/hangup-active
> +++ b/test/hangup-active
> @@ -8,8 +8,14 @@ bus =3D dbus.SystemBus()
>  manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>  						'org.ofono.Manager')
>  =

> -modems =3D manager.GetModems()
> -path =3D modems[0][0]
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	path =3D modems[0][0]
> +elif (len(sys.argv) =3D=3D 2):
> +	path =3D sys.argv[1]
> +else:
> +	print("Usage: %s [modem]" % (sys.argv[0]))
> +	sys.exit(1)
>  =


This looks fine...

>  manager =3D dbus.Interface(bus.get_object('org.ofono', path),
>  						'org.ofono.VoiceCallManager')
> diff --git a/test/private-chat b/test/private-chat
> index 17d17d0..e7e5406 100755
> --- a/test/private-chat
> +++ b/test/private-chat
> @@ -3,24 +3,23 @@
>  import sys
>  import dbus
>  =

> +if (len(sys.argv) !=3D 2):
> +	print("Usage: %s [voicecall_path]" % (sys.argv[0]))
> +	exit(1)
> +
>  bus =3D dbus.SystemBus()
>  =

>  manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>  						'org.ofono.Manager')
>  =

> -modems =3D manager.GetModems()
> -path =3D modems[0][0]
> -
> -if (len(sys.argv) =3D=3D 3):
> -	path =3D sys.argv[1]
> -	callid =3D sys.argv[2]
> -else:
> -	callid =3D sys.argv[1]
> +call =3D sys.argv[1]
> +sep =3D call.find("/", 1)
> +path =3D call[0:sep]
>  =

>  manager =3D dbus.Interface(bus.get_object('org.ofono', path),
>  						'org.ofono.VoiceCallManager')
>  =

> -mpty =3D manager.PrivateChat(callid, timeout=3D100)
> +mpty =3D manager.PrivateChat(call, timeout=3D100)
>  =


ditto

>  for path in mpty:
>  	print(path)
> diff --git a/test/release-and-answer b/test/release-and-answer
> index 62eaa79..a8a9319 100755
> --- a/test/release-and-answer
> +++ b/test/release-and-answer
> @@ -1,5 +1,6 @@
>  #!/usr/bin/python3
>  =

> +import sys
>  import dbus
>  =

>  bus =3D dbus.SystemBus()
> @@ -9,14 +10,26 @@ manager =3D dbus.Interface(bus.get_object('org.ofono',=
 '/'),
>  =

>  modems =3D manager.GetModems()
>  =

> -for path, properties in modems:
> -	print("[ %s ]" % (path))
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	path =3D modems[0][0]

Again, can we preserve the current behavior ?

> +elif (len(sys.argv) =3D=3D 2):
> +	path =3D sys.argv[1]
> +else:
> +	print("Usage: %s [modem]" % (sys.argv[0]))
> +	exit(1)
>  =

> -	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
> -		continue
> +modemapi =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofon=
o.Modem')
> +properties =3D modemapi.GetProperties()
>  =

> -	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.VoiceCallManager')
> +if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
> +	print("org.ofono.VoiceCallManager not found")
> +	exit(2)
> +
> +print("[ %s ]" % (path))
> +
> +mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
> +			'org.ofono.VoiceCallManager')
> +
> +mgr.ReleaseAndAnswer()
>  =

> -	mgr.ReleaseAndAnswer()
> -	break
> diff --git a/test/release-and-swap b/test/release-and-swap
> index b4c0af1..3276bf5 100755
> --- a/test/release-and-swap
> +++ b/test/release-and-swap
> @@ -1,5 +1,6 @@
>  #!/usr/bin/python3
>  =

> +import sys
>  import dbus
>  =

>  bus =3D dbus.SystemBus()
> @@ -7,16 +8,26 @@ bus =3D dbus.SystemBus()
>  manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>  						'org.ofono.Manager')
>  =

> -modems =3D manager.GetModems()
> +if (len(sys.argv) =3D=3D 1):
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]

ditto

> +elif (len(sys.argv) =3D=3D 2):
> +	modem =3D sys.argv[1]
> +else:
> +	print("Usage: %s [modem]" % (sys.argv[0]))
> +	exit(1)
>  =

> -for path, properties in modems:
> -	print("[ %s ]" % (path))
> +modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofo=
no.Modem')
> +properties =3D modemapi.GetProperties()
>  =

> -	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
> -		continue
> +if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
> +	print("org.ofono.VoiceCallManager not found")
> +	exit(2)
>  =

> -	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.VoiceCallManager')
> +print("[ %s ]" % (modem))
> +
> +mgr =3D dbus.Interface(bus.get_object('org.ofono', modem),
> +			'org.ofono.VoiceCallManager')
> +
> +mgr.ReleaseAndSwap()
>  =

> -	mgr.ReleaseAndSwap()
> -	break
> =


Regards,
-Denis

--===============3776984902618752215==--

