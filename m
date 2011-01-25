Content-Type: multipart/mixed; boundary="===============8460079976346888114=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 0/2] Long phone numbers
Date: Tue, 25 Jan 2011 11:02:36 -0300
Message-ID: <1295964158-19223-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8460079976346888114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches extends OFONO_MAX_PHONE_NUMBER_LENGTH, splits
common:valid_phone_number_format(), and adapts voicecall to valid
the 80 character limit for outgoing calls.

Rafael Ignacio Zurita (2):
  types: change OFONO_MAX_PHONE_NUMBER_LENGTH value to 80
  common: split valid_phone_number_format and adapt voicecall

 include/types.h |    2 +-
 src/common.c    |   20 ++++++++++++++++++--
 src/common.h    |    2 ++
 src/voicecall.c |    2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

-- =

1.7.2.3


--===============8460079976346888114==--

