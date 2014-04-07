Content-Type: multipart/mixed; boundary="===============3131634297655588191=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Basic blocks for control channel.
Date: Mon, 07 Apr 2014 09:02:41 -0500
Message-ID: <5342B001.309@gmail.com>
In-Reply-To: <1396871748-10062-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3131634297655588191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 04/07/2014 06:55 AM, jussi.pakkanen(a)canonical.com wrote:
> Hello
> =

> Here's a revised way of changing phonesim modem configurations at
> runtime. It works by adding a dbus interface via which you can add new
> modems, delete all existing modems or reset modem status to what it
> was at startup. This first patch adds the dbus bits and the second one
> calls the corresponding ofono functions.
> =

> This patch set is not fully polished yet but should give an idea what
> we are aiming for. I'm not fully versed in phonesim's internals so I'm
> not sure if I'm poking all the right bits in the dbus functions, so
> please verify that with extra care.
> =

> Thanks,
> =

> ---
>  plugins/phonesim.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 58 insertions(+)
> =


As I've said before, this is overkill.  It makes the phonesim plugin way
more complicated that it needs to be.  A .conf parser with over-ridable
directories, a control channel with add/remove/reset? Seriously?

UI should be designed to ignore non-powered modems, and only look for
interfaces that it handles specifically.  So for a properly designed UI,
none of these changes are required.  If you want to handle DualSim
cleanly, then feel free to propose a mechanism / hint that makes
applications aware of the fact that two modems belong to a group.

If the above cannot be done, then please write a plugin to address your
specific use case.

Regards,
-Denis


--===============3131634297655588191==--

