Content-Type: multipart/mixed; boundary="===============6302399530250819792=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/4] test: Update with RequestQuickDigit API
Date: Thu, 30 Aug 2012 17:05:17 -0500
Message-ID: <503FE39D.2020505@gmail.com>
In-Reply-To: <1346160082-11077-5-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6302399530250819792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/28/2012 08:21 AM, Philippe Nunes wrote:
> ---
>   test/test-stk-menu |   37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>

Applying: test: Update with RequestQuickDigit API
/home/denkenz/ofono-master/.git/rebase-apply/patch:45: trailing whitespace.
		print "Single key press (t, b, 0-9,*,#)"
/home/denkenz/ofono-master/.git/rebase-apply/patch:53: trailing whitespace.
			print "."			=

fatal: 2 lines add whitespace errors.
Patch failed at 0001 test: Update with RequestQuickDigit API

> diff --git a/test/test-stk-menu b/test/test-stk-menu
> index a9f92e8..476d949 100755
> --- a/test/test-stk-menu
> +++ b/test/test-stk-menu
> @@ -7,6 +7,27 @@ import dbus
>   import dbus.service
>   import dbus.mainloop.glib
>
> +
> +

Why double empty line?

> +class _GetchUnix:
> +    def __init__(self):
> +        import tty, sys
> +
> +    def __call__(self):
> +        import sys, tty, termios
> +        fd =3D sys.stdin.fileno()
> +        old_settings =3D termios.tcgetattr(fd)
> +        try:
> +            tty.setraw(sys.stdin.fileno())
> +            ch =3D sys.stdin.read(1)
> +        finally:
> +            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
> +        return ch
> +
> +
> +getch =3D _GetchUnix()
> +
> +

And again?

Also, are you sure we need to go this complicated.  We already ignore =

'hide_typing' elsewhere...

>   class GoBack(dbus.DBusException):
>   	_dbus_error_name =3D "org.ofono.Error.GoBack"
>
> @@ -127,6 +148,22 @@ class StkAgent(dbus.service.Object):
>   			return key
>
>   	@dbus.service.method("org.ofono.SimToolkitAgent",
> +				in_signature=3D"sy", out_signature=3D"s")
> +	def RequestQuickDigit(self, title, icon):
> +		print "Title: (%s)" % (title)
> +		print "Icon: (%d)" % (icon)
> +		print "Single key press (t, b, 0-9,*,#)"
> +		key =3D getch();
> +
> +		if key =3D=3D 'b':
> +			raise GoBack("User wishes to go back");
> +		elif key =3D=3D 't':
> +			raise EndSession("User wishes to terminate session");
> +		else:
> +			print "."			=

> +			return key
> +
> +	@dbus.service.method("org.ofono.SimToolkitAgent",
>   				in_signature=3D"sy", out_signature=3D"b")
>   	def RequestConfirmation(self, title, icon):
>   		print "Title: (%s)" % (title)

Regards,
-Denis

--===============6302399530250819792==--

