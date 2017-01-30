Content-Type: multipart/mixed; boundary="===============8170373850788900891=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: Telit modem plugins.
Date: Mon, 30 Jan 2017 14:02:44 +0100
Message-ID: <a64abdef-9c38-440b-5932-7cee53b67560@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8170373850788900891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.
Seems my rename of he910 plugin to xe910 was a little bit optimistic.
Looks like not only xE910 family modems use 1bc7:0021 USB IDs.

I got my hands on UE866 and it has the same default composition.
So this is another family, designed for embedded M2M/IoT applications
with different module form-factor, but having similar members (GE866 2G,
UE866 3.5G, LE866 4G)
And according to documentation UL865 should share the same USB IDs.
And as UL865 is an UMTS enabled, pin-compatible upgrade to GL865-DUAl V3
I would expect the latter will also have the same composition.
I could not find a definitive source of information on this.

So it seems the plugin needs a different name, again.
There is already "telit" plugin but this one supports modems based on
"option" serial ports and USB PIDs starting from 0x1003, this includes
CE/DE/LE910 (LE910 V1 that is, using QMI, which is end-of-life),
HE/LE920 and LE922/LE940A6.

Do you have any suggestions on the new name for this plugin?
I would go for something like "telit-acm" (cause it uses CDC-ACM serial
ports).

Best
Piotr

--===============8170373850788900891==--

