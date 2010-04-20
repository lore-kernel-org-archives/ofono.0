Content-Type: multipart/mixed; boundary="===============2998003390451710011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Tue, 20 Apr 2010 11:20:12 -0500
Message-ID: <201004201120.13233.denkenz@gmail.com>
In-Reply-To: <87y6giqxjz.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2998003390451710011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> "Gustavo F. Padovan" <gustavo@padovan.org> writes:
> > Puting send_method_call and send_method_call_with_reply on g_dbus will
> > avoid some code duplication and will make things easier mainly for the
> > Bluetooth plugins (HFP, DUN, SAP) inside oFono.
> =

> Sorry, totally unrelated to this patch, but is there a BT DUN plugin for
> ofono available somewhere? I would love to test it.
> =


There is none yet, but it is something we're planning to implement.  But ju=
st =

to make sure we're all talking about the same thing, what DUN profile role =

(client or server?) are you actually interested in?  The oFono plugin will =
be =

for the server role, the client role will probably be a plugin in BlueZ.

Regards,
-Denis

--===============2998003390451710011==--

