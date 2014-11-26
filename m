Content-Type: multipart/mixed; boundary="===============8648951366569225467=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: [PATCH 1/2] sms: Option HSO modem can't really do CNMA
Date: Wed, 26 Nov 2014 10:37:49 +0000
Message-ID: <a1ee7c912c4bb44c2dcd8ff5aae829b3@ossau.homelinux.net>
In-Reply-To: <547378EF.8050704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8648951366569225467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've been working on SMS function with oFono.  oFono prefers to get
+CMT indications for received SMSs - which it requests by issuing
AT+CNMI=3D2,2... - instead of +CMTI indications that would be requested
by AT+CNMI=3D2,1...  But my observation is that the GTA04 modem doesn't
in fact generate +CMT indications for received SMSs (even when
instructed to do so by AT+CNMI=3D2,2...).

I can submit an oFono patch to issue AT+CNMI=3D2,1... when talking to a
GTM601, and so get +CMTI indications (which it handles fine).

Before I do that, however, can anyone confirm or deny that the GTM601
really can't do +CMT indications?

QtMoko for GTA04 issues AT+CNMI=3D2,1 and handles +CMTI indications.
FSO has a config setting named "sim_buffers_sms", and sends
AT+CNMI=3D2,1 if that setting is true, or AT+CNMI=3D2,2 if false; and the
GTA04 config has sim_buffers_sms=3Dtrue.  Is that because others have
tried using +CMT before and found it not to work?

Many thanks,
      Neil


PS. I haven't forgotten the possibility of using fsogsmd instead of
oFono.  I'm still working with oFono at the moment because I have some
application-level code that speaks to its dbus APIs.

PPS. In case anyone is surprised that I'm still working on GTA04 stuff
after recently saying that I'd finished my experimentation...  It's
because I've been remotivated by NeilBrown's kernel work, and
particularly by having a kernel that reliably plays audio.  So thanks
Neil!

PPPS. My discussion so far about this on the oFono mailing list is at
https://lists.ofono.org/pipermail/ofono/2014-November/015520.html


--===============8648951366569225467==--

