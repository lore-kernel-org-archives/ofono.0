Content-Type: multipart/mixed; boundary="===============8783954838433954548=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/1] Add telephony_str_to_error to decode error code
Date: Wed, 12 May 2010 15:17:34 +0800
Message-ID: <1273648655-22882-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8783954838433954548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The patch is to decode error code when we meet non "OK" final result. To ge=
t the error code, I have to search the CME, CMS, CEER string tables so it's=
 really not good from performance perspective. One use case is in modem emu=
lator, it need to decode the error and report to the emulator client. So we=
 have to convert GAtResult to ofono_error and send out by g_at_server_send_=
final() or ext_final().

If you have better way to handle that, please let me know.

--===============8783954838433954548==--

