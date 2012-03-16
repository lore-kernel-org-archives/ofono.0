Content-Type: multipart/mixed; boundary="===============3874368077374921746=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: Handling AT command with no response
Date: Fri, 16 Mar 2012 21:16:25 +0000
Message-ID: <87vcm4b61i.fsf@neil-laptop.ossau.uklinux.net>
In-Reply-To: <87zkbgb66n.fsf@neil-laptop.ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3874368077374921746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Neil Jerram <neil@ossau.homelinux.net> writes:

> Hi there,
>
> Is there a way in oFono of sending an AT command and not waiting for any
> response?
>
> Specifically, AT+VTS doesn't give any response according to 27.007, and
> this appears to be true in practice for the Option HSO modem (GTM601).
>
> Thanks,
>         Neil

Here's the relevant log:

Mar 16 19:55:51 gta04 daemon.info ofonod[1102]: App: < \r\n+CLCC: 1,0,0,0,0=
,"02083627267",129\r\n\r\nOK\r\n
Mar 16 19:55:52 gta04 daemon.info ofonod[1102]: App: > AT+CLCC\r
Mar 16 19:55:52 gta04 daemon.info ofonod[1102]: App: < \r\n+CLCC: 1,0,0,0,0=
,"02083627267",129\r\n\r\nOK\r\n
Mar 16 19:55:52 gta04 daemon.info ofonod[1102]: App: > AT+VTS=3D2\r
Mar 16 19:56:00 gta04 daemon.debug connmand[1098]: src/rtnl.c:rtnl_message(=
) buf 0xbecd99dc len 128
Mar 16 19:56:00 gta04 daemon.debug connmand[1098]: src/rtnl.c:rtnl_message(=
) NEWROUTE len 128 type 24 flags 0x0000 seq 0
Mar 16 19:56:24 gta04 daemon.info ofonod[1102]: App: < \r\nNO CARRIER\r\n\r=
\n_OSIGQ: 13,0\r\n
Mar 16 19:56:24 gta04 daemon.debug ofonod[1102]: src/voicecall.c:tone_reque=
st_cb() command failed with error: Unknown error type
Mar 16 19:56:24 gta04 daemon.debug ofonod[1102]: src/network.c:ofono_netreg=
_strength_notify() strength 41

i.e. tone_request_cb is only called when the call ends.

--===============3874368077374921746==--

