Content-Type: multipart/mixed; boundary="===============2213577835168939996=="
MIME-Version: 1.0
From: Radek Polak <psonek2@seznam.cz>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Wed, 07 Mar 2012 19:19:02 +0000
Message-ID: <201203071919.02494.psonek2@seznam.cz>
In-Reply-To: <4F5637C6.6000708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2213577835168939996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 March 2012 16:13:58 Denis Kenzior wrote:

> I pushed my own version of this patch that is a little bit more
> paranoid.  git show ebac438d for more details.

Great, thanks! It works nice:

ofonod[1217]: App: < \r\n+CLCC: 1,1,4,0,0,"+420608828973",145\r\n\r\nOK\r\n
ofonod[1217]: App: < \r\n_OSIGQ: 17,0\r\n
ofonod[1217]: src/network.c:ofono_netreg_strength_notify() strength 54
ofonod[1217]: App: > AT+CLCC\r
ofonod[1217]: App: < \r\n+CME ERROR: 100\r\n
ofonod[1217]: App: > AT+CLCC\r
ofonod[1217]: App: < \r\nOK\r\n
ofonod[1217]: src/voicecall.c:ofono_voicecall_disconnected() Got disconnect=
ion =

event for id: 1, reason: 2
ofonod[1217]: App: > AT+CLCC\r
ofonod[1217]: App: < \r\nOK\r\n

Regards

Radek

--===============2213577835168939996==--

