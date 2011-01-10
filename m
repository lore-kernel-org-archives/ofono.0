Content-Type: multipart/mixed; boundary="===============3286693124964650953=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv3 0/4] Plugin API for provisioning of GPRS context settings
Date: Mon, 10 Jan 2011 15:11:08 +0200
Message-ID: <1294665072-13630-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3286693124964650953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here is another RFC patchset about implementing automatic provisioning GPRS=
 context settings. ("Internet Access Provider database" TODO item).

This time the approach is to add a new driver/plugin API for provisioning m=
odules. Different kind of provisioning modules may be created for different=
 platforms or use cases.
It is up to the module what settings database it uses, and how many, and wh=
at type of contexts (with settings) it returns.
Several plugins may be loaded in oFono, and they will be called in priority=
 order until first plugin returns non-empty result.

Provisioning modules are called in case there are no previously configured =
contexts found during gprs atom registration.
 =

These patches add new gprs-provision.[hc] API for provisioning plugins to r=
egister into, and get_settings() for gprs.c to call when needed.
gprs.c is modified to use provisioning if reading existing context settings=
 fails.

A dummy example provisioning plugin is included. In case it is called when =
using phonesim with default.xml configuration, the plugin returns dummy set=
tings for two contexts, one type Internet and one type MMS. =


Patches also add new function ofono_sim_get_mnc_length to SIM atom API for =
figuring out MNC value (typically needed by provisioning plugins).

--Jukka Saunam=C3=A4ki


--===============3286693124964650953==--

