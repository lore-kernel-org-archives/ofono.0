Content-Type: multipart/mixed; boundary="===============3302035706327468217=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] test: test-sms test script added
Date: Wed, 02 Feb 2011 09:37:00 -0200
Message-ID: <AANLkTi=8v6M0d-RXa5nJrgjr8SqsZhY-ZVq0A+ks-8ft@mail.gmail.com>
In-Reply-To: <1296643481-2516-1-git-send-email-konrad.slowinski@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3302035706327468217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Konrad

On Wed, Feb 2, 2011 at 8:44 AM, Konrad Slowinski
<konrad.slowinski@tieto.com> wrote:
> ---
> =C2=A0Makefile.am =C2=A0 | =C2=A0 =C2=A03 +-
> =C2=A0test/test-sms | =C2=A0213 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A02 files changed, 215 insertions(+), 1 deletions(-)
> =C2=A0create mode 100755 test/test-sms

It's good to have scripts like this one, but take a look on comment below.

> +if __name__ =3D=3D "__main__":
> +       dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +       bus =3D dbus.SystemBus()
> +       manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +                                                       'org.ofono.Manage=
r')

<snip>

> +       while in_key !=3D 'x':
> +               in_key =3D raw_input('Select any option: ')

<snip>

> +               clear_screen()
> +               print_sms_properties(sms)
> +               print_menu()
> +
> +       mainloop =3D gobject.MainLoop()
> +       mainloop.run()


Here you have an "input mainloop" where you choose all the operations
and after you start the glib mainloop, in which you receive all the
signal outputs. I think it'd be better to have input and signal
outputs together. This would be accomplished by adding a
io_add_watch() like test-ussd script does and put your "input
mainloop" inside the handler.


regards,

Lucas De Marchi

--===============3302035706327468217==--

