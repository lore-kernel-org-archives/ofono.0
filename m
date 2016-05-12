Content-Type: multipart/mixed; boundary="===============6146394982696374071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Thu, 12 May 2016 09:09:49 -0500
Message-ID: <57348EAD.4030606@gmail.com>
In-Reply-To: <57345D06.7020303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6146394982696374071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On 05/12/2016 05:37 AM, Marco Trapanese wrote:
>
> Hello,
> when I start pulseaudio I get this error:
>
>> org.freedesktop.DBus.Error.UnknownMethod: Method "Register" with
>> signature "oay" on interface "org.ofono.HandsfreeAudioManager" doesn't
>> exist
>

Are you running BlueZ 5 on your system?  This interface is only =

available if BlueZ5 support has been enabled.  E.g. =

plugins/hfp_ag_bluez5.c or plugins/hfp_hf_bluez5.c

> I'm running ofono 1.17 and pulseaudio 8.0.
> Please, would you help me to understand if the problem is related to the
> compilation of ofono or to the dbus policies?

If you installed the ofono.conf from ofono.git/src/ofono.conf in the =

right place, then it shouldn't be a D-Bus policy issue.

Regards,
-Denis

--===============6146394982696374071==--

