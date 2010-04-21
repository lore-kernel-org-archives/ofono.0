Content-Type: multipart/mixed; boundary="===============2908691847498591084=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Wed, 21 Apr 2010 09:51:58 +0300
Message-ID: <87633lti0h.fsf@potku.valot.fi>
In-Reply-To: <201004201120.13233.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2908691847498591084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

>> "Gustavo F. Padovan" <gustavo@padovan.org> writes:
>> > Puting send_method_call and send_method_call_with_reply on g_dbus will
>> > avoid some code duplication and will make things easier mainly for the
>> > Bluetooth plugins (HFP, DUN, SAP) inside oFono.
>> =

>> Sorry, totally unrelated to this patch, but is there a BT DUN plugin for
>> ofono available somewhere? I would love to test it.
>> =

>
> There is none yet, but it is something we're planning to implement.  But =
just =

> to make sure we're all talking about the same thing, what DUN profile rol=
e =

> (client or server?) are you actually interested in?

Good point, I should be more clear here. I'm talking about the client
mode.

I would like to connect my laptop to Internet through my N900 using no
cables and I think BT DUN client mode is the easiest choise here. At
least I have BT DUN already working in N900.

> The oFono plugin will be for the server role, the client role will
> probably be a plugin in BlueZ.

But who, and how, will issue the necessary AT commands and run the PPP
stack in the BT DUN client mode? Wouldn't it be easiest if ofono would
do that? (Just asking.)

A kind request to the list maintainers: please disable the reply-to
header, it just makes things difficult. I prefer to have CCs so that I
get replies to my inbox and answer quickly. This is how all kernel
mailing lists work I know of work.


-- =

Kalle Valo

--===============2908691847498591084==--

