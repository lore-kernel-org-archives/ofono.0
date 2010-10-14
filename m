Content-Type: multipart/mixed; boundary="===============2565538116035269469=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Using ofono HFP
Date: Thu, 14 Oct 2010 15:00:20 +0300
Message-ID: <AANLkTimvwFGZdWcGCLPwEyhRmLp=0HuxpzmDkCJpGW91@mail.gmail.com>
In-Reply-To: <AANLkTi=uppgrW4-Q_ZjZU=2QqwGj7jm0kLLyqQ4SDVbq@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2565538116035269469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Moises,

2010/10/8 Moises Silva <moises.silva@gmail.com>:
> Just throwing another question in the air, what should be the best way
> to go to use Ofono DBUS API from a C program?
>
> I am trying to write the C version of ./list-modems Python script. I
> see in the D-BUS page that they don't recommend using the bare bones
> D-BUS C API but rather bindings, like glib bindings. What do you
> think? I was trying to use glib for the list-modems C port, but got
> stuck on which data type to use for the return value of the GetModems
> API.

dbus-glib is, err, challenging. Use gdlib if you can.

On the other hand, telepathy-ring has a minimal implementation of
Modem and ModemManager APIs for dbus-glib:

http://meego.gitorious.org/meego-cellular/telepathy-ring

It uses some dbus-glib types from telepathy-glib, but otherwise it is
does not depend on telepathy framework.

-- =

Pekka.Pessi mail at nokia.com

--===============2565538116035269469==--

