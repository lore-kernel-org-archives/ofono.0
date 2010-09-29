Content-Type: multipart/mixed; boundary="===============8343005219471698812=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Using ofono HFP
Date: Wed, 29 Sep 2010 10:44:46 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352D956D0A@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTin6yP6y+TPgbrMeQ=2QnKKkpLy8-eSGTb3LZDOf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8343005219471698812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Silva,

Moises Silva wrote:
> On Mon, Sep 27, 2010 at 9:26 PM, Zhang, Zhenhua
> <zhenhua.zhang@intel.com> wrote:
>> =

>> Right. See bluez/audio/unix.c for BlueZ part SCO code that
> cooperate with pulseaudio. BlueZ sends SCO fd to pulseaudio via UNIX
>> type socks.
> =

> This put me in the right direction and I have a clearer idea of how to
> do it. I found odd though that it seems I need to copy the ipc.c and
> ipc.h files into my own app. Any reason they are not part of
> libbluetooth API? =


Marcel may know the answer for your question.

> Another thing that puzzles me is that supposedly DBUS >=3D 1.3 is needed
> to be able to pass file descriptors. However as you pointed out and
> per ipc.c the file descriptor is sent using a unix socket. Why the
> need for DBUS file descriptor passing?

DBUS file descriptor passing is used in BlueZ/oFono communication, to pass =
RFCOMM port file handler to another process. I guess dbus 1.3 has some wrap=
per for such file descriptor passing magic.

Marcel, any comments on Silva's question?

> I'm gonna start testing right away and most likely will be back with
> more questions (like what's the audio format, sampling rate and such)
> :-) =

> =

> Thanks,
> =

> --
> Moises Silva
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============8343005219471698812==--

