Content-Type: multipart/mixed; boundary="===============5376050786635493367=="
MIME-Version: 1.0
From: Meul, Dirk <Dirk.Meul@p3-group.com>
Subject: Sierra using QMI with linux-3.18.5 and oFono-1.16 possible?
Date: Fri, 10 Apr 2015 08:04:15 +0000
Message-ID: <7D96BC0695F191498AA0147D723146AF5691319D@Ulm2-Exc1-MB1.p3-group.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5376050786635493367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi list,

I'm trying to use a Sierra MC7304 datacard in QMI mode with oFono-1.16 runn=
ing on ARM with linux-3.18.5 kernel.

1) Without modifications the MC7304 uses qmi-wwan and option drivers and is=
 not recognized by oFono
2) After adding the product ID to the sierra module the datacard is recogni=
zed and useable, but not in QMI mode
3) With different product ID qmi-wwan and qcserial drivers are used but sti=
ll not recognizes by oFono
4) Patched oFono-1.16 following "improving QMI support on recent kernels" p=
atch set from February 2013 by Bj=C3=B8rn Mork, no working interface, neith=
er with patched sierra nor with qmi-wwan/qcserial

As the QMI interface /dev/cdc-wdmX now is in usbmisc interface and the patc=
h set <https://lists.ofono.org/pipermail/ofono/2013-February/014240.html> w=
asn't merged I wonder if somebody is able to use QMI mode with recent kerne=
ls.

So my question: is it possible to use the QMI mode on recent kernel with cu=
rrent oFono? Are there other patches needed I didn't found?

Best Regards,
Dirk



--

Dirk Meul
P3 communications

Cell:          +49 151 571 33 167
Phone:    +49 241 9437 230
E-Mail:    Dirk.Meul(a)p3-group.com
Web:       www.p3-group.com
P3 communications GmbH
legal disclaimer, mandatory information and the P3 office addresses can be =
found at
www.p3-group.com/communications/email-information



--===============5376050786635493367==--

