Content-Type: multipart/mixed; boundary="===============9173877199455248804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using ofono HFP
Date: Tue, 28 Sep 2010 21:50:44 -0500
Message-ID: <4CA2A984.4030208@gmail.com>
In-Reply-To: <AANLkTin6yP6y+TPgbrMeQ=2QnKKkpLy8-eSGTb3LZDOf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9173877199455248804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Moises,

On 09/28/2010 09:33 PM, Moises Silva wrote:
> On Mon, Sep 27, 2010 at 9:26 PM, Zhang, Zhenhua <zhenhua.zhang@intel.co=
m> wrote:
>>
>> Right. See bluez/audio/unix.c for BlueZ part SCO code that cooperate wit=
h pulseaudio. BlueZ sends SCO fd to pulseaudio via UNIX
>> type socks.
> =

> This put me in the right direction and I have a clearer idea of how to
> do it. I found odd though that it seems I need to copy the ipc.c and
> ipc.h files into my own app. Any reason they are not part of
> libbluetooth API?
> =

> Another thing that puzzles me is that supposedly DBUS >=3D 1.3 is needed
> to be able to pass file descriptors. However as you pointed out and
> per ipc.c the file descriptor is sent using a unix socket. Why the
> need for DBUS file descriptor passing?
> =


There are two descriptors involved here.  DBus 1.3 is needed to have
BlueZ pass the RFCOMM file descriptor to oFono for the control socket.
E.g. the socket where AT commands are being passed.  This is done by
using HandsfreeGateway and HandsfreeAgent.  See doc/hfp-api.txt in BlueZ.

The second descriptor (what ipc.c and ipc.h deal with) is used to pass
the SCO fd to PulseAudio or gStreamer.  This fd is used for Audio.
Marcel or Johan might know better, but I think the reason for ipc.c and
ipc.h was that DBus did not support fd-passing at the time BlueZ audio
integration work was being done.

Regards,
-Denis

--===============9173877199455248804==--

