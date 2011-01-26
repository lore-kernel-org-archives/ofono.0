Content-Type: multipart/mixed; boundary="===============5757519963793003750=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [gprs-provision PATCHv7 0/5] Plugin API for provisioning of GPRS
 context settings
Date: Wed, 26 Jan 2011 14:34:10 +0200
Message-ID: <1296045255-29890-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5757519963793003750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

And again a patchset about automatic provisioning of GPRS context settings.

Since the safe reading of EF-SPN turned out to be impossible until general =
solution is implemented, I must temporary give up my insistence on it.

So the following provisioning driver API must be considered as provisional. =

When proper solution for SPN comes up, we should redesign the API. Without =
SPN, correct settings cannot be provisioned for all service providers, but =
at least for now most cases should work with just the MCC and MNC values pr=
ovided with this API.


--Jukka


--===============5757519963793003750==--

