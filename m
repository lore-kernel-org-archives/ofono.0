Content-Type: multipart/mixed; boundary="===============1967082548347283221=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC PATCH 0/3] radio-settings: add frequency band selection
Date: Wed, 01 Dec 2010 10:10:16 -0200
Message-ID: <1291205419-2659-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1967082548347283221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series add frequency band selection feature in radio settings. The API
separates the GSM from the UMTS bands, although this is the same "property"=
 in
modem I know to have this feature (huawei). The idea here is to be able to =
set
the frequency and it will be applied by the driver only when it actually ma=
kes
sense according to the mode selected.

So, we just pass both GSM and UMTS bands to the driver that has to choose t=
he
right time to send the commands to the modem.

According to http://en.wikipedia.org/wiki/GSM_frequency_bands and
http://en.wikipedia.org/wiki/UMTS_frequency_bands, GSM and UMTS can use 14
bands each. However, very few are actually used in today modems, so I've ju=
st
added the important ones. Once new bands are used, it'll be very easy to ex=
tend
radio-settigs to cope with them.

I plan to support frequency band selection in huawei modem, once this series
and the previous one about adding radio-settings atom to huawei are accepte=
d.

Lucas De Marchi (3):
  radio-settings: add frequency band selection methods
  radio-settings: add frequency band selection properties
  doc: document frequency band selection

 doc/radio-settings-api.txt |   43 ++++++++
 include/radio-settings.h   |   33 ++++++
 src/radio-settings.c       |  250 ++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 324 insertions(+), 2 deletions(-)

-- =

1.7.3.2


--===============1967082548347283221==--

