Content-Type: multipart/mixed; boundary="===============8215608075287256186=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Thu, 16 Sep 2010 00:00:50 +0200
Message-ID: <44275fc19e27d37f9bebdc6657d9b44a@chewa.net>
In-Reply-To: <AANLkTimnRCYk+SYt5HuWDhUHDWmeeohjQQNpjE7AYhGu@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8215608075287256186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Sep 2010 00:27:00 +0300, Pekka Pessi <ppessi@gmail.com> wrote:
> 2010/9/15 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
>> Please. Don't put netlink *settings* in oFono. This kills the whole idea
>> of having a common socket stack that can be shared by several processes.
>> If you want to run against the Maemo kernel, then you have phonet-utils
>> and sscd taking care of that anyway. As for the Meego kernel, it should
>> get a up-to-date and patched Phonet stack as needed.
> =

> I'm all for including settings as udev rules and driving the plugins
> from udev.

Right.

> That is the goal if and when we have up-to-date kernel, but
> we are not there yet.

I don't see the point of adding temporary cruft to the main oFono
repository then.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============8215608075287256186==--

