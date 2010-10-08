Content-Type: multipart/mixed; boundary="===============1461323634527816682=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Using ofono HFP
Date: Fri, 08 Oct 2010 11:25:49 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352DA74327@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTikeRN7CiQNxpdLh9L_EV=ZTACQGDSt7xbzizUDD@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1461323634527816682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Silva,

Moises Silva wrote:
> On Tue, Sep 28, 2010 at 10:50 PM, Denis Kenzior
> <denkenz@gmail.com> wrote:
>> The second descriptor (what ipc.c and ipc.h deal with) is used to
>> pass the SCO fd to PulseAudio or gStreamer. =C2=A0This fd is used for
>> Audio. Marcel or Johan might know better, but I think the reason for
>> ipc.c and ipc.h was that DBus did not support fd-passing at the time
>> BlueZ audio integration work was being done.
> =

> Thanks for the help.
> =

> I have a few more questions. I got my own small app connecting to the
> audio server and I am able to read/write fromt he sco socket.
> =

> However it seems the MTU is hard-coded int audio/unix.c to 48.
> =

> Where does this 48 comes from? I come from the TDM open source world,
> where typical configuration for TDM devices is 160 (160 bytes of
> alaw/ulaw, 160 samples, each 20ms).
> =

> Is there any way to change that socket MTU to 160 or 320 (depending if
> it's either SLN16 or alaw/mulaw?

You might want to raise your question on bluez's IRC or mailing list. oFono=
 takes care of call control logic while BlueZ/PulseAudio takes care of SCO =
audio packets.

> How can I know the format for the audio?

I think it should be PCM raw data from SCO packets but it could wrong maybe.

> I'll keep digging in pulseaudio to see if I find the answer ...
> =

> Moises Silva
> Senior Software Engineer
> Sangoma Technologies Inc. | 100 Renfrew Drive, Suite 100, Markham ON
> L3R 9R6 Canada t. 1 905 474 1990 x128 | e. moy(a)sangoma.com
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua


--===============1461323634527816682==--

