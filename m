Content-Type: multipart/mixed; boundary="===============1401846179967515639=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH] Correct cnum changes
Date: Tue, 22 Apr 2014 16:22:39 +0100
Message-ID: <1398180160-14584-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1401846179967515639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

With one of the corrections there is now a crash which occurs when formatti=
ng
the properties for the handsfree interface. I have reverted one of the
changes in the attached patch so the problem is fixed. I have followed the
same convention as other interface such as gprs.

Thanks,

Andrew


Andrew Earl (1):
  handsfree: correct crash on connect of hfp

 src/handsfree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- =

1.7.11.7


--===============1401846179967515639==--

