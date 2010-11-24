Content-Type: multipart/mixed; boundary="===============6597541095459952839=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Property signal fix for data and fax call forwarding
Date: Wed, 24 Nov 2010 01:57:32 -0800
Message-ID: <1290592653-21828-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6597541095459952839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

 Data and Fax call forwarding is not supported in oFono. Currently, oFono t=
riggers the property change only for voice call even when the Data/Fax call=
 forwarding is active.
In one particular case, the Data and Fax property change gets triggered. Th=
is patch handles that particular case as well.

Regards,
Jeevaka

--===============6597541095459952839==--

