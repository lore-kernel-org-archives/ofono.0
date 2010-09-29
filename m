Content-Type: multipart/mixed; boundary="===============7952925488077074569=="
MIME-Version: 1.0
From: Moises Silva <moises.silva@gmail.com>
Subject: Re: Using ofono HFP
Date: Tue, 28 Sep 2010 22:33:49 -0400
Message-ID: <AANLkTin6yP6y+TPgbrMeQ=2QnKKkpLy8-eSGTb3LZDOf@mail.gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B352D8D7DC7@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7952925488077074569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 9:26 PM, Zhang, Zhenhua <zhenhua.zhang@intel.com>=
 wrote:
>
> Right. See bluez/audio/unix.c for BlueZ part SCO code that cooperate with=
 pulseaudio. BlueZ sends SCO fd to pulseaudio via UNIX
> type socks.

This put me in the right direction and I have a clearer idea of how to
do it. I found odd though that it seems I need to copy the ipc.c and
ipc.h files into my own app. Any reason they are not part of
libbluetooth API?

Another thing that puzzles me is that supposedly DBUS >=3D 1.3 is needed
to be able to pass file descriptors. However as you pointed out and
per ipc.c the file descriptor is sent using a unix socket. Why the
need for DBUS file descriptor passing?

I'm gonna start testing right away and most likely will be back with
more questions (like what's the audio format, sampling rate and such)
:-)

Thanks,

--
Moises Silva

--===============7952925488077074569==--

