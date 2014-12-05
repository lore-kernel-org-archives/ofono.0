Content-Type: multipart/mixed; boundary="===============6291169654929856599=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/4] Add ModemTechnologies property to RadioSettings
Date: Fri, 05 Dec 2014 17:46:27 +0100
Message-ID: <1417797991-19700-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6291169654929856599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series add the ModemTechnologies property to the
RadioSettings interface. Its purpose is to show the list of valid
values for the TechnologyPreference property in the same interface.
The use case is letting a UI show the possible RATs so the user cannot
select an invalid value for a given modem.

Alfonso Sanchez-Beato (4):
  doc: Add ModemTechnologies property
  include: Add method to list RATs to radio-settings
  src: Implement RAT list property
  test: Add ModemTechnologies to list-modems

 doc/radio-settings-api.txt |  5 ++++
 include/radio-settings.h   | 11 +++++++++
 src/radio-settings.c       | 61 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 test/list-modems           |  3 ++-
 4 files changed, 78 insertions(+), 2 deletions(-)

-- =

2.1.0


--===============6291169654929856599==--

