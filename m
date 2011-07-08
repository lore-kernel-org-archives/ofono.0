Content-Type: multipart/mixed; boundary="===============6876287816671726168=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [RFC 0/1] GPRS Provisioning Plugin
Date: Fri, 08 Jul 2011 14:33:13 +0300
Message-ID: <1310124794-7880-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6876287816671726168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the draft of the GPRS provisioning plugin ("Internet Access Pro=
vider database" TODO item).

The plugin reads mobile provider settings database entries (PROVIDER_DATABA=
SE) and returns GRPS context settings to oFono provisioning module.

If there are multiple matches found in the database, then some user interve=
ntion might be required or database format should be extended, please comme=
nt.

Regards,
Oleg

Oleg Zhurakivskyy (1):
  GPRS Provisioning Plugin.

 plugins/gprs-provision.c |  290 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 plugins/gprs-provision.c

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki =

Business Identity Code: 0357606 - 4 =

Domiciled in Helsinki =


This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6876287816671726168==--

