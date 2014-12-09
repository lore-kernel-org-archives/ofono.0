Content-Type: multipart/mixed; boundary="===============4594375786843291048=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/4] Add AvailableTechnologies property to RadioSettings
Date: Tue, 09 Dec 2014 13:34:35 +0100
Message-ID: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4594375786843291048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series add the AvailableTechnologies property to the
RadioSettings interface. Its purpose is to show the list of valid
values for the TechnologyPreference property in the same interface.
The use case is letting a UI show the possible RATs so the user cannot
select an invalid value for a given modem.

Alfonso Sanchez-Beato (4):
  doc: Add AvailableTechnologies property
  include: Add method to list RATs to radio-settings
  src: Implement RAT list property
  test: Add AvailableTechnologies to list-modems

 doc/radio-settings-api.txt |  5 +++++
 include/radio-settings.h   | 15 +++++++++++++++
 src/radio-settings.c       | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 test/list-modems           |  3 ++-
 4 files changed, 68 insertions(+), 2 deletions(-)

-- =

2.1.0


--===============4594375786843291048==--

