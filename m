Content-Type: multipart/mixed; boundary="===============4871371311123561027=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [RFC PATCH 0/3] Long phone numbers
Date: Mon, 17 Jan 2011 11:59:25 -0300
Message-ID: <1295276368-32233-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4871371311123561027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a proposal for the "long phone number" task (80 digits max length).
It changes OFONO_MAX_PHONE_NUMBER_LENGTH and splits
common:valid_phone_number_format(), to make sure long numbers are handled
appropriately for functions that need manage shorter numbers, like
numbers written to the SIM, or sms SCA.

Rafael Ignacio Zurita (3):
  types: change OFONO_MAX_PHONE_NUMBER_LENGTH value to 80
  common: split valid_phone_number_format and adapt atoms
  smart-messaging: Adapt to use new number format validation function

 include/types.h           |    2 +-
 plugins/smart-messaging.c |    4 ++--
 src/call-forwarding.c     |    4 ++++
 src/common.c              |   20 ++++++++++++++++++--
 src/common.h              |    2 ++
 src/message-waiting.c     |   14 ++++++++++++++
 src/sim.c                 |    2 +-
 src/sms.c                 |    5 +++--
 8 files changed, 45 insertions(+), 8 deletions(-)

-- =

1.7.2.3


--===============4871371311123561027==--

