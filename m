Content-Type: multipart/mixed; boundary="===============8130125112893783606=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: message history
Date: Wed, 20 Jan 2010 17:25:58 +0800
Message-ID: <8B81FACE836F9248894A7844CC0BA8141C45849867@shzsmsx501.ccr.corp.intel.com>
In-Reply-To: <9a7f90291001200054r8c0f22ane6c5f34ab0ed085@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8130125112893783606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Feifei,

You can see ofono/plugins/example_history.c for getting history. You can cu=
stomize your own plugin to record the sms/voicecall history into file or da=
tabase as you want. You can "export OFONO_AT_DEBUG=3D1; ofono/src/ofonod -n=
d" to see oFono debug log.

Regards,
Zhenhua
________________________________

From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Feifei Hu
Sent: Wednesday, January 20, 2010 4:55 PM
To: ofono(a)ofono.org
Subject: message history


  I have installed ofono and phonesim , with which I tried sms-send ,but
   how can I get message history?
      Are there any python scripts or dbus APIs?
     Thanks!
                                         Best Regards,
   Feifei=20

--===============8130125112893783606==--

