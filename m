Content-Type: multipart/mixed; boundary="===============3892124312341432818=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [RFC 0/2] Add hardware monitor interface to gemalto plugin
Date: Thu, 11 May 2017 16:48:11 +0200
Message-ID: <1494514093-28167-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3892124312341432818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto Cinterion P-family modems expose hardware related commands to monit=
or
temperature and voltage. The following patches add a custom interface in
Gemalto plugin. =


Implementation is based on ril_intel and smart-messaging plugins for DBus
interface creation and callback handling. Create DBus interface =

org.ofono.HardwareMonitor with two methods GetTemperature and GetVoltage.

First patch registers the DBus interface and create the DBus method table.
Second patch implements the DBus methods with AT command calls and DBus
message handling.

Vincent Cesson (2):
  gemalto: Prepare new interface for hardware monitoring
  gemalto: Implement HardwareMonitor methods

 plugins/gemalto.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 194 insertions(+)

-- =

1.9.1


--===============3892124312341432818==--

