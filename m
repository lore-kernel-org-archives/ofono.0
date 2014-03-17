Content-Type: multipart/mixed; boundary="===============3087750039991945745=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 0/5] hfp: Extend Handsfree Features to three way calling and
 CHLD properties
Date: Mon, 17 Mar 2014 16:47:25 +0100
Message-ID: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3087750039991945745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

The aim is to provide the UI with more information about the audio gateway
features for HFP. This will allow the UI to be customised so that unavailab=
le
features are not offered rather than receiving an error message when action=
ed.


Krzysztof Wilk (5):
  doc: Extend Features property
  hfp: Define hfp_ag_chld_feature
  include: Declaration function to set CHLD features
  hfp: Add CHLD features to drver data
  hfp: extend Features to three way calling and CHLD

 doc/handsfree-api.txt        |  6 ++++++
 drivers/hfpmodem/handsfree.c |  3 +++
 include/handsfree.h          |  2 ++
 src/handsfree.c              | 34 +++++++++++++++++++++++++++++++---
 src/hfp.h                    | 11 +++++++++++
 5 files changed, 53 insertions(+), 3 deletions(-)

-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============3087750039991945745==--

