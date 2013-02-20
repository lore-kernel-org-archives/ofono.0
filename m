Content-Type: multipart/mixed; boundary="===============5534346454167274964=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 0/7] Initial support for Handsfree Audio Manager
Date: Wed, 20 Feb 2013 18:55:44 -0300
Message-ID: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5534346454167274964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patches implement the initial functionality of the experiment=
al
Handsfree Audio Manager interface defined in doc/handsfree-audio-api.txt

This series adds the Register and Unregister methods.

Changess between v0-v1:
* removed multiple agents support
* removed experimental command line option
* moved Handsfree Audio Manager to src/

Claudio Takahasi (6):
  handsfree-audio: Add Manager registration
  handsfree-audio: Add Agent "Register" method
  handsfree-audio: Free agent when exiting
  handsfree-audio: Call Agent "Release" when exiting
  handsfree-audio: Add Agent "Unregister"
  handsfree-audio: Add Agent tracking

Vinicius Costa Gomes (1):
  handsfree-audio: Add codec array validation

 Makefile.am           |   3 +-
 src/handsfree-audio.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/main.c            |   4 ++
 src/ofono.h           |   3 +
 4 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 src/handsfree-audio.c

-- =

1.7.11.7


--===============5534346454167274964==--

