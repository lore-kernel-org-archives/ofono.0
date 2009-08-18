Content-Type: multipart/mixed; boundary="===============1326006033864592752=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: How to hangup outgoing call, before terminating end answers?
Date: Tue, 18 Aug 2009 16:42:54 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302056E2672@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <4A892261.40504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1326006033864592752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

>The following do not work as the /modem1/voicecall01 does not exist:
>$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
>org.ofono.VoiceCall.Hangup
>Error org.freedesktop.DBus.Error.UnknownMethod: Method "Hangup" with
>signature "" on interface "org.ofono.VoiceCall" doesn't exist

It's normal if the voicecall01 didn't be setup =

>
>$ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1/voicecall01
>org.ofono.VoiceCall.Busy
>Error org.freedesktop.DBus.Error.UnknownMethod: Method "Busy" with
>signature "" on interface "org.ofono.VoiceCall" doesn't exist
>
Busy only for waiting and incoming call

>
>The VoiceCallManager.HangupAll does not work either:
>$ dbus-send --print-reply --system --dest=3Dorg.ofono /modem1
>org.ofono.VoiceCallManager.HangupAll
>Error org.ofono.Error.InProgress: Operation already in progress

It should be a bug if you use real modem

In phonesim the outgoing call be accepted quickly so can't find this issue.

I had same problem with a "phone" in real network; I assume its phone limit=
ation before.

>
>
>Regards,
>Marko
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============1326006033864592752==--

