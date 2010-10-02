Content-Type: multipart/mixed; boundary="===============0065120293765628553=="
MIME-Version: 1.0
From: Moises Silva <moises.silva@gmail.com>
Subject: Re: Using ofono HFP
Date: Sat, 02 Oct 2010 18:27:02 -0400
Message-ID: <AANLkTikeRN7CiQNxpdLh9L_EV=ZTACQGDSt7xbzizUDD@mail.gmail.com>
In-Reply-To: <4CA2A984.4030208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0065120293765628553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 10:50 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> The second descriptor (what ipc.c and ipc.h deal with) is used to pass
> the SCO fd to PulseAudio or gStreamer. =C2=A0This fd is used for Audio.
> Marcel or Johan might know better, but I think the reason for ipc.c and
> ipc.h was that DBus did not support fd-passing at the time BlueZ audio
> integration work was being done.

Thanks for the help.

I have a few more questions. I got my own small app connecting to the
audio server and I am able to read/write fromt he sco socket.

However it seems the MTU is hard-coded int audio/unix.c to 48.

Where does this 48 comes from? I come from the TDM open source world,
where typical configuration for TDM devices is 160 (160 bytes of
alaw/ulaw, 160 samples, each 20ms).

Is there any way to change that socket MTU to 160 or 320 (depending if
it's either SLN16 or alaw/mulaw?

How can I know the format for the audio?

I'll keep digging in pulseaudio to see if I find the answer ...

Moises Silva
Senior Software Engineer
Sangoma Technologies Inc. | 100 Renfrew Drive, Suite 100, Markham ON
L3R 9R6 Canada
t. 1 905 474 1990 x128 | e. moy(a)sangoma.com

--===============0065120293765628553==--

