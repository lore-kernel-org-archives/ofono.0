Content-Type: multipart/mixed; boundary="===============0742556593346322041=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: isigen: enabled multiple PDP contexts
Date: Thu, 11 Nov 2010 12:00:47 +0200
Message-ID: <1289469648-18472-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0742556593346322041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the patch to enable multiple PDP contexts in isigen.
Turns out that probing the context count is not feasible,
so we just default to four.

   MikaL

[PATCH 1/1] isigen: create four gprs contexts

 plugins/isigen.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

--===============0742556593346322041==--

