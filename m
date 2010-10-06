Content-Type: multipart/mixed; boundary="===============3178372006345628709=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 2/2] n900: Enable audio settings atom
Date: Wed, 06 Oct 2010 16:30:17 +0200
Message-ID: <725063E4C37388418CDDC5A2C287906A1F65287B15@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1285938256-6423-3-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3178372006345628709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 01 Oct 2010, Kai Vehmanen wrote:
>Subject: [PATCH 2/2] n900: Enable audio settings atom
> plugins/n900.c |    2 ++

FYI, I've now added a minimal test/example application, cmtspeech_test_ofon=
o, =

to upstream libcmtspeechdata repository [1]. The app uses oFono (and the new
audio settings atom) to set up the speech data path on e.g. Nokia N900
(currently libcmtspeechdata only supports the N900 modem speech
interface, but the door is open to support other modems as well).

In short, you run this app, make a call with oFono, and once the =

call is up, the test app simply loops back any audio from
downlink to uplink (so the remote party will get its uplink
audio routed back).

The app is at:
http://meego.gitorious.org/meego-cellular/libcmtspeechdata/blobs/master/uti=
ls/cmtspeech_ofono_test.c

This might be useful if you want to test/develop oFono on
N900, and/or for developing speech path support to other modems (either
with libcmtspeechdata or with some other kernel/lib adaptation).

PS On N900, you need to stop pulseaudio before testing as access to =

   the speech path kernel driver is exclusive.

[1] http://gitorious.org/+meego-cellular/meego-cellular/libcmtspeechdata

Br,
-- =

Kai Vehmanen


--===============3178372006345628709==--

