Content-Type: multipart/mixed; boundary="===============2978381614463973098=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: qmimodems: netreg properties CellId and LocationAreaCode sometimes
 not present
Date: Thu, 20 Jun 2019 12:18:00 +0200
Message-ID: <90def1f1-71ec-6c2a-c15d-d4308a418fe8@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2978381614463973098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

With qmi modems I am using (quectel EG25, sierra MC7304), sometimes I
don't have CellId and LocationAreaCode properties in netreg properties
while I am registered. Example:

root(a)klk-wiis-020001:~ # dbus-send --system --type=3Dmethod_call
--print-reply --dest=3Dorg.ofono /quectelqmi_0
org.ofono.NetworkRegistration.GetProperties
method return time=3D1561022820.781396 sender=3D:1.8 -> destination=3D:1.25
serial=3D96 reply_serial=3D2
=C2=A0=C2=A0 array [
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "Status"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "registered"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "Mode"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "auto"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "Technology"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "lte"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "MobileCountryCode"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "208"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "MobileNetworkCode"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "10"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "Name"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "SFR"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dict entry(
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string "Strength"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variant=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byte 40
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0 ]


CellId and LocationAreaCode come from Current serving system info
indication in QMI protocol. These indications contains many parameters
and most of them are optional. What's happening here is:

=C2=A0- first serving system info indication indicates modem is registered,
gives CellId and LAC

=C2=A0- another serving system info indication indicates modem is
registered,and give no information on CellId and LAC


When the second indication is processed, ofono_netreg_status_notify is
called with lac and cellid equal to -1. As a consequence, corresponding
NetworkRegistration properties are removed.


Here are traces from ofono when problem occurs:

2019-06-20T09:22:43.709727+00:00 klk-wiis-020001 ofonod[736]: oFono
version 1.24
2019-06-20T09:22:45.683101+00:00 klk-wiis-020001 ofonod[736]:
ofono_sim_register /quectelqmi_0 isPresent:0
2019-06-20T09:22:45.684212+00:00 klk-wiis-020001 ofonod[736]:
sim_inserted_update modem /quectelqmi_0 isPresent:1
2019-06-20T09:22:45.685682+00:00 klk-wiis-020001 ofonod[736]: Interface
org.ofono.AllowedAccessPoints not found on the interface_list
2019-06-20T09:22:45.778324+00:00 klk-wiis-020001 ofonod[736]: Requested
file structure differs from SIM: 6fb7
2019-06-20T09:22:46.258948+00:00 klk-wiis-020001 ofonod[736]:
sim_inserted_update modem /quectelqmi_0 isPresent:0
2019-06-20T09:22:46.260482+00:00 klk-wiis-020001 ofonod[736]: Interface
org.ofono.AllowedAccessPoints not found on the interface_list
2019-06-20T09:22:46.898106+00:00 klk-wiis-020001 ofonod[736]:
sim_inserted_update modem /quectelqmi_0 isPresent:1
2019-06-20T09:22:46.899788+00:00 klk-wiis-020001 ofonod[736]: Interface
org.ofono.AllowedAccessPoints not found on the interface_list
2019-06-20T09:22:47.155130+00:00 klk-wiis-020001 ofonod[736]: Requested
file structure differs from SIM: 6fb7
2019-06-20T09:22:48.626979+00:00 klk-wiis-020001 ofonod[736]: Unable to
read waiting messages numbers from SIM
2019-06-20T09:22:48.818950+00:00 klk-wiis-020001 ofonod[736]: Unable to
read mailbox identifies from SIM
2019-06-20T09:22:48.915000+00:00 klk-wiis-020001 ofonod[736]:
ofono_netreg_status_notify modem /quectelqmi_0 status 2 lac -1 cellid -1
tech -1
2019-06-20T09:22:48.947207+00:00 klk-wiis-020001 ofonod[736]:
ofono_gprs_status_notify modem /quectelqmi_0 status 0
2019-06-20T09:22:49.010982+00:00 klk-wiis-020001 ofonod[736]:
ofono_netreg_status_notify modem /quectelqmi_0 status 2 lac -1 cellid -1
tech 7
2019-06-20T09:22:49.714986+00:00 klk-wiis-020001 ofonod[736]:
ofono_netreg_status_notify modem /quectelqmi_0 status 1 lac 65534 cellid
1076227 tech 7
2019-06-20T09:22:49.717442+00:00 klk-wiis-020001 ofonod[736]: CRO
set_registration_cellid netreg->cellid: -1 ci: 1076227
2019-06-20T09:22:49.721963+00:00 klk-wiis-020001 ofonod[736]:
ofono_gprs_status_notify modem /quectelqmi_0 status 1
2019-06-20T09:22:49.724312+00:00 klk-wiis-020001 ofonod[736]: CRO
network_get_properties netreg->cellid: 1076227
2019-06-20T09:22:49.779005+00:00 klk-wiis-020001 ofonod[736]:
ofono_netreg_status_notify modem /quectelqmi_0 status 1 lac -1 cellid -1
tech 7
2019-06-20T09:22:49.779508+00:00 klk-wiis-020001 ofonod[736]: CRO
set_registration_cellid netreg->cellid: 1076227 ci: -1
2019-06-20T09:26:46.610671+00:00 klk-wiis-020001 ofonod[736]: CRO
network_get_properties netreg->cellid: -1


I see two ways to fix this problem:

1) modify QMI modem driver to remember LAC and CellId inside the driver.
When a notification arrives without CellId or LAC information, use
remembered information. The drawback of this solution is that these
information are remembered twice: in driver and in core.

2) modify core to add a way for drivers to say that these parameters are
not modified. The drawback of this solution is that it is a change in
core (even a change in core interface with drivers)


I assume that solution 1 is better of this problem is for QMI modems
only. I assume that solution 2 is better if some other drivers can have
the same kind of problems.

What do you think? How should I fix this problem? Will a change in
driver/core interface be helpful?


Best Regards,


Christophe Ronco




--===============2978381614463973098==--

