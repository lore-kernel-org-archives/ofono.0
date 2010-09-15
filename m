Content-Type: multipart/mixed; boundary="===============5672995314007161236=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Thu, 16 Sep 2010 00:27:00 +0300
Message-ID: <AANLkTimnRCYk+SYt5HuWDhUHDWmeeohjQQNpjE7AYhGu@mail.gmail.com>
In-Reply-To: <5fe7a635c2abdce7711d8a5ddff2bb66@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5672995314007161236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2010/9/15 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> Please. Don't put netlink *settings* in oFono. This kills the whole idea =
of
> having a common socket stack that can be shared by several processes. If
> you want to run against the Maemo kernel, then you have phonet-utils and
> sscd taking care of that anyway. As for the Meego kernel, it should get a
> up-to-date and patched Phonet stack as needed.

I'm all for including settings as udev rules and driving the plugins
from udev. That is the goal if and when we have up-to-date kernel, but
we are not there yet.

-- =

Pekka.Pessi mail at nokia.com

--===============5672995314007161236==--

